//
//  StripeAPIError.swift
//  StripePackageDescription
//
//  Created by Andrew Edwards on 1/19/18.
//

import Foundation

public protocol APIError {
    //var type: StripeAPIErrorType { get }
    var charge: String? { get }
    var message: String? { get }
    //var code: StripeAPICardErrorType { get }
    //var declineCode: StripeAPIDeclineCode { get }
    var param: String? { get }
}

public struct StripeAPIError: APIError, StripeModel {
    //public var type: StripeAPIErrorType
    public var charge: String?
    public var message: String?
    //public var code: StripeAPICardErrorType?
    //public var declineCode: StripeAPIDeclineCode?
    public var param: String?
    
    enum CodingKeys: String, CodingKey {
       // case type
        case charge
        case message
       // case code
       // case declineCode = "decline_code"
        case param
    }
}
