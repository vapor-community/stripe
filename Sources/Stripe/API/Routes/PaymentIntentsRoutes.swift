//
//  PaymentIntentsRoutes.swift
//  Stripe
//
//  Created by Ben Syverson on 2019-02-28
//
//

import Vapor

public protocol PaymentIntentsRoutes {
    func create(amount: Int, currency: StripeCurrency, paymentMethodTypes: [SourceType], applicationFeeAmount: Int?, captureMethod: CaptureMethod?, confirm: Bool?, customer: String?, description: String?, metadata: [String : String]?, onBehalfOf: String?, receiptEmail: String?, returnUrl: String?, savePaymentMethod: Bool?, shipping: [String: Any]?, source: String?, statementDescriptor: String?, transferData: [String: Any]?, transferGroup: String?) throws -> Future<StripePaymentIntents>
    func retrieve(paymentIntents: String) throws -> Future<StripePaymentIntents>
    func update(paymentIntents: String, amount: Int?, applicationFeeAmount: Int?, currency: StripeCurrency?, customer: String?, description: String?, metadata: [String : String]?, paymentMethodTypes: [SourceType]?, receiptEmail: String?, returnUrl: String?, savePaymentMethod: Bool?, shipping: [String: Any]?, source: String?, transferData: [String: Any]?, transferGroup: String?) throws -> Future<StripePaymentIntents>
    func confirm(paymentIntents: String, clientSecret: String?, receiptEmail: String?, returnUrl: String?, savePaymentMethod: Bool?, shipping: [String: Any]?, source: String?) throws -> Future<StripePaymentIntents>
    func capture(paymentIntents: String, amountToCapture: Int?, applicationFeeAmount: Int?) throws -> Future<StripePaymentIntents>
    func cancel(paymentIntents: String, cancellationReason: CancellationReason?) throws -> Future<StripePaymentIntents>
    func listAll(filter: [String: Any]?) throws -> Future<StripePaymentIntents>
}

extension PaymentIntentsRoutes {
    public func create(amount: Int,
                       currency: StripeCurrency,
                       paymentMethodTypes: [SourceType] = [.card],
                       applicationFeeAmount: Int? = nil,
                       captureMethod: CaptureMethod? = nil,
                       confirm: Bool? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String : String]? = nil,
                       onBehalfOf: String? = nil,
                       receiptEmail: String? = nil,
                       returnUrl: String? = nil,
                       savePaymentMethod: Bool? = nil,
                       shipping: [String: Any]? = nil,
                       source: String? = nil,
                       statementDescriptor: String? = nil,
                       transferData: [String: Any]? = nil,
                       transferGroup: String? = nil) throws -> Future<StripePaymentIntents> {
        return try create(amount: amount,
                          currency: currency,
                          paymentMethodTypes: paymentMethodTypes,
                          applicationFeeAmount: applicationFeeAmount,
                          captureMethod: captureMethod,
                          confirm: confirm,
                          customer: customer,
                          description: description,
                          metadata: metadata,
                          onBehalfOf: onBehalfOf,
                          receiptEmail: receiptEmail,
                          returnUrl: returnUrl,
                          savePaymentMethod: savePaymentMethod,
                          shipping: shipping,
                          source: source,
                          statementDescriptor: statementDescriptor,
                          transferData: transferData,
                          transferGroup: transferGroup)
    }
    
    public func confirm(paymentIntents: String,
                       clientSecret: String? = nil,
                       receiptEmail: String? = nil,
                       returnUrl: String? = nil,
                       savePaymentMethod: Bool? = nil,
                       shipping: [String: Any]? = nil,
                       source: String? = nil) throws -> Future<StripePaymentIntents> {
        return try confirm(paymentIntents: paymentIntents,
                          clientSecret: clientSecret,
                          receiptEmail: receiptEmail,
                          returnUrl: returnUrl,
                          savePaymentMethod: savePaymentMethod,
                          shipping: shipping,
                          source: source)
    }
    
    public func capture(paymentIntents: String,
                        amountToCapture: Int? = nil,
                        applicationFeeAmount: Int? = nil) throws -> Future<StripePaymentIntents> {
        return try capture(paymentIntents: paymentIntents,
                           amountToCapture: amountToCapture,
                           applicationFeeAmount: applicationFeeAmount)
    }
    
    public func cancel(paymentIntents: String,
                        cancellationReason: CancellationReason? = nil) throws -> Future<StripePaymentIntents> {
        return try cancel(paymentIntents: paymentIntents,
                           cancellationReason: cancellationReason)
    }
    
    public func update(paymentIntents: String,
                       amount: Int? = nil,
                       applicationFeeAmount: Int? = nil,
                       currency: StripeCurrency? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String : String]? = nil,
                       paymentMethodTypes: [SourceType]? = nil,
                       receiptEmail: String? = nil,
                       returnUrl: String? = nil,
                       savePaymentMethod: Bool? = nil,
                       shipping: [String: Any]? = nil,
                       source: String? = nil,
                       transferData: [String: Any]? = nil,
                       transferGroup: String? = nil) throws -> Future<StripePaymentIntents> {
        return try update(paymentIntents: paymentIntents,
                          amount: amount,
                          applicationFeeAmount: applicationFeeAmount,
                          currency: currency,
                          customer: customer,
                          description: description,
                          metadata: metadata,
                          paymentMethodTypes: paymentMethodTypes,
                          receiptEmail: receiptEmail,
                          returnUrl: returnUrl,
                          savePaymentMethod: savePaymentMethod,
                          shipping: shipping,
                          source: source,
                          transferData: transferData,
                          transferGroup: transferGroup)
    }

    public func retrieve(id: String) throws -> Future<StripePaymentIntents> {
        return try retrieve(id: id)
    }
    
    public func listAll(filter: [String : Any]? = nil) throws -> Future<StripePaymentIntents> {
        return try listAll(filter: filter)
    }
}

