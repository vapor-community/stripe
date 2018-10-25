//
//  StripeError.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation
import Vapor
/**
 Error object
 https://stripe.com/docs/api#errors
 */

public enum StripeUploadError: Error, Debuggable {
    case unsupportedFileType
    
    public var localizedDescription: String {
        return "Unsupported file type used for file upload."
    }
    
    public var identifier: String {
        return "file-upload-error"
    }
    
    public var reason: String {
        return localizedDescription
    }
    
    public var possibleCauses: [String] {
        return ["Unsupported file type used for file upload."]
    }
    
    public var suggestedFixes: [String] {
        return ["Use one of the following supported filetypes for uploads.",
                "CSV",
                "DOCX",
                "GIF",
                "JPEG",
                "PDF",
                "PNG",
                "XLS",
                "XLSX"]
    }
}

public struct StripeError: StripeModel, Error, Debuggable {
    public var identifier: String {
        return self.error.type.rawValue
    }
    public var reason: String {
        return self.error.message
    }
    public var error: StripeAPIError
}

public struct StripeAPIError: StripeModel {
    public var type: StripeErrorType
    public var charge: String?
    public var code: StripeErrorCode?
    public var declineCode: StripeDeclineCode?
    public var docUrl: String?
    public var message: String
    public var param: String?
    
    public enum CodingKeys: String, CodingKey {
        case type
        case charge
        case code
        case declineCode = "decline_code"
        case docUrl = "doc_url"
        case message
        case param
    }
}


// https://stripe.com/docs/api#errors-type
public enum StripeErrorType: String, StripeModel {
    case apiConnectionError = "api_connection_error"
    case apiError = "api_error"
    case authenticationError = "authentication_error"
    case cardError = "card_error"
    case idempotencyError = "idempotency_error"
    case invalidRequestError = "invalid_request_error"
    case rateLimitError = "rate_limit_error"
    case validationError = "validation_error"
}

// https://stripe.com/docs/api#errors-code
// https://stripe.com/docs/error-codes
public enum StripeErrorCode: String, StripeModel {
    case accountAlreadyExists = "account_already_exists"
    case accountCountryInvalidAddress = "account_country_invalid_address"
    case accountInvalid = "account_invalid"
    case accountNumberInvalid = "account_number_invalid"
    case alipayUpgradeRequired = "alipay_upgrade_required"
    case amountTooLarge = "amount_too_large"
    case amountTooSmall = "amount_too_small"
    case apiKeyExpired = "api_key_expired"
    case balanceInsufficient = "balance_insufficient"
    case bankAccountExists = "bank_account_exists"
    case bankAccountUnusable = "bank_account_unsuable"
    case bankAccountUnverified = "bank_account_unverified"
    case bitcoinUpgradeRequired = "bitcoin_upgrade_required"
    case cardDeclined = "card_declined"
    case chargeAlreadyCaptured = "charge_already_captured"
    case chargeAlreadyRefunded = "charge_already_refunded"
    case chargeDisputed = "charge_disputed"
    case chargeExpiredForCapture = "charge_expired_for_capture"
    case countryUnsupported = "country_unsupported"
    case couponExpired = "coupon_expired"
    case customerMaxSubscriptions = "customer_max_subscriptions"
    case emailInvalid = "email_invalid"
    case expiredCard = "expired_card"
    case incorrectAddress = "incorrect_address"
    case incorrectCVC = "incorrect_cvc"
    case incorrectNumber = "incorrect_number"
    case incorrectZip = "incorrect_zip"
    case instantPayoutUnsupported = "instant_payouts_unsupported"
    case invalidCardType = "invalid_card_type"
    case invalidChargeAmount = "invalid_charge_amount"
    case invalidCVC = "invalid_cvc"
    case invalidExpiryMonth = "invalid_expiry_month"
    case invalidExpiryYear = "invalid_expiry_year"
    case invalidNumber = "invalid_number"
    case invalidSourceUsage = "invalid_source_usage"
    case invoiceNoCustomerLineItems = "invoice_no_customer_line_items"
    case invoiceNoSubscriptionLineItems = "invoice_no_subscription_line_items"
    case invoiceUpcomingNone = "invoice_upcoming_none"
    case livemodeMismatch = "livemode_mismatch"
    case missing
    case orderCreationFailed = "order_creation_failed"
    case orderRequiredSettings = "order_required_settings"
    case orderStatusInvalid = "order_status_invalid"
    case orderUpstreamTimeout = "order_upstream_timeout"
    case outOfInventory = "out_of_inventory"
    case parameterInvalidEmpty = "parameter_invalid_empty"
    case parameterInvalidInteger = "parameter_invalid_integer"
    case parameterInvalidStringBlank = "parameter_invalid_string_blank"
    case parameterInvalidStringEmpty = "parameter_invalid_string_empty"
    case parameterMissing = "parameter_missing"
    case parameterUnknown = "parameter_unknown"
    case paymentMethodUnactivated = "payment_method_unactivated"
    case payoutsNotAllowed = "payouts_not_allowed"
    case platformApiKeyExpired = "platform_api_key_expired"
    case postalCodeInvalid = "postal_code_invalid"
    case processingError = "processing_error"
    case productInactive = "product_inactive"
    case rateLimit = "rate_limit"
    case resourceAlreadyExists = "resource_already_exists"
    case resourceMissing = "resource_missing"
    case routingNumberInvalid = "routing_number_invalid"
    case secretKeyRequired = "secret_key_required"
    case sepaUnsupportedAccount = "sepa_unsupported_account"
    case shippingCalculationFailed = "shipping_calculation_failed"
    case skuInactive = "sku_inactive"
    case stateUnsupported = "state_unsupported"
    case taxIdInvalid = "tax_id_invalid"
    case taxesCalculationFailed = "taxes_calculation_failed"
    case testmodeChargesOnly = "testmode_charges_only"
    case tlsVersionUnsupported = "tls_version_unsupported"
    case tokenAlreadyUsed = "token_already_used"
    case tokenInUse = "token_in_use"
    case transfersNotAllowed = "transfers_not_allowed"
    case upstreamOrderCreationFailed = "upstream_order_creation_failed"
    case urlInvalid = "url_invalid"
}

