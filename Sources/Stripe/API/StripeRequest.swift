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
    func serializedResponse<SM: StripeModel>(response: HTTPResponse) throws -> Future<SM>
    func send<SM: StripeModel>(method: HTTPMethod, path: String, query: String, body: String, headers: HTTPHeaders) throws -> Future<SM>
}

public extension StripeRequest {
    public func send<SM: StripeModel>(method: HTTPMethod, path: String, query: String = "", body: String = "", headers: HTTPHeaders = [:]) throws -> Future<SM> {
        return try send(method: method, path: path, query: query, body: body, headers: headers)
    }
    
    public func serializedResponse<SM: StripeModel>(response: HTTPResponse) throws -> Future<SM> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard response.status == .ok else {
            return try decoder.decode(StripeAPIError.self, from: response.body).map(to: SM.self) { error in
                throw StripeError.apiError(error)
            }
        }
        
        return try decoder.decode(SM.self, from: response.body)
    }
}

public class StripeAPIRequest: StripeRequest {
    private let httpClient: Client
    private let apiKey: String
    private let StripeDefaultHeaders: HTTPHeaders = ["Stripe-Version": "2018-02-28", .contentType: "application/x-www-form-urlencoded"]
    
    init(httpClient: Client, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }
    
    public func send<SM: StripeModel>(method: HTTPMethod, path: String, query: String, body: String, headers: HTTPHeaders) throws -> Future<SM> {
        let encodedHTTPBody = HTTPBody(string: body)
        
        var finalHeaders: HTTPHeaders = StripeDefaultHeaders
        
        headers.forEach { finalHeaders[$0.name] = $0.value }
        
        finalHeaders[.authorization] = "Bearer \(apiKey)"
        
        let request = HTTPRequest(method: method, uri: URI(stringLiteral: path + "?" + query), headers: StripeDefaultHeaders, body: encodedHTTPBody)
        
        return try httpClient.respond(to: Request(http: request, using: httpClient.container)).flatMap(to: SM.self) { (response) -> Future<SM> in
            return try self.serializedResponse(response: response.http)
        }
    }
}
