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
            return try decoder.decode(StripeAPIError.self, from: response.body, maxSize: 65_536, on: worker).map(to: SM.self) { error in
                throw StripeError.apiError(error)
            }
        }
        
        return try decoder.decode(SM.self, from: response.body, maxSize: 65_536, on: worker)
    }
}

extension HTTPHeaderName {
    public static var stripeVersion: HTTPHeaderName {
        return .init("Stripe-Version")
    }
    public static var stripeAccount: HTTPHeaderName {
        return .init("Stripe-Version")
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
    
    init(httpClient: Client, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }
    
    public func send<SM: StripeModel>(method: HTTPMethod, path: String, query: String, body: String, headers: HTTPHeaders) throws -> Future<SM> {
        let encodedHTTPBody = HTTPBody(string: body)
        
        var finalHeaders: HTTPHeaders = .stripeDefault
        
        headers.forEach { finalHeaders.add(name: $0.name, value: $0.value) }
        
        finalHeaders.add(name: .authorization, value: "Bearer \(apiKey)")
        
        let request = HTTPRequest(method: method, url: URL(string: "\(path)?\(query)") ?? .root, headers: finalHeaders, body: encodedHTTPBody)
        
        return try httpClient.respond(to: Request(http: request, using: httpClient.container)).flatMap(to: SM.self) { (response) -> Future<SM> in
            return try self.serializedResponse(response: response.http, worker: self.httpClient.container.eventLoop)
        }
    }
}
