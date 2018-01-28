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
    func serializedResponse<SM: StripeModel>(response: HTTPResponse) throws -> SM
    func send<SM: StripeModel>(method: HTTPMethod, path: String, query: String, body: String, headers: HTTPHeaders) throws -> Future<SM>
}

public extension StripeRequest {

    public func send<SM: StripeModel>(method: HTTPMethod, path: String, query: String = "", body: String = "", headers: HTTPHeaders = [:]) throws -> Future<SM> {
        return try send(method: method, path: path, query: query, body: body, headers: headers)
    }
    
    public func serializedResponse<SM: StripeModel>(response: HTTPResponse) throws -> SM {
        let decoder = JSONDecoder()
        
        guard response.status == .ok  else
        {
            let error = try decoder.decode(StripeAPIError.self, from: response.body).requireCompleted()
            throw StripeError.apiError(error)
        }
        
        return try decoder.decode(SM.self, from: response.body).requireCompleted()
    }
}

public class StripeAPIRequest: StripeRequest {
    private let httpClient: Client
    private let apiKey: String
    private var StripeDefaultHeaders: HTTPHeaders = ["Stripe-Version": "2017-08-15", .contentType: "application/x-www-form-urlencoded"]
    
    init(httpClient: Client, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }
    
    public func send<SM: StripeModel>(method: HTTPMethod, path: String, query: String, body: String, headers: HTTPHeaders) throws -> Future<SM> {
        let encodedHTTPBody = HTTPBody(string: body)
        
        headers.forEach { StripeDefaultHeaders[$0.name] = $0.value }
        
        StripeDefaultHeaders[.authorization] = "Bearer \(apiKey)"
        
        let request = HTTPRequest(method: method, uri: URI(stringLiteral: path + "?" + query), headers: StripeDefaultHeaders, body: encodedHTTPBody)
        
        return try httpClient.respond(to: Request(http: request, using: httpClient.container)).map(to: SM.self) { (response) -> SM in
            return try self.serializedResponse(response: response.http)
        }
    }
}
