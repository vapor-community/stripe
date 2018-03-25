//
//  StripeError.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

public enum StripeError: Error {
    case malformedEncodedBody
    case malformedEncodedQuery
    case apiError(StripeAPIError)
    
    public var localizedDescription: String {
        switch self {
        case .malformedEncodedBody:
            return "The body for the request was malformed"
        case .malformedEncodedQuery:
            return "The query for the request was malformed"
        case .apiError(let apiError):
            return apiError.error.message ?? "Unknown Error"
        }
    }
}

// https://stripe.com/docs/api#errors-type
public enum StripeAPIErrorType: String, StripeModel {
    case apiConnectionError = "api_connection_error"
    case apiError = "api_error"
    case authenticationError = "authentication_error"
    case cardError = "card_error"
    case invalidRequestError = "invalid_request_error"
    case rateLimitError = "rate_limit_error"
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        guard let possible = StripeAPIErrorType(rawValue: try value.decode(String.self)) else {
           throw DecodingError.typeMismatch(StripeAPIErrorType.self, DecodingError.Context(codingPath: [], debugDescription: "Unknown error type returned from stripe."))
        }
        self = possible
    }
}

// https://stripe.com/docs/api#errors-code
public enum StripeAPICardErrorType: String, StripeModel {
    case invalidNumber = "invalid_number"
    case invalidExpiryMonth = "invalid_expiry_month"
    case invalidExpiryYear = "invalid_expiry_year"
    case invalidCVC = "invalid_cvc"
    case invalidSwipeData = "invalid_swipe_data"
    case incorrectNumber = "incorrect_number"
    case expiredCard = "expired_card"
    case incorrectCVC = "incorrect_cvc"
    case incorrectZip = "incorrect_zip"
    case cardDeclined = "card_declined"
    case missing
    case processingError = "processing_error"
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        guard let possible = StripeAPICardErrorType(rawValue: try value.decode(String.self)) else {
            throw DecodingError.typeMismatch(StripeAPICardErrorType.self, DecodingError.Context(codingPath: [], debugDescription: "Unknown card error returned from stripe."))
        }
        self = possible
    }
}

// https://stripe.com/docs/api#errors-decline-code
public enum StripeAPIDeclineCode: String, StripeModel {
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
    case transactionNotAllowed = "transaction_not_allowed"
    case tryAgainLater = "try_again_later"
    case withdrawalCountLimitExceeded = "withdrawal_count_limit_exceeded"
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        guard let possible = StripeAPIDeclineCode(rawValue: try value.decode(String.self)) else {
            throw DecodingError.typeMismatch(StripeAPIDeclineCode.self, DecodingError.Context(codingPath: [], debugDescription: "Unknown decline code returned from stripe."))
        }
        self = possible
    }
}
