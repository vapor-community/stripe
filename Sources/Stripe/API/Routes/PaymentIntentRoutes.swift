//
//  PaymentIntentRoutes.swift
//  Stripe
//
//  Created by Kristian Andersen on 08/10/2019.
//

import Vapor

public protocol PaymentIntentsRoutes {
    /// Creates a PaymentIntent object.
    ///
    /// - Parameters:
    ///   - amount: A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - applicationFeeAmount: The amount of the application fee (if any) that will be applied to the payment and transferred to the application owner’s Stripe account. For more information, see the PaymentIntents Connect usage guide.
    ///   - captureMethod: Capture method of this PaymentIntent, one of `automatic` or `manual`.
    ///   - confirm: Set to `true` to attempt to confirm this PaymentIntent immediately. This parameter defaults to `false`. If the payment method attached is a card, a return_url may be provided in case additional authentication is required.
    ///   - confirmationMethod: One of `automatic` (default) or `manual`. /n When the confirmation method is `automatic`, a PaymentIntent can be confirmed using a publishable key. After `next_actions` are handled, no additional confirmation is required to complete the payment. /n When the confirmation method is` manual`, all payment attempts must be made using a secret key. The PaymentIntent will return to the `requires_confirmation` state after handling `next_actions`, and requires your server to initiate each payment attempt with an explicit confirmation. Read the expanded documentation to learn more about manual confirmation.
    ///   - customer: ID of the customer this PaymentIntent is for if one exists.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - onBehalfOf: The Stripe account ID for which these funds are intended. For details, see the PaymentIntents Connect usage guide.
    ///   - paymentMethod: ID of the payment method to attach to this PaymentIntent.
    ///   - paymentMethodTypes: The list of payment method types that this PaymentIntent is allowed to use. If this is not provided, defaults to `[“card”]`. Valid payment method types include: `card` and `card_present`.
    ///   - receiptEmail: Email address that the receipt for the resulting payment will be sent to.
    ///   - savePaymentMethod: Set to `true` to save the PaymentIntent’s payment method (either `source` or `payment_method`) to the associated customer. If the payment method is already attached, this parameter does nothing. This parameter defaults to `false` and applies to the payment method passed in the same request or the current payment method attached to the PaymentIntent and must be specified again if a new payment method is added.
    ///   - shipping: Shipping information for this PaymentIntent.
    ///   - source: ID of the Source object to attach to this PaymentIntent.
    ///   - statementDescriptor: Extra information about a PaymentIntent. This will appear on your customer’s statement when this PaymentIntent succeeds in creating a charge.
    ///   - transferData: The parameters used to automatically create a Transfer when the payment succeeds. For more information, see the PaymentIntents Connect usage guide.
    ///   - transferGroup: A string that identifies the resulting payment as part of a group. See the PaymentIntents Connect usage guide for details.
    /// - Returns: A `StripePaymentIntent`.
    func create(amount: Int,
                currency: StripeCurrency,
                applicationFeeAmount: Int?,
                captureMethod: PaymentIntentCaptureMethod?,
                confirm: Bool?,
                confirmationMethod: PaymentIntentConfirmationMethod?,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                onBehalfOf: String?,
                paymentMethod: String?,
                paymentMethodTypes: [String]?,
                receiptEmail: String?,
                savePaymentMethod: Bool?,
                shipping: [String: Any]?,
                source: String?,
                statementDescriptor: String?,
                transferData: [String: Any]?,
                transferGroup: String?) throws -> Future<PaymentIntent>

    /// Retrieves the details of a PaymentIntent that has previously been created.
    ///
    /// - Parameter id: The identifier of the paymentintent to be retrieved.
    /// - Returns: A `StripePaymentIntent`.
    func retrieve(id: String) throws -> Future<PaymentIntent>