// https://stripe.com/docs/api#errors-decline-code
// https://stripe.com/docs/declines/codes
public enum StripeDeclineCode: String, StripeModel {
    case approveWithId = "approve_with_id"
    case callIssuer = "call_issuer"
    case cardNotSupported = "card_not_supported"
    case cardVelocityExceeded = "card_velocity_exceeded"
    case currencyNotSupported = "currency_not_supported"
    case doNotHonor = "do_not_honor"
    case doNotTryAgain = "do_not_try_again"
    case duplicateTransaction = "duplicate_transaction"
    case expiredCard = "expired_card"
    case fradulent
    case genericDecline = "generic_decline"
    case incorrectNumber = "incorrect_number"
    case incorrectCVC = "incorrect_cvc"
    case incorrectPin = "incorrect_pin"
    case incorrectZip = "incorrect_zip"
    case insufficientFunds = "insufficient_funds"
    case invalidAccount = "invalid_account"
    case invalidAmount = "invalid_amount"
    case invalidCVC = "invalid_cvc"
    case invalidExpiryYear = "invalid_expiry_year"
    case invalidNumber = "invalid_number"
    case invalidPin = "invalid_pin"
    case issuerNotAvailable = "issuer_not_available"
    case lostCard = "lost_card"
    case newAccountInformationAvailable = "new_account_information_available"
    case noActionTaken = "no_action_taken"
    case notPermitted = "not_permitted"
    case pickupCard = "pickup_card"
    case pinTryExceeded = "pin_try_exceeded"
    case processingError = "processing_error"
    case reenterTransaction = "reenter_transaction"
    case restrictedCard = "restricted_card"
    case revocationOfAllAuthorizations = "revocation_of_all_authorizations"
    case revocationOfAuthorization = "revocation_of_authorization"
    case securityViolation = "security_violation"
    case serviceNotAllowed = "service_not_allowed"
    case stolenCard = "stolen_card"
    case stopPaymentOrder = "stop_payment_order"
    case testmodeDecline = "testmode_decline"
    case testModeLiveCard = "test_mode_live_card"
    case transactionNotAllowed = "transaction_not_allowed"
    case tryAgainLater = "try_again_later"
    case withdrawalCountLimitExceeded = "withdrawal_count_limit_exceeded"
}


