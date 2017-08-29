//
//  Dispute.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/11/17.
//
//

import Foundation
import Vapor


public final class Dispute: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amount: Int?
    public private(set) var balanceTransactions: [BalanceTransactionItem]?
    public private(set) var charge: String?
    public private(set) var created: Date?
    public private(set) var currency: StripeCurrency?
    public private(set) var evidence: DisputeEvidence?
    public private(set) var evidenceDetails: DisputeEvidenceDetails?
    public private(set) var isChargeRefundable: Bool?
    public private(set) var isLive: Bool?
    public private(set) var metadata: Node?
    public private(set) var disputeReason: DisputeReason?
    public private(set) var disputeStatus: DisputeStatus?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.balanceTransactions = try node.get("balance_transactions")
        self.charge = try node.get("charge")
        self.created = try node.get("created")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.evidence = try node.get("evidence")
        self.evidenceDetails = try node.get("evidence_details")
        self.isChargeRefundable = try node.get("is_charge_refundable")
        self.isLive = try node.get("livemode")
        self.metadata = try node.get("metadata")
        if let disputereason = node["resaon"]?.string {
            self.disputeReason = DisputeReason(rawValue: disputereason)
        }
        if let disputestatus = node["status"]?.string {
            self.disputeStatus = DisputeStatus(rawValue: disputestatus)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "balance_transactions": self.balanceTransactions,
            "charge": self.charge,
            "created": self.created,
            "currency": self.currency,
            "evidence": self.evidence,
            "evidence_details": self.evidenceDetails,
            "is_charge_refundable": self.isChargeRefundable,
            "livemode": self.isLive,
            "metadata": self.metadata,
            "reason": self.disputeReason?.rawValue,
            "status": self.disputeStatus?.rawValue
        ]
        
        return try Node(node: object)
    }
}

public final class DisputeEvidence: StripeModelProtocol {
    
    public private(set) var accessActivityLog: String?
    public private(set) var billingAddress: String?
    public private(set) var cancellationPolicy: String?
    public private(set) var cancellationPolicyDisclosure: String?
    public private(set) var cancellationRebuttal: String?
    public private(set) var customerCommunication: String?
    public private(set) var customerEmailAddress: String?
    public private(set) var customerName: String?
    public private(set) var customerPurchaseIp: String?
    public private(set) var customerSignature: String?
    public private(set) var duplicateChargeDocumantation: String?
    public private(set) var duplicateChargeExplination: String?
    public private(set) var duplicateChargeId: String?
    public private(set) var productDescription: String?
    public private(set) var receipt: String?
    public private(set) var refundPolicy: String?
    public private(set) var refundPolicyDisclosure: String?
    public private(set) var refundRefusalExplination: String?
    public private(set) var serviceDate: String?
    public private(set) var serviceDocumentation: String?
    public private(set) var shippingAddress: String?
    public private(set) var shippingCarrier: String?
    public private(set) var shippingDate: String?
    public private(set) var shippingDocumentation: String?
    public private(set) var shippingTrackingNumber: String?
    public private(set) var uncatagorizedFile: String?
    public private(set) var uncatagorizedText: String?
    
    public init(node: Node) throws {
        self.accessActivityLog = try node.get("access_activity_log")
        self.billingAddress = try node.get("billing_address")
        self.cancellationPolicy = try node.get("cancellation_policy")
        self.cancellationPolicyDisclosure = try node.get("cancellation_policy_disclosure")
        self.cancellationRebuttal = try node.get("cancellation_rebuttal")
        self.customerCommunication = try node.get("customer_communication")
        self.customerEmailAddress = try node.get("customer_email_address")
        self.customerName = try node.get("customer_name")
        self.customerPurchaseIp = try node.get("customer_purchase_ip")
        self.customerSignature = try node.get("customer_signature")
        self.duplicateChargeDocumantation = try node.get("duplicate_charge_documentation")
        self.duplicateChargeExplination = try node.get("duplicate_charge_explanation")
        self.duplicateChargeId = try node.get("duplicate_charge_id")
        self.productDescription = try node.get("product_description")
        self.receipt = try node.get("receipt")
        self.refundPolicy = try node.get("refund_policy")
        self.refundPolicyDisclosure = try node.get("refund_policy_disclosure")
        self.refundRefusalExplination = try node.get("refund_refusal_explanation")
        self.serviceDate = try node.get("service_date")
        self.serviceDocumentation = try node.get("service_documentation")
        self.shippingAddress = try node.get("shipping_address")
        self.shippingCarrier = try node.get("shipping_carrier")
        self.shippingDate = try node.get("shipping_date")
        self.shippingDocumentation = try node.get("shipping_documentation")
        self.shippingTrackingNumber = try node.get("shipping_tracking_number")
        self.uncatagorizedFile = try node.get("uncategorized_file")
        self.uncatagorizedText = try node.get("uncategorized_text")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "access_activity_log": self.accessActivityLog,
            "billing_address": self.billingAddress,
            "cancellation_policy": self.cancellationPolicy,
            "cancellation_policy_disclosure": self.cancellationPolicyDisclosure,
            "cancellation_rebuttal": self.cancellationRebuttal,
            "customer_communication": self.customerCommunication,
            "customer_email_address": self.customerEmailAddress,
            "customer_name": self.customerName,
            "customer_purchase_ip": self.customerPurchaseIp,
            "customer_signature": self.customerSignature,
            "duplicate_charge_documentation": self.duplicateChargeDocumantation,
            "duplicate_charge_explanation": self.duplicateChargeExplination,
            "duplicate_charge_id": self.duplicateChargeId,
            "product_description": self.productDescription,
            "receipt": self.receipt,
            "refund_policy": self.refundPolicy,
            "refund_policy_disclosure": self.refundPolicyDisclosure,
            "refund_refusal_explanation": self.refundRefusalExplination,
            "service_date": self.serviceDate,
            "service_documentation": self.serviceDocumentation,
            "shipping_address": self.shippingAddress,
            "shipping_carrier": self.shippingCarrier,
            "shipping_date": self.shippingDate,
            "shipping_documentation": self.shippingDocumentation,
            "shipping_tracking_number": self.shippingTrackingNumber,
            "uncategorized_file": self.uncatagorizedFile,
            "uncategorized_text": self.uncatagorizedText
        ]
        
        return try Node(node: object)
    }
}

public final class DisputeEvidenceDetails: StripeModelProtocol {
    
    public private(set) var dueBy: Date?
    public private(set) var hasEvidence: Bool?
    public private(set) var pastDue: Bool?
    public private(set) var submissionCount: Int?
    
    public init(node: Node) throws {
        
        self.dueBy = try node.get("due_by")
        self.hasEvidence = try node.get("has_evidence")
        self.pastDue = try node.get("past_due")
        self.submissionCount = try node.get("submission_count")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "due_by": self.dueBy,
            "has_evidence": self.hasEvidence,
            "past_due": self.pastDue,
            "submission_count": self.submissionCount
        ]
        
        return try Node(node: object)
    }
}
