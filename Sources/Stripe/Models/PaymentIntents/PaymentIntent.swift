//
//  PaymentIntent.swift
//  Stripe
//
//  Created by Kristian Andersen on 08/10/2019.
//

import Foundation

/// The [PaymentIntent Object](https://stripe.com/docs/api/payment_intents/object).
public struct PaymentIntent: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount intended to be collected by this PaymentIntent.
    public var amount: Int?
    /// Amount that can be captured from this PaymentIntent.
    public var amountCapturable: Int?
    /// Amount that was collected by this PaymentIntent.
    public var amountReceived: Int?
    /// ID of the Connect application that created the PaymentIntent.
    public var application: String?
    /// The amount of the application fee (if any) for the resulting payment. See the PaymentIntents [Connect usage guide](https://stripe.com/docs/payments/payment-intents/usage#connect) for details.
    public var applicationFeeAmount: Int?
    /// Populated when `status` is `canceled`, this is the time at which the PaymentIntent was canceled. Measured in seconds since the Unix epoch.
    public var canceledAt: Date?
    /// User-given reason for cancellation of this PaymentIntent, one of `duplicate`, `fraudulent`, `requested_by_customer`, or `failed_invoice`.
    public var cancellationReason: PaymentIntentCancellationReason?
    /// Capture method of this PaymentIntent, one of `automatic` or `manual`.
    public var captureMethod: PaymentIntentCaptureMethod?
    /// Charges that were created by this PaymentIntent, if any.
    public var charges: ChargesList?
    /// The client secret of this PaymentIntent. Used for client-side retrieval using a publishable key. Please refer to [dynamic authentication](https://stripe.com/docs/payments/dynamic-authentication) guide on how `client_secret` should be handled.
    public var clientSecret: String?
    /// Confirmation method of this PaymentIntent, one of `manual` or `automatic`.
    public var confirmationMethod: PaymentIntentConfirmationMethod?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// ID of the Customer this PaymentIntent is for if one exists.
    public var customer: String?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// ID of the invoice that created this PaymentIntent, if it exists.
    public var invoice: String?
    /// The payment error encountered in the previous PaymentIntent confirmation.
    public var lastPaymentError: StripeError?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// If present, this property tells you what actions you need to take in order for your customer to fulfill a payment using the provided source.
    public var StripePaymentIntentNextAction: String?
    /// The account (if any) for which the funds of the PaymentIntent are intended. See the PaymentIntents Connect usage guide for details.
    public var onBehalfOn: String?
    /// ID of the payment method used in this PaymentIntent.
    public var paymentMethod: String?
    /// The list of payment method types (e.g. card) that this PaymentIntent is allowed to use.
    public var paymentMethodTypes: [String]?
    /// Email address that the receipt for the resulting payment will be sent to.
    public var receiptEmail: String?
    /// ID of the review associated with this PaymentIntent, if any.
    public var review: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    /// If present, the payment method used with this PaymentIntent can be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer, even after the transaction completes
    ///
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow. Use `off_session` if your customer may or may not be in your checkout flow. See [Saving card details after a payment](https://stripe.com/docs/payments/cards/saving-cards#saving-card-after-payment) to learn more.
    ///
    /// Stripe uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules. For example, if your customer is impacted by [SCA](https://stripe.com/docs/strong-customer-authentication), using off_session will ensure that they are authenticated while processing this PaymentIntent. You will then be able to collect [off-session payments](https://stripe.com/docs/payments/cards/charging-saved-cards#off-session-payments-with-saved-cards) for this customer.
    public var setupFutureUsage: String?
    /// Shipping information for this PaymentIntent.
    public var shipping: ShippingLabel?
    /// ID of the source used in this PaymentIntent.
    public var source: String?
    /// Extra information about a PaymentIntent. This will appear on your customer’s statement when this PaymentIntent succeeds in creating a charge.
    public var statementDescriptor: String?
    /// Status of this PaymentIntent, one of `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `requires_capture`, `canceled`, or `succeeded`.
    public var status: PaymentIntentStatus?
    /// The data with which to automatically create a Transfer when the payment is finalized. See the PaymentIntents Connect usage guide for details.
    public var transferData: [String: String]?
    /// A string that identifies the resulting payment as part of a group. See the PaymentIntents Connect usage guide for details.
    public var transferGroup: String?

    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case amountCapturable = "amount_capturable"
        case amountReceived = "amount_received"
        case application
        case applicationFeeAmount = "application_fee_amount"
        case canceledAt = "canceled_at"
        case cancellationReason = "cancellation_reason"
        case captureMethod = "capture_method"
        case charges
        case clientSecret = "client_secret"
        case confirmationMethod = "confirmation_method"
        case created
        case currency
        case customer
        case description
        case invoice
        case lastPaymentError = "last_payment_error"
        case livemode
        case metadata
        case StripePaymentIntentNextAction = "next_action"
        case onBehalfOn = "on_behalf_of"
        case paymentMethod = "payment_method"
        case paymentMethodTypes = "payment_method_types"
        case receiptEmail = "receipt_email"
        case review
        case setupFutureUsage = "setup_future_usage"
        case shipping
        case source
        case statementDescriptor = "statement_descriptor"
        case status
        case transferData = "transfer_data"
        case transferGroup = "transfer_group"
    }
}

public enum PaymentIntentCancellationReason: String, StripeModel {
    case duplicate
    case fraudulent
    case requestedByCustomer = "requested_by_customer"
    case failedInvoice = "failed_invoice"
}

public enum PaymentIntentCaptureMethod: String, StripeModel {
    case automatic
    case manual
}

public enum PaymentIntentConfirmationMethod: String, StripeModel {
    case automatic
    case manual
}

public struct PaymentIntentNextAction: StripeModel {
    /// Contains instructions for authenticating a payment by redirecting your customer to another page or application.
    public var redirectToUrl: PaymentIntentNextActionRedirectToUrl?
    /// Type of the next action to perform, one of `redirect_to_url` or `use_stripe_sdk`.
    public var type: PaymentIntentNextActionType?
}

public struct PaymentIntentNextActionRedirectToUrl: StripeModel {
    /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
    public var returnUrl: String?
    /// The URL you must redirect your customer to in order to authenticate the payment.
    public var url: String?
    /**
     https://stripe.com/docs/api/payment_intents/object#payment_intent_object-next_action-use_stripe_sdk
     Stripe .net doesn't implement the `use_stripe_sdk` property (probably due to its dynamic nature) so neither am I :)
     https://github.com/stripe/stripe-dotnet/blob/master/src/Stripe.net/Entities/PaymentIntents/PaymentIntentNextAction.cs
     */
}

public enum PaymentIntentNextActionType: String, StripeModel {
    case redirectToUrl = "redirect_to_url"
    case useStripeSDK = "use_stripe_sdk"
}

public enum PaymentIntentStatus: String, StripeModel {
    case requiresPaymentMethod = "requires_payment_method"
    case requiresConfirmation = "requires_confirmation"
    case requiresAction = "requires_action"
    case processing
    case requiresCapture = "requires_capture"
    case canceled
    case succeeded
}

public struct PaymentIntentsList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [PaymentIntent]?

    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
