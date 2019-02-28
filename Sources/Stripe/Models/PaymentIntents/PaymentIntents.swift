//
//  PaymentIntents.swift
//  Stripe
//
//  Created by Ben Syverson on 2019-02-28.
//
//

import Foundation

/**
 Customer Model
 https://stripe.com/docs/api/curl#payment_intents
 */

public struct StripePaymentIntents: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int?
    public var amountCapturable: Int?
    public var amountReceived: Int?
    public var application: String?
    public var applicationFeeAmount: Int?
    public var canceledAt: Date?
    public var cancellationReason: CancellationReason?
    public var charges: ChargesList?
    public var clientSecret: String?
    public var confirmationMethod: ConfirmationMethod?
    public var created: Date?
    public var currency: StripeCurrency
    public var customer: String?
    public var description: String?
    public var lastPaymentError: StripeAPIError?
    public var livemode: Bool
    public var metadata: [String: String]
    public var nextAction: PaymentIntentsAction?
    public var onBehalfOf: String?
    public var paymentMethodTypes: [SourceType]?
    public var receiptEmail: String?
    public var review: String?
    public var shipping: ShippingLabel?
    public var source: String?
    public var statementDescriptor: String?
    public var status: PaymentIntentsStatus
    public var transferData: StripeChargeTransferData?
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
        case charges
        case clientSecret = "client_secret"
        case confirmationMethod = "confirmation_method"
        case created
        case currency
        case customer
        case description
        case lastPaymentError = "last_payment_error"
        case livemode
        case metadata
        case nextAction = "next_action"
        case onBehalfOf = "on_behalf_of"
        case paymentMethodTypes = "payment_method_types"
        case receiptEmail = "receipt_email"
        case review
        case shipping
        case source
        case statementDescriptor = "statement_descriptor"
        case status
        case transferData = "transfer_data"
        case transferGroup = "transfer_group"
    }
}
