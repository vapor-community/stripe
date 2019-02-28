//
//  PaymentIntentsSupport.swft
//  App
//
//  Created by Ben Syverson on 2019/2/28.
//

import Foundation

public enum CancellationReason: String, Codable {
    case duplicate
    case fraudulent
    case highest
    case requestedByCustomer = "requested_by_customer"
    case failedInvoice = "failed_invoice"
}

public enum CaptureMethod: String, Codable {
    case automatic
    case manual
}

public enum ConfirmationMethod: String, Codable {
    case secret
    case publishable
}

public enum PaymentIntentsStatus: String, Codable {
    case requiresPaymentMethod = "requires_payment_method"
    case requiresConfirmation = "requires_confirmation"
    case requiresAction = "requires_action"
    case processing
    case requiresAuthorization = "requires_authorization"
    case requiresCapture = "requires_capture"
    case canceled
    case succeeded
}

public enum PaymentIntentsActionType: String, Codable {
    case redirectToUrl = "redirect_to_url"
    case useStripeSDK = "use_stripe_sdk"
}
