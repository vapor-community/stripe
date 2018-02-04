//
//  DisputeEvidence.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/7/17.
//

/**
 DisputeEvidence object
 https://stripe.com/docs/api#dispute_evidence_object
 */

public protocol DisputeEvidence {
    var accessActivityLog: String? { get }
    var billingAddress: String? { get }
    var cancellationPolicy: String? { get }
    var cancellationPolicyDisclosure: String? { get }
    var cancellationRebuttal: String? { get }
    var customerCommunication: String? { get }
    var customerEmailAddress: String? { get }
    var customerName: String? { get }
    var customerPurchaseIp: String? { get }
    var customerSignature: String? { get }
    var duplicateChargeDocumantation: String? { get }
    var duplicateChargeExplination: String? { get }
    var duplicateChargeId: String? { get }
    var productDescription: String? { get }
    var receipt: String? { get }
    var refundPolicy: String? { get }
    var refundPolicyDisclosure: String? { get }
    var refundRefusalExplination: String? { get }
    var serviceDate: String? { get }
    var serviceDocumentation: String? { get }
    var shippingAddress: String? { get }
    var shippingCarrier: String? { get }
    var shippingDate: String? { get }
    var shippingDocumentation: String? { get }
    var shippingTrackingNumber: String? { get }
    var uncatagorizedFile: String? { get }
    var uncatagorizedText: String? { get }
}

public struct StripeDisputeEvidence: DisputeEvidence, StripeModel {
    public var accessActivityLog: String?
    public var billingAddress: String?
    public var cancellationPolicy: String?
    public var cancellationPolicyDisclosure: String?
    public var cancellationRebuttal: String?
    public var customerCommunication: String?
    public var customerEmailAddress: String?
    public var customerName: String?
    public var customerPurchaseIp: String?
    public var customerSignature: String?
    public var duplicateChargeDocumantation: String?
    public var duplicateChargeExplination: String?
    public var duplicateChargeId: String?
    public var productDescription: String?
    public var receipt: String?
    public var refundPolicy: String?
    public var refundPolicyDisclosure: String?
    public var refundRefusalExplination: String?
    public var serviceDate: String?
    public var serviceDocumentation: String?
    public var shippingAddress: String?
    public var shippingCarrier: String?
    public var shippingDate: String?
    public var shippingDocumentation: String?
    public var shippingTrackingNumber: String?
    public var uncatagorizedFile: String?
    public var uncatagorizedText: String?
}
