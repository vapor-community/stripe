//
//  ChargeRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Vapor

public protocol ChargeRoutes {
    func create(amount: Int, currency: StripeCurrency, applicationFee: Int?, capture: Bool?, description: String?, destinationAccount: String?, destinationAmount: Int?, transferGroup: String?, onBehalfOf: String?, metadata: [String: String]?, receiptEmail: String?, shipping: ShippingLabel?, customer: String?, source: Any?, statementDescriptor: String?) throws -> Future<StripeCharge>
    func retrieve(charge: String) throws -> Future<StripeCharge>
    func update(charge: String, customer: String?, description: String?, fraudDetails: StripeFraudDetails?, metadata: [String: String]?, receiptEmail: String?, shipping: ShippingLabel?, transferGroup: String?) throws -> Future<StripeCharge>
    func capture(charge: String, amount: Int?, applicationFee: Int?, destinationAmount: Int?, receiptEmail: String?, statementDescriptor: String?) throws -> Future<StripeCharge>
    func listAll(filter: [String: Any]?) throws -> Future<ChargesList>
}

public struct StripeChargeRoutes: ChargeRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Create a charge
    /// [Learn More →](https://stripe.com/docs/api/curl#create_charge)
    public func create(amount: Int,
                       currency: StripeCurrency,
                       applicationFee: Int? = nil,
                       capture: Bool? = nil,
                       description: String? = nil,
                       destinationAccount: String? = nil,
                       destinationAmount: Int? = nil,
                       transferGroup: String? = nil,
                       onBehalfOf: String? = nil,
                       metadata: [String : String]? = nil,
                       receiptEmail: String? = nil,
                       shipping: ShippingLabel? = nil,
                       customer: String? = nil,
                       source: Any? = nil,
                       statementDescriptor: String? = nil) throws -> Future<StripeCharge> {
        var body: [String: Any] = ["amount": amount, "currency": currency.rawValue]
        
        if let applicationFee = applicationFee {
            body["application_fee"] = applicationFee
        }
        
        if let capture = capture {
            body["capture"] = capture
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let destinationAccount = destinationAccount {
            body["destination[account]"] = destinationAccount
        }
        
        if let destinationAmount = destinationAmount {
            body["destination[amount]"] = destinationAmount
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let onBehalfOf = onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1}
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let shipping = shipping {
            try shipping.toEncodedDictionary().forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let tokenSource = source as? String {
            body["source"] = tokenSource
        }
        
        if let cardDictionarySource = source as? [String: Any] {
            cardDictionarySource.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.charges.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a charge
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_charge)
    public func retrieve(charge: String) throws -> Future<StripeCharge> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.charge(charge).endpoint)
    }

    /// Update a charge
    /// [Learn More →](https://stripe.com/docs/api/curl#update_charge)
    public func update(charge chargeId: String,
                       customer: String? = nil,
                       description: String? = nil,
                       fraudDetails: StripeFraudDetails? = nil,
                       metadata: [String: String]? = nil,
                       receiptEmail: String? = nil,
                       shipping: ShippingLabel? = nil,
                       transferGroup: String? = nil) throws -> Future<StripeCharge> {
        var body: [String: Any] = [:]
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let fraud = fraudDetails {
            if let userReport = fraud.userReport?.rawValue {
                body["fraud_details[user_report]"] = userReport
            }
            
            if let stripeReport = fraud.stripeReport?.rawValue {
                body["fraud_details[stripe_report]"] = stripeReport
            }
        }
        
        if let metadata = metadata {
            metadata.forEach { key, value in
                body["metadata[\(key)]"] = value
            }
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let shipping = shipping {
            try shipping.toEncodedDictionary().forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.charge(chargeId).endpoint, body: body.queryParameters)
    }
    
    /// Capture a charge
    /// [Learn More →](https://stripe.com/docs/api/curl#capture_charge)
    public func capture(charge: String,
                        amount: Int? = nil,
                        applicationFee: Int? = nil,
                        destinationAmount: Int? = nil,
                        receiptEmail: String? = nil,
                        statementDescriptor: String? = nil) throws -> Future<StripeCharge> {
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let applicationFee = applicationFee {
            body["application_fee"] = applicationFee
        }
        
        if let destinationAmount = destinationAmount {
            body["destination[amount]"] = destinationAmount
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.captureCharge(charge).endpoint, body: body.queryParameters)
    }
    
    /// List all charges
    /// [Learn More →](https://stripe.com/docs/api/curl#list_charges)
    public func listAll(filter: [String : Any]? = nil) throws -> Future<ChargesList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try request.send(method: .GET, path: StripeAPIEndpoint.account.endpoint, query: queryParams)
    }
}
