//
//  StripeRequest.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation
import Vapor
import HTTP

public protocol StripeRequest: class {
    func serializedResponse<SM: StripeModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<SM>
    func send<SM: StripeModel>(method: HTTPMethod, path: String, query: String, body: String, headers: HTTPHeaders) throws -> Future<SM>
}

public extension StripeRequest {
    public func send<SM: StripeModel>(method: HTTPMethod, path: String, query: String = "", body: String = "", headers: HTTPHeaders = [:]) throws -> Future<SM> {
        return try send(method: method, path: path, query: query, body: body, headers: headers)
    }
    
    public func serializedResponse<SM: StripeModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<SM> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        guard response.status == .ok else {
            return try decoder.decode(StripeAPIError.self, from: response, maxSize: 65_536, on: worker).map(to: SM.self) { error in
                throw StripeError.apiError(error)
            }
        }
        
        return try decoder.decode(SM.self, from: response, maxSize: 65_536, on: worker)
    }
}

extension HTTPHeaderName {
    public static var stripeVersion: HTTPHeaderName {
        return .init("Stripe-Version")
    }
    public static var stripeAccount: HTTPHeaderName {
        return .init("Stripe-Account")
    }
}

extension HTTPHeaders {
    public static var stripeDefault: HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers.replaceOrAdd(name: .stripeVersion, value: "2018-02-28")
        headers.replaceOrAdd(name: .contentType, value: MediaType.urlEncodedForm.description)
        return headers
    }
}

public class StripeAPIRequest: StripeRequest {
    private let httpClient: Client
    private let apiKey: String
    private let testApiKey: String?
    
    init(httpClient: Client, apiKey: String, testApiKey: String?) {
        self.httpClient = httpClient
        self.apiKey = apiKey
        self.testApiKey = testApiKey
    }
    
    public func send<SM: StripeModel>(method: HTTPMethod, path: String, query: String, body: String, headers: HTTPHeaders) throws -> Future<SM> {
        var finalHeaders: HTTPHeaders = .stripeDefault
        
        headers.forEach { finalHeaders.add(name: $0.name, value: $0.value) }
        
        // Get the appropiate API key based on the environment and if the test key is present
        let apiKey = self.httpClient.container.environment == .development ? (self.testApiKey ?? self.apiKey) : self.apiKey
        finalHeaders.add(name: .authorization, value: "Bearer \(apiKey)")

        return httpClient.send(method, headers: finalHeaders, to: "\(path)?\(query)") { (request) in
            request.http.body = HTTPBody(string: body)            
            }.flatMap(to: SM.self) { (response) -> Future<SM> in
                return try self.serializedResponse(response: response.http, worker: self.httpClient.container.eventLoop)
        }
    }
}