public struct StripePaymentIntentsRoutes: PaymentIntentsRoutes {
    private let request: StripeRequest

    init(request: StripeRequest) {
        self.request = request
    }


    /// Create a PaymentIntents
    /// [Learn More →](https://stripe.com/docs/api/curl#create_charge)
    public func create(amount: Int,
                       currency: StripeCurrency,
                       paymentMethodTypes: [SourceType],
                       applicationFeeAmount: Int?,
                       captureMethod: CaptureMethod?,
                       confirm: Bool?,
                       customer: String?,
                       description: String?,
                       metadata: [String : String]?,
                       onBehalfOf: String?,
                       receiptEmail: String?,
                       returnUrl: String?,
                       savePaymentMethod: Bool?,
                       shipping: [String: Any]?,
                       source: String?,
                       statementDescriptor: String?,
                       transferData: [String: Any]?,
                       transferGroup: String?) throws -> Future<StripePaymentIntents> {
        var body: [String: Any] = ["amount": amount, "currency": currency.rawValue]
        
        for (index, method) in paymentMethodTypes.enumerated() {
            body["payment_method_types[\(index)]"] = method.rawValue
        }
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let captureMethod = captureMethod {
            body["capture_method"] = captureMethod.rawValue
        }
        
        if let confirm = confirm {
            body["confirm"] = confirm
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
        
        if let returnUrl = returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let savePaymentMethod = savePaymentMethod {
            body["save_payment_method"] = savePaymentMethod
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let source = source {
            body["source"] = source
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
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.paymentIntent.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a PaymentIntents
    /// [Learn More →](https://stripe.com/docs/api/payment_intents/retrieve?lang=curl)
    public func retrieve(paymentIntents: String) throws -> Future<StripePaymentIntents> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.paymentIntents(paymentIntents).endpoint)
    }

    /// Update a PaymentIntents
    /// [Learn More →](https://stripe.com/docs/api/payment_intents/update?lang=curl)
    public func update(paymentIntents: String,
                       amount: Int?,
                       applicationFeeAmount: Int?,
                       currency: StripeCurrency?,
                       customer: String?,
                       description: String?,
                       metadata: [String : String]?,
                       paymentMethodTypes: [SourceType]?,
                       receiptEmail: String?,
                       returnUrl: String?,
                       savePaymentMethod: Bool?,
                       shipping: [String: Any]?,
                       source: String?,
                       transferData: [String: Any]?,
                       transferGroup: String?) throws -> Future<StripePaymentIntents> {
        
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }

        if let currency = currency {
            body["currency"] = currency
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
        
        if let paymentMethodTypes = paymentMethodTypes {
            for (index, method) in paymentMethodTypes.enumerated() {
                body["payment_method_types[\(index)]"] = method.rawValue
            }
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let returnUrl = returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let savePaymentMethod = savePaymentMethod {
            body["save_payment_method"] = savePaymentMethod
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let source = source {
            body["source"] = source
        }
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }

        return try request.send(method: .POST, path: StripeAPIEndpoint.paymentIntents(paymentIntents).endpoint, body: body.queryParameters)
    }

    /// Confirm a PaymentIntents
    /// [Learn More →](https://stripe.com/docs/api/payment_intents/confirm?lang=curl)
    public func confirm(paymentIntents: String,
                        clientSecret: String? = nil,
                        receiptEmail: String? = nil,
                        returnUrl: String? = nil,
                        savePaymentMethod: Bool? = nil,
                        shipping: [String: Any]? = nil,
                        source: String? = nil) throws -> Future<StripePaymentIntents> {
        
        var body: [String: Any] = [:]
        
        if let clientSecret = clientSecret {
            body["client_secret"] = clientSecret
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let returnUrl = returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let savePaymentMethod = savePaymentMethod {
            body["save_payment_method"] = savePaymentMethod
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let source = source {
            body["source"] = source
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.paymentIntentsConfirm(paymentIntents).endpoint, body: body.queryParameters)
    }

    /// Capture a PaymentIntents
    /// [Learn More →](https://stripe.com/docs/api/payment_intents/capture?lang=curl)
    public func capture(paymentIntents: String,
                        amountToCapture: Int? = nil,
                        applicationFeeAmount: Int? = nil) throws -> Future<StripePaymentIntents> {
        
        var body: [String: Any] = [:]
        
        if let amountToCapture = amountToCapture {
            body["amount_to_capture"] = amountToCapture
        }
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.paymentIntentsCapture(paymentIntents).endpoint, body: body.queryParameters)
    }
    
    
    /// Cancel a PaymentIntents
    /// [Learn More →](https://stripe.com/docs/api/payment_intents/cancel?lang=curl)
    public func cancel(paymentIntents: String,
                       cancellationReason: CancellationReason? = nil) throws -> Future<StripePaymentIntents> {
        
        var body: [String: Any] = [:]
        
        if let cancellationReason = cancellationReason {
            body["cancellation_reason"] = cancellationReason.rawValue
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.paymentIntentsCancel(paymentIntents).endpoint, body: body.queryParameters)
    }
    
    /// List all PaymentIntents
    /// [Learn More →](https://stripe.com/docs/api/payment_intents/list?lang=curl)
    public func listAll(filter: [String : Any]?) throws -> Future<StripePaymentIntents> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try request.send(method: .GET, path: StripeAPIEndpoint.paymentIntent.endpoint, query: queryParams)
    }
}
