//
//  Verification.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation
import Vapor

open class Verification: StripeModelProtocol {
    public private(set) var details: String?
    public private(set) var detailsCode: ConnectLegalEntityVerificationState?
    public private(set) var document: String?
    public private(set) var status: ConnectLegalEntityVerificationStatus?
    
    public required init(node: Node) throws {
        self.details = try node.get("details")
        if let detailsCode = node["details_code"]?.string {
            self.detailsCode = ConnectLegalEntityVerificationState(rawValue: detailsCode)
        }
        self.document = try node.get("document")
        if let status = node["status"]?.string {
            self.status = ConnectLegalEntityVerificationStatus(rawValue: status)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] =  [
            "details": self.details,
            "details_code": self.detailsCode?.rawValue,
            "document": self.document,
            "status": self.status?.rawValue
        ]
        
        return try Node(node: object)
    }
}