    /// Updates a PaymentIntent object.
    ///
    /// - Parameters:
    ///   - id: The identifier of the paymentintent to be updated.
    ///   - amount: A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency.
    ///   - applicationFeeAmount: The amount of the application fee (if any) that will be applied to the payment and transferred to the application owner’s Stripe account. For more information, see the PaymentIntents Connect usage guide.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - customer: ID of the customer this PaymentIntent is for if one exists.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - paymentMethod: ID of the payment method to attach to this PaymentIntent.
    ///   - paymentMethodTypes: The list of payment method types that this PaymentIntent is allowed to use. If this is not provided, defaults to `[“card”]`. Valid payment method types include: `card` and `card_present`.
    ///   - receiptEmail: Email address that the receipt for the resulting payment will be sent to.
    ///   - savePaymentMethod: Set to `true` to save the PaymentIntent’s payment method (either `source` or `payment_method`) to the associated customer. If the payment method is already attached, this parameter does nothing. This parameter defaults to `false` and applies to the payment method passed in the same request or the current payment method attached to the PaymentIntent and must be specified again if a new payment method is added.
    ///   - shipping: Shipping information for this PaymentIntent.
    ///   - source: ID of the Source object to attach to this PaymentIntent.
    ///   - statementDescriptor: Extra information about a PaymentIntent. This will appear on your customer’s statement when this PaymentIntent succeeds in creating a charge.
    ///   - transferGroup: A string that identifies the resulting payment as part of a group. See the PaymentIntents Connect usage guide for details.
    /// - Returns: A `StripePaymentIntent`.
    func update(id: String,
                amount: Int?,
                applicationFeeAmount: Int?,
                currency: StripeCurrency?,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                paymentMethod: String?,
                paymentMethodTypes: [String]?,
                receiptEmail: String?,
                savePaymentMethod: Bool?,
                shipping: [String: Any]?,
                source: String?,
                statementDescriptor: String?,
                transferGroup: String?) throws -> Future<PaymentIntent>

    /// Confirm that your customer intends to pay with current or provided payment method. Upon confirmation, the PaymentIntent will attempt to initiate a payment. /n If the selected payment method requires additional authentication steps, the PaymentIntent will transition to the `requires_action` status and suggest additional actions via `next_action`. If payment fails, the PaymentIntent will transition to the `requires_payment_method` status. If payment succeeds, the PaymentIntent will transition to the `succeeded` status (or `requires_capture`, if `capture_method` is set to `manual`). /n If the `confirmation_method` is `automatic`, payment may be attempted using our client SDKs and the PaymentIntent’s client_secret. After `next_action`s are handled by the client, no additional confirmation is required to complete the payment. /n If the `confirmation_method` is `manual`, all payment attempts must be initiated using a secret key. If any actions are required for the payment, the PaymentIntent will return to the `requires_confirmation` state after those actions are completed. Your server needs to then explicitly re-confirm the PaymentIntent to initiate the next payment attempt. Read the expanded documentation to learn more about manual confirmation.
    ///
    /// - Parameters:
    ///   - id: The identifier of the paymentintent to be confirmed.
    ///   - paymentMethod: ID of the payment method to attach to this PaymentIntent.
    ///   - receiptEmail: Email address that the receipt for the resulting payment will be sent to.
    ///   - returnUrl: The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter is only used for cards and other redirect-based payment methods.
    ///   - savePaymentMethod: Set to `true` to save the PaymentIntent’s payment method (either `source` or `payment_method`) to the associated customer. If the payment method is already attached, this parameter does nothing. This parameter defaults to `false` and applies to the payment method passed in the same request or the current payment method attached to the PaymentIntent and must be specified again if a new payment method is added.
    ///   - shipping: Shipping information for this PaymentIntent.
    ///   - source: ID of the Source object to attach to this PaymentIntent.
    /// - Returns: A `StripePaymentIntent`.
    func confirm(id: String,
                 paymentMethod: String?,
                 receiptEmail: String?,
                 returnUrl: String?,
                 savePaymentMethod: Bool?,
                 shipping: [String: Any]?,
                 source: String?) throws -> Future<PaymentIntent>

    /// Capture the funds of an existing uncaptured PaymentIntent when its status is `requires_capture`. /n Uncaptured PaymentIntents will be canceled exactly seven days after they are created. /n Read the expanded documentation to learn more about separate authorization and capture.
    ///
    /// - Parameters:
    ///   - id: The identifier of the paymentintent to capture.
    ///   - amountToCapture: The amount to capture from the PaymentIntent, which must be less than or equal to the original amount. Any additional amount will be automatically refunded. Defaults to the full `amount_capturable` if not provided.
    ///   - applicationfeeAmount: The amount of the application fee (if any) that will be applied to the payment and transferred to the application owner’s Stripe account. For more information, see the PaymentIntents Connect usage guide.
    /// - Returns: A `StripePaymentIntent`.
    func capture(id: String, amountToCapture: Int?, applicationFeeAmount: Int?) throws -> Future<PaymentIntent>

