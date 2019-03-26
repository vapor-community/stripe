//
//  CountrySpecRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

import Vapor

public protocol CountrySpecRoutes {
    /// Lists all Country Spec objects available in the API.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/country_specs/list)
    /// - Returns: A `StripeCountrySpecList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeCountrySpecList>
    
    /// Returns a Country Spec for a given Country code.
    ///
    /// - Parameter country: An ISO 3166-1 alpha-2 country code. Available country codes can be listed with the [List Country Specs](https://stripe.com/docs/api#list_country_specs) endpoint.
    /// - Returns: A `StripeCountrySpec`.
    /// - Throws: A `StripeError`.
    func retrieve(country: String) throws -> EventLoopFuture<StripeCountrySpec>
}

extension CountrySpecRoutes {
    public func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeCountrySpecList> {
        return try listAll(filter: filter)
    }
    
    public func retrieve(country: String) throws -> EventLoopFuture<StripeCountrySpec> {
        return try retrieve(country: country)
    }
}

public struct StripeCountrySpecRoutes: CountrySpecRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeCountrySpecList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.countrySpec.endpoint, query: queryParams)
    }
    
    public func retrieve(country: String) throws -> EventLoopFuture<StripeCountrySpec> {
         return try request.send(method: .GET, path: StripeAPIEndpoint.countrySpecs(country).endpoint)
    }
}
