//
//  Review.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/26/19.
//

import Vapor

/// The [Review Object](https://stripe.com/docs/api/radar/reviews/object).
public struct StripeReview: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The ZIP or postal code of the card used, if applicable.
    public var billingZip: String?
    /// The charge associated with this review.
    public var charge: String?
    /// The reason the review was closed, or null if it has not yet been closed. One of `approved`, `refunded`, `refunded_as_fraud`, or `disputed`.
    public var closedReason: StripeReviewReason?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The IP address where the payment originated.
    public var ipAddress: String?
    /// Information related to the location of the payment. Note that this information is an approximation and attempts to locate the nearest population center - it should not be used to determine a specific address.
    public var ipAddressLocation: StripeReviewIPAddressLocation?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// If `true`, the review needs action.
    public var open: Bool?
    /// The reason the review was opened. One of rule or manual.
    public var openedReason: StripeReviewReason?
    /// The PaymentIntent ID associated with this review, if one exists.
    public var paymentIntent: String?
    /// The reason the review is currently open or closed. One of `rule`, `manual`, `approved`, `refunded`, `refunded_as_fraud`, or `disputed`.
    public var reason: StripeReviewReason?
    /// Information related to the browsing session of the user who initiated the payment.
    public var session: StripeReviewSession?

    private enum CodingKeys: String, CodingKey {
        case id
        case object
        case billingZip = "billing_zip"
        case charge
        case closedReason = "closed_reason"
        case created
        case ipAddress = "ip_address"
        case ipAddressLocation = "ip_address_location"
        case livemode
        case open
        case openedReason = "opened_reason"
        case paymentIntent = "payment_intent"
        case reason
        case session
    }
}

public enum StripeReviewReason: String, StripeModel {
    case rule
    case manual
    case approved
    case refunded
    case refundedAsFraud = "refunded_as_fraud"
    case disputed
}

public struct StripeReviewIPAddressLocation: StripeModel {
    /// The city where the payment originated.
    public var city: String?
    /// Two-letter ISO code representing the country where the payment originated.
    public var country: String?
    /// The geographic latitude where the payment originated.
    public var latitude: Double?
    /// The geographic longitude where the payment originated.
    public var longitude: Double?
    /// The state/county/province/region where the payment originated.
    public var region: String?
}

public struct StripeReviewSession: StripeModel {
    /// The browser used in this browser session (e.g., `Safari`).
    public var browser: String?
    /// Information about the device used for the browser session (e.g., Samsung SM-G930T).
    public var device: String?
    /// The platform for the browser session (e.g., Macintosh).
    public var platform: String?
    /// The version for the browser session (e.g., 61.0.3163.100).
    public var version: String?
}

public struct StripeReviewList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeReview]?
    
    private enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