    ///  PaymentIntent object can be canceled when it is in one of these statuses: `requires_payment_method`, `requires_capture`, `requires_confirmation`, `requires_action`. /n Once canceled, no additional charges will be made by the PaymentIntent and any operations on the PaymentIntent will fail with an error. For PaymentIntents with `status='requires_capture'`, the remaining `amount_capturable` will automatically be refunded.
    ///
    /// - Parameters:
    ///   - id: The identifier of the paymentintent to cancel.
    ///   - cancellationReason: Reason for canceling this PaymentIntent. If set, possible values are `duplicate`, `fraudulent`, `requested_by_customer`, or `failed_invoice`
    /// - Returns: A `StripePaymentIntent`.
    func cancel(id: String, cancellationReason: PaymentIntentCancellationReason?) throws -> Future<PaymentIntent>

    /// Returns a list of PaymentIntents.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/payment_intents/list).
    /// - Returns: A `StripePaymentIntentsList`.
    func listAll(filter: [String: Any]?) throws -> Future<PaymentIntentsList>
}

extension PaymentIntentsRoutes {
    public func create(amount: Int,
                       currency: StripeCurrency,
                       applicationFeeAmount: Int? = nil,
                       captureMethod: PaymentIntentCaptureMethod? = nil,
                       confirm: Bool? = nil,
                       confirmationMethod: PaymentIntentConfirmationMethod? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       onBehalfOf: String? = nil,
                       paymentMethod: String? = nil,
                       paymentMethodTypes: [String]? = nil,
                       receiptEmail: String? = nil,
                       savePaymentMethod: Bool? = nil,
                       shipping: [String: Any]? = nil,
                       source: String? = nil,
                       statementDescriptor: String? = nil,
                       transferData: [String: Any]? = nil,
                       transferGroup: String? = nil) throws -> Future<PaymentIntent> {
        return try create(amount: amount,
                          currency: currency,
                          applicationFeeAmount: applicationFeeAmount,
                          captureMethod: captureMethod,
                          confirm: confirm,
                          confirmationMethod: confirmationMethod,
                          customer: customer,
                          description: description,
                          metadata: metadata,
                          onBehalfOf: onBehalfOf,
                          paymentMethod: paymentMethod,
                          paymentMethodTypes: paymentMethodTypes,
                          receiptEmail: receiptEmail,
                          savePaymentMethod: savePaymentMethod,
                          shipping: shipping,
                          source: source,
                          statementDescriptor: statementDescriptor,
                          transferData: transferData,
                          transferGroup: transferGroup)
    }

    public func retrieve(id: String) throws -> Future<PaymentIntent> {
        return try retrieve(id: id)
    }

    public func update(id: String,
                       amount: Int? = nil,
                       applicationFeeAmount: Int? = nil,
                       currency: StripeCurrency? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       paymentMethod: String? = nil,
                       paymentMethodTypes: [String]? = nil,
                       receiptEmail: String? = nil,
                       savePaymentMethod: Bool? = nil,
                       shipping: [String: Any]? = nil,
                       source: String? = nil,
                       statementDescriptor: String? = nil,
                       transferGroup: String? = nil) throws -> Future<PaymentIntent> {
        return try update(id: id,
                          amount: amount,
                          applicationFeeAmount: applicationFeeAmount,
                          currency: currency,
                          customer: customer,
                          description: description,
                          metadata: metadata,
                          paymentMethod: paymentMethod,
                          paymentMethodTypes: paymentMethodTypes,
                          receiptEmail: receiptEmail,
                          savePaymentMethod: savePaymentMethod,
                          shipping: shipping,
                          source: source,
                          statementDescriptor: statementDescriptor,
                          transferGroup: transferGroup)
    }

    public func confirm(id: String,
                        paymentMethod: String? = nil,
                        receiptEmail: String? = nil,
                        returnUrl: String? = nil,
                        savePaymentMethod: Bool? = nil,
                        shipping: [String: Any]? = nil,
                        source: String? = nil) throws -> Future<PaymentIntent> {
        return try confirm(id: id,
                           paymentMethod: paymentMethod,
                           receiptEmail: receiptEmail,
                           returnUrl: returnUrl,
                           savePaymentMethod: savePaymentMethod,
                           shipping: shipping,
                           source: source)
    }

    public func capture(id: String, amountToCapture: Int? = nil, applicationFeeAmount: Int? = nil) throws -> Future<PaymentIntent> {
        return try capture(id: id, amountToCapture: amountToCapture, applicationFeeAmount: applicationFeeAmount)
    }

    public func cancel(id: String, cancellationReason: PaymentIntentCancellationReason? = nil) throws -> Future<PaymentIntent> {
        return try cancel(id: id, cancellationReason: cancellationReason)
    }

