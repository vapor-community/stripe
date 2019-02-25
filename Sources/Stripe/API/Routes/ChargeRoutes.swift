//
//  ChargeRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Vapor

public protocol ChargeRoutes {
    func create(amount: Int,
                currency: StripeCurrency,
                applicationFeeAmount: Int?,
                capture: Bool?,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                onBehalfOf: String?,
                receiptEmail: String?,
                shipping: [String: Any]?,
                source: Any?,
                statementDescriptor: String?,
                transferData: [String: Any]?,
                transferGroup: String?) throws -> Future<StripeCharge>
    func retrieve(charge: String) throws -> Future<StripeCharge>
    func update(charge: String,
                customer: String?,
                description: String?,
                fraudDetails: [String: Any]?,
                metadata: [String: String]?,
                receiptEmail: String?,
                shipping: [String: Any]?,
                transferGroup: String?) throws -> Future<StripeCharge>
    func capture(charge: String, amount: Int?, applicationFee: Int?, destinationAmount: Int?, receiptEmail: String?, statementDescriptor: String?) throws -> Future<StripeCharge>
    func listAll(filter: [String: Any]?) throws -> Future<ChargesList>
}

extension ChargeRoutes {
    public func create(amount: Int,
                       currency: StripeCurrency,
                       applicationFeeAmount: Int? = nil,
                       capture: Bool? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       onBehalfOf: String? = nil,
                       receiptEmail: String? = nil,
                       shipping: [String: Any]? = nil,
                       source: Any? = nil,
                       statementDescriptor: String? = nil,
                       transferData: [String: Any]? = nil,
                       transferGroup: String? = nil) throws -> Future<StripeCharge> {
        return try create(amount: amount,
                          currency: currency,
                          applicationFeeAmount: applicationFeeAmount,
                          capture: capture,
                          customer: customer,
                          description: description,
                          metadata: metadata,
                          onBehalfOf: onBehalfOf,
                          receiptEmail: receiptEmail,
                          shipping: shipping,
                          source: source,
                          statementDescriptor: statementDescriptor,
                          transferData: transferData,
                          transferGroup: transferGroup)
    }
    
    public func retrieve(charge: String) throws -> Future<StripeCharge> {
        return try retrieve(charge: charge)
    }
    
    public func update(charge chargeId: String,
                       customer: String? = nil,
                       description: String? = nil,
                       fraudDetails: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       receiptEmail: String? = nil,
                       shipping: [String: Any]? = nil,
                       transferGroup: String? = nil) throws -> Future<StripeCharge> {
        return try update(charge: chargeId,
                          customer: customer,
                          description: description,
                          fraudDetails: fraudDetails,
                          metadata: metadata,
                          receiptEmail: receiptEmail,
                          shipping: shipping,
                          transferGroup: transferGroup)
    }
    
    public func capture(charge: String,
                        amount: Int? = nil,
                        applicationFee: Int? = nil,
                        destinationAmount: Int? = nil,
                        receiptEmail: String? = nil,
                        statementDescriptor: String? = nil) throws -> Future<StripeCharge> {
        return try capture(charge: charge,
                           amount: amount,
                           applicationFee: applicationFee,
                           destinationAmount: destinationAmount,
                           receiptEmail: receiptEmail,
                           statementDescriptor: statementDescriptor)
    }
    
    public func listAll(filter: [String : Any]? = nil) throws -> Future<ChargesList> {
        return try listAll(filter: filter)
    }
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
                       applicationFeeAmount: Int?,
                       capture: Bool?,
                       customer: String?,
                       description: String?,
                       metadata: [String: String]?,
                       onBehalfOf: String?,
                       receiptEmail: String?,
                       shipping: [String: Any]?,
                       source: Any?,
                       statementDescriptor: String?,
                       transferData: [String: Any]?,
                       transferGroup: String?) throws -> Future<StripeCharge> {
        var body: [String: Any] = ["amount": amount, "currency": currency.rawValue]
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let capture = capture {
            body["capture"] = capture
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1}
        }
       
        if let onBehalfOf = onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let shipping = shipping {
           shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let tokenSource = source as? String {
            body["source"] = tokenSource
        }
        
        if let hashSource = source as? [String: Any] {
            hashSource.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
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
                       customer: String?,
                       description: String?,
                       fraudDetails: [String: Any]?,
                       metadata: [String: String]?,
                       receiptEmail: String?,
                       shipping: [String: Any]?,
                       transferGroup: String?) throws -> Future<StripeCharge> {
        var body: [String: Any] = [:]
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let fraud = fraudDetails {
            fraud.forEach { body["fraud_details[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.charge(chargeId).endpoint, body: body.queryParameters)
    }
    
    /// Capture a charge
    /// [Learn More →](https://stripe.com/docs/api/curl#capture_charge)
    public func capture(charge: String,
                        amount: Int?,
                        applicationFee: Int?,
                        destinationAmount: Int?,
                        receiptEmail: String?,
                        statementDescriptor: String?) throws -> Future<StripeCharge> {
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
    public func listAll(filter: [String : Any]?) throws -> Future<ChargesList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.charges.endpoint, query: queryParams)
    }
}
