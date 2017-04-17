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
import Models
import Errors

internal enum HTTPMethod {
    case get
    case post
    case patch
    case put
    case delete
}

public class StripeRequest<T : StripeModelProtocol> {
    var client: StripeClient!
    var response: HTTP.Response!
    let httpClient = EngineClient.factory

    init(client: StripeClient, method: HTTPMethod = .get, route: API, query: [String : NodeRepresentable] = [:], body: BodyRepresentable?, headers: [HeaderKey : String]? = nil) throws {
        self.client = client

        var allHeaders = DefaultHeaders
        allHeaders[StripeHeader.Authorization] = "Bearer \(self.client.apiKey)"
        
        if let headers = headers {
            headers.forEach {
                allHeaders[$0.key] = $0.value
            }
        }

        switch method {
        case .get: self.response = try self.httpClient.get(route.endpoint, query: query, allHeaders, body, through: [])
        case .post: self.response = try self.httpClient.post(route.endpoint, query: query, allHeaders, body, through: [])
        case .patch: self.response = try self.httpClient.patch(route.endpoint, query: query, allHeaders, body, through: [])
        case .put: self.response = try self.httpClient.put(route.endpoint, query: query, allHeaders, body, through: [])
        case .delete: self.response = try self.httpClient.delete(route.endpoint, query: query, allHeaders, body, through: [])
        }
    }

    @discardableResult
    public func serializedResponse() throws -> T {
        guard self.response.status == .ok else {
            guard let error = self.response.json?["error"]?.object else { throw self.response.status }
            guard let type = error["type"]?.string else { throw self.response.status }
            switch type {
            case "api_connection_error":  throw StripeError.apiConnectionError
            case "api_error":             throw StripeError.apiError
            case "authentication_error":  throw StripeError.authenticationError
            case "card_error":            throw StripeError.cardError
            case "invalid_request_error": throw StripeError.invalidRequestError(try self.response.json?.get("error"))
            case "rate_limit_error":      throw StripeError.rateLimitError
            case "validation_error":      throw StripeError.validationError
            default:                      throw self.response.status
            }
        }
        guard let value = self.response.json else { throw StripeError.serializationError }
        return try T(node: value)
    }

}
