//
//  Person.swift
//  Stripe
//
//  Created by Andrew Edwards on 2/24/19.
//

import Foundation

public struct StripePerson: StripeModel {
    public var id: String
    public var object: String
    public var account: String?
    public var address: StripeAddress?
    public var created: Date?
    public var dob: StripePersonDOB?
    public var email: String?
    public var firstName: String?
    public var gender: StripePersonGender?
    public var idNumberProvided: Bool?
    public var lastName: String?
    public var maidenName: String?
    public var metadata: [String: String]
    public var phone: String?
    public var verification: StripePersonVerification?
    public var status: StripePersonVerificationStatus?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case object
        case account
        case address
        case created
        case dob
        case email
        case firstName = "first_name"
        case gender
        case idNumberProvided = "id_number_provided"
        case lastName = "last_name"
        case maidenName = "maiden_name"
        case metadata
        case phone
        case verification
        case status
    }
}

public struct StripePersonDOB: StripeModel {
    public var day: Int?
    public var month: Int?
    public var year: Int?
}

public enum StripePersonGender: String, StripeModel {
    case male
    case female
}

public struct StripePersonRelationship: StripeModel {
    public var accountOpener: Bool?
    public var director: Bool?
    public var owner: Bool?
    public var percentOwnership: Decimal?
    public var title: String?
    
    private enum CodingKeys: String, CodingKey {
        case accountOpener = "account_opener"
        case director
        case owner
        case percentOwnership = "percent_ownership"
        case title
    }
}

public struct StripePersonRequirements: StripeModel {
    public var currentlyDue: [String]?
    public var eventuallyDue: [String]?
    public var pastDue: [String]?
    public var ssnLast4Provided: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case currentlyDue = "currently_due"
        case eventuallyDue = "eventually_due"
        case pastDue = "past_due"
        case ssnLast4Provided = "ssn_last_4_provided"
    }
}

public struct StripePersonVerification: StripeModel {
    public var details: String?
    public var detailsCode: StripePersonVerificationDetailsCode?
    public var document: StripePersonVerificationDocument?
    
    private enum CodingKeys: String, CodingKey {
        case details
        case detailsCode = "details_code"
        case document
    }
}

public enum StripePersonVerificationDetailsCode: String, StripeModel {
    case scanNameMismatch = "scan_name_mismatch"
    case failedKeyedIdentity = "failed_keyed_identity"
    case failedOther = "failed_other"
}


public struct StripePersonVerificationDocument: StripeModel {
    public var back: String?
    public var details: String?
    public var detailsCode: StripePersonVerificationDocumentDetailsCode?
    public var front: String?
    
    private enum CodingKeys: String, CodingKey {
        case back
        case details
        case detailsCode = "datails_code"
        case front
    }
}

public enum StripePersonVerificationDocumentDetailsCode: String, StripeModel {
    case documentCorrupt = "document_corrupt"
    case documentFailedCopy = "document_failed_copy"
    case documentNotReadable = "document_not_readable"
    case documentFailedGreyscale = "document_failed_greyscale"
    case documentNotUploaded = "document_not_uploaded"
    case documentIdTypeNotSupported = "document_id_type_not_supported"
    case documentIdCountryNotSupported = "document_id_country_not_supported"
    case documentFailedOther = "document_failed_other"
    case documentFraudulent = "document_fraudulent"
    case documentInvalid = "document_invalid"
    case documentManipulated = "document_manipulated"
    case documentMissingBack = "document_missing_back"
    case documentMissingFront = "document_missing_front"
    case documentPhotoMismatch = "document_photo_mismatch"
    case documentTooLarge = "document_too_large"
    case documentFailedTestMode = "document_failed_test_mode"
}

public enum StripePersonVerificationStatus: String, StripeModel {
    case unverified
    case pending
    case verified
}
