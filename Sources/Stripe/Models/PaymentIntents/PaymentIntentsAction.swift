//
//  PaymentIntentsAction.swift
//  App
//
//  Created by Ben Syverson on 2019/2/28.
//

import Foundation

/**
 next_action
 https://stripe.com/docs/api/payment_intents/object?lang=curl
*/

public struct PaymentIntentsAction: StripeModel {
    public var redirectToUrl: SourceRedirect?
    public var type: PaymentIntentsActionType?
    public var useStripeSDK: [String: String]?

    public enum CodingKeys: String, CodingKey {
        case redirectToUrl = "redirect_to_url"
        case type
        case useStripeSDK = "use_stripe_sdk"
    }
}
