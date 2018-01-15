//
//  Verification.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

/**
 Legal entity verification object
 https://stripe.com/docs/api/curl#account_object-legal_entity-verification
 */

public protocol LegalEntityVerification {
    var details: String? { get }
    var detailsCode: LegalEntityVerificationState? { get }
    var document: String? { get }
    var status: LegalEntityVerificationStatus? { get }
}

public struct StripeLegalEntityVerification: LegalEntityVerification, StripeModelProtocol {
    public var details: String?
    public var detailsCode: LegalEntityVerificationState?
    public var document: String?
    public var status: LegalEntityVerificationStatus?
    
    enum CodingKeys: String, CodingKey {
        case details
        case detailsCode = "details_code"
        case document
        case status
    }
}