    public func listAll(filter: [String: Any]? = nil) throws -> Future<PaymentIntentsList> {
        return try listAll(filter: filter)
    }
}

public struct StripePaymentIntentsRoutes: PaymentIntentsRoutes {
    private let request: StripeRequest

    init(request: StripeRequest) {
        self.request = request
    }

    public func create(amount: Int,
                       currency: StripeCurrency,
                       applicationFeeAmount: Int?,
                       captureMethod: PaymentIntentCaptureMethod?,
                       confirm: Bool?,
                       confirmationMethod: PaymentIntentConfirmationMethod?,
                       customer: String?,
                       description: String?,
                       metadata: [String: String]?,
                       onBehalfOf: String?,
                       paymentMethod: String?,
                       paymentMethodTypes: [String]?,
                       receiptEmail: String?,
                       savePaymentMethod: Bool?,
                       shipping: [String: Any]?,
                       source: String?,
                       statementDescriptor: String?,
                       transferData: [String: Any]?,
                       transferGroup: String?) throws -> Future<PaymentIntent> {
        var body: [String: Any] = ["amount": amount,
                                   "currency": currency.rawValue]

        if let applicationfeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationfeeAmount
        }

        if let captureMethod = captureMethod {
            body["capture_method"] = captureMethod.rawValue
        }

        if let confirm = confirm {
            body["confirm"] = confirm
        }

        if let confirmationMethod = confirmationMethod {
            body["confirmation_method"] = confirmationMethod.rawValue
        }

        if let customer = customer {
            body["customer"] = customer
        }

        if let description = description {
            body["description"] = description
        }

        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let onBehalfOf = onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }

        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
        }

        if let paymentMethodTypes = paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }

        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
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

        return try request.send(method: .POST, path: StripeAPIEndpoint.paymentIntents.endpoint,
                                body: body.queryParameters)
    }

    public func retrieve(id: String) throws -> Future<PaymentIntent> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.paymentIntent(id).endpoint)
    }

    public func update(id: String,
                       amount: Int?,
                       applicationFeeAmount: Int?,
                       currency: StripeCurrency?,
                       customer: String?,
                       description: String?,
                       metadata: [String: String]?,
                       paymentMethod: String?,
                       paymentMethodTypes: [String]?,
                       receiptEmail: String?,
                       savePaymentMethod: Bool?,
                       shipping: [String: Any]?,
                       source: String?,
                       statementDescriptor: String?,
                       transferGroup: String?) throws -> Future<PaymentIntent> {
        var body: [String: Any] = [:]

        if let amount = amount {
            body["amount"] = amount
        }

        if let applicationfeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationfeeAmount
        }

        if let customer = customer {
            body["customer"] = customer
        }

        if let description = description {
            body["description"] = description
        }

        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
        }

        if let paymentMethodTypes = paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }

        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
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

        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }

        return try request.send(method: .POST, path: StripeAPIEndpoint.paymentIntent(id).endpoint,
                                body: body.queryParameters)
    }

    public func confirm(id: String,
                        paymentMethod: String?,
                        receiptEmail: String?,
                        returnUrl: String?,
                        savePaymentMethod: Bool?,
                        shipping: [String: Any]?,
                        source: String?) throws -> Future<PaymentIntent> {
        var body: [String: Any] = [:]

        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
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

        return try request.send(method: .POST, path: StripeAPIEndpoint.paymentIntentConfirm(id).endpoint,
                                body: body.queryParameters)
    }

    public func capture(id: String, amountToCapture: Int?, applicationFeeAmount: Int?) throws -> Future<PaymentIntent> {
        var body: [String: Any] = [:]

        if let amountToCapture = amountToCapture {
            body["amount_to_capture"] = amountToCapture
        }

        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }

        return try request.send(method: .POST, path: StripeAPIEndpoint.paymentIntentCapture(id).endpoint,
                                body: body.queryParameters)
    }

    public func cancel(id: String, cancellationReason: PaymentIntentCancellationReason?) throws -> Future<PaymentIntent> {
        var body: [String: Any] = [:]

        if let cancellationReason = cancellationReason {
            body["cancellation_reason"] = cancellationReason.rawValue
        }

        return try request.send(method: .POST, path: StripeAPIEndpoint.paymentIntentCancel(id).endpoint,
                                body: body.queryParameters)
    }

    public func listAll(filter: [String: Any]?) throws -> Future<PaymentIntentsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try request.send(method: .GET, path: StripeAPIEndpoint.paymentIntents.endpoint, query: queryParams)
    }
}

