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
            return apiError.message ?? "Unknown Error"
        }
    }
}
//
//public enum StripeAPIErrorType: String, Codable {
//    case apiConnectionError(String)
//    case apiError(String)
//    case authenticationError(String)
//    case cardError(String)
//    case invalidRequestError(String)
//    case rateLimitError(String)
//
//    enum CodingKeys: String, CodingKey {
//        case apiConnectionError = "api_connection_error"
//        case apiError = "api_error"
//        case authenticationError = "authentication_error"
//        case cardError = "card_error"
//        case invalidRequestError = "invalid_request_error"
//        case rateLimitError = "rate_limit_error"
//    }
//}
//
//public enum StripeAPICardErrorType: String, Codable {
//    case invalidNumber(String)
//    case invalidExpiryMonth(String)
//    case invalidExpiryYear(String)
//    case invalidCVC(String)
//    case invalidSwipeData(String)
//    case incorrectNumber(String)
//    case expiredCard(String)
//    case incorrectCVC(String)
//    case incorrectZip(String)
//    case cardDeclined(String)
//    case missing(String)
//    case processingError(String)
//
//    enum CodingKeys: String, CodingKey {
//        case invalidNumber = "invalid_number"
//        case invalidExpiryMonth = "invalid_expiry_month"
//        case invalidExpiryYear = "invalid_expiry_year"
//        case invalidCVC = "invalid_cvc"
//        case invalidSwipeData = "invalid_swipe_data"
//        case incorrectNumber = "incorrect_number"
//        case expiredCard = "expired_card"
//        case incorrectCVC = "incorrect_cvc"
//        case incorrectZip = "incorrect_zip"
//        case cardDeclined = "card_declined"
//        case missing
//        case processingError = "processing_error"
//    }
//}
//
//public enum StripeAPIDeclineCode: String, Codable {
//    case approveWithId(String)
//    case callIssuer(String)
//    case cardNotSupported(String)
//    case cardVelocityExceeded(String)
//    case currencyNotSupported(String)
//    case doNotHonor(String)
//    case doNotTryAgain(String)
//    case duplicateTransaction(String)
//    case expiredCard(String)
//    case fradulent(String)
//    case genericDecline(String)
//    case incorrectNumber(String)
//    case incorrectCVC(String)
//    case incorrectPin(String)
//    case incorrectZip(String)
//    case insufficientFunds(String)
//    case invalidAccount(String)
//    case invalidAmount(String)
//    case invalidCVC(String)
//    case invalidExpiryYear(String)
//    case invalidNumber(String)
//    case invalidPin(String)
//    case issuerNotAvailable(String)
//    case lostCard(String)
//    case newAccountInformationAvailable(String)
//    case noActionTaken(String)
//    case notPermitted(String)
//    case pickupCard(String)
//    case pinTryExceeded(String)
//    case processingError(String)
//    case reenterTransaction(String)
//    case restrictedCard(String)
//    case revocationOfAllAuthorizations(String)
//    case revocationOfAuthorization(String)
//    case securityViolation(String)
//    case serviceNotAllowed(String)
//    case stolenCard(String)
//    case stopPaymentOrder(String)
//    case testmodeDecline(String)
//    case transactionNotAllowed(String)
//    case tryAgainLater(String)
//    case withdrawalCountLimitExceeded(String)
//
//    enum CodingKeys: String, CodingKey {
//        case approveWithId = "approve_with_id"
//        case callIssuer = "call_issuer"
//        case cardNotSupported = "card_not_supported"
//        case cardVelocityExceeded = "card_velocity_exceeded"
//        case currencyNotSupported = "currency_not_supported"
//        case doNotHonor = "do_not_honor"
//        case doNotTryAgain = "do_not_try_again"
//        case duplicateTransaction = "duplicate_transaction"
//        case expiredCard = "expired_card"
//        case fradulent
//        case genericDecline = "generic_decline"
//        case incorrectNumber = "incorrect_number"
//        case incorrectCVC = "incorrect_cvc"
//        case incorrectPin = "incorrect_pin"
//        case incorrectZip = "incorrect_zip"
//        case insufficientFunds = "insufficient_funds"
//        case invalidAccount = "invalid_account"
//        case invalidAmount = "invalid_amount"
//        case invalidCVC = "invalid_cvc"
//        case invalidExpiryYear = "invalid_expiry_year"
//        case invalidNumber = "invalid_number"
//        case invalidPin = "invalid_pin"
//        case issuerNotAvailable = "issuer_not_available"
//        case lostCard = "lost_card"
//        case newAccountInformationAvailable = "new_account_information_available"
//        case noActionTaken = "no_action_taken"
//        case notPermitted = "not_permitted"
//        case pickupCard = "pickup_card"
//        case pinTryExceeded = "pin_try_exceeded"
//        case processingError = "processing_error"
//        case reenterTransaction = "reenter_transaction"
//        case restrictedCard = "restricted_card"
//        case revocationOfAllAuthorizations = "revocation_of_all_authorizations"
//        case revocationOfAuthorization = "revocation_of_authorization"
//        case securityViolation = "security_violation"
//        case serviceNotAllowed = "service_not_allowed"
//        case stolenCard = "stolen_card"
//        case stopPaymentOrder = "stop_payment_order"
//        case testmodeDecline = "testmode_decline"
//        case transactionNotAllowed = "transaction_not_allowed"
//        case tryAgainLater = "try_again_later"
//        case withdrawalCountLimitExceeded = "withdrawal_count_limit_exceeded"
//    }
//}

