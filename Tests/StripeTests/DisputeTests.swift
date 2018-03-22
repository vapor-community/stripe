//
//  DisputeTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor

class DisputeTests: XCTestCase {
    let disputeString = """
{
    "amount": 1000,
    "balance_transactions": [],
    "charge": "ch_1BoJ2MKrZ43eBVAbDNoY8Anc",
    "created": 1234567890,
    "currency": "usd",
    "evidence": {
        "access_activity_log": "Rasengan",
        "billing_address": "Rasengan",
        "cancellation_policy": "Rasengan",
        "cancellation_policy_disclosure": "Rasengan",
        "cancellation_rebuttal": "Rasengan",
        "customer_communication": "Rasengan",
        "customer_email_address": "Rasengan",
        "customer_name": "Rasengan",
        "customer_purchase_ip": "Rasengan",
        "customer_signature": "Rasengan",
        "duplicate_charge_documentation": "Rasengan",
        "duplicate_charge_explanation": "Rasengan",
        "duplicate_charge_id": "Rasengan",
        "product_description": "Rasengan",
        "receipt": "Rasengan",
        "refund_policy": "Rasengan",
        "refund_policy_disclosure": "Rasengan",
        "refund_refusal_explanation": "Rasengan",
        "service_date": "Rasengan",
        "service_documentation": "Rasengan",
        "shipping_address": "Rasengan",
        "shipping_carrier": "Rasengan",
        "shipping_date": "Rasengan",
        "shipping_documentation": "Rasengan",
        "shipping_tracking_number": "Rasengan",
        "uncategorized_file": "Rasengan",
        "uncategorized_text": "Rasengan"
    },
    "evidence_details": {
        "due_by": 1518566399,
        "has_evidence": false,
        "past_due": false,
        "submission_count": 0
    },
    "id": "dp_1BoJ2MKrZ43eBVAbjyK5qAWL",
    "is_charge_refundable": false,
    "livemode": false,
    "metadata": {},
    "object": "dispute",
    "reason": "general",
    "status": "needs_response"
}
"""
    
    func testDisputeParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let body = HTTPBody(string: disputeString)
            let futureDispute = try decoder.decode(StripeDispute.self, from: body, on: EmbeddedEventLoop())
            
            futureDispute.do { (dispute) in
                XCTAssertEqual(dispute.amount, 1000)
                XCTAssertEqual(dispute.charge, "ch_1BoJ2MKrZ43eBVAbDNoY8Anc")
                XCTAssertEqual(dispute.created, Date(timeIntervalSince1970: 1234567890))
                XCTAssertEqual(dispute.currency, .usd)
                XCTAssertEqual(dispute.id, "dp_1BoJ2MKrZ43eBVAbjyK5qAWL")
                XCTAssertEqual(dispute.isChargeRefundable, false)
                XCTAssertEqual(dispute.livemode, false)
                XCTAssertEqual(dispute.object, "dispute")
                XCTAssertEqual(dispute.reason, .general)
                XCTAssertEqual(dispute.status, .needsResponse)
                
                // Evidence Datails
                XCTAssertEqual(dispute.evidenceDetails?.dueBy, Date(timeIntervalSince1970: 1518566399))
                XCTAssertEqual(dispute.evidenceDetails?.hasEvidence, false)
                XCTAssertEqual(dispute.evidenceDetails?.pastDue, false)
                XCTAssertEqual(dispute.evidenceDetails?.submissionCount, 0)
                
                // Evidence
                XCTAssertEqual(dispute.evidence?.accessActivityLog, "Rasengan")
                XCTAssertEqual(dispute.evidence?.billingAddress, "Rasengan")
                XCTAssertEqual(dispute.evidence?.cancellationPolicy, "Rasengan")
                XCTAssertEqual(dispute.evidence?.cancellationPolicyDisclosure, "Rasengan")
                XCTAssertEqual(dispute.evidence?.cancellationRebuttal, "Rasengan")
                XCTAssertEqual(dispute.evidence?.customerCommunication, "Rasengan")
                XCTAssertEqual(dispute.evidence?.customerEmailAddress, "Rasengan")
                XCTAssertEqual(dispute.evidence?.customerName, "Rasengan")
                XCTAssertEqual(dispute.evidence?.customerPurchaseIp, "Rasengan")
                XCTAssertEqual(dispute.evidence?.customerSignature, "Rasengan")
                XCTAssertEqual(dispute.evidence?.duplicateChargeDocumentation, "Rasengan")
                XCTAssertEqual(dispute.evidence?.duplicateChargeExplanation, "Rasengan")
                XCTAssertEqual(dispute.evidence?.duplicateChargeId, "Rasengan")
                XCTAssertEqual(dispute.evidence?.productDescription, "Rasengan")
                XCTAssertEqual(dispute.evidence?.receipt, "Rasengan")
                XCTAssertEqual(dispute.evidence?.refundPolicy, "Rasengan")
                XCTAssertEqual(dispute.evidence?.refundPolicyDisclosure, "Rasengan")
                XCTAssertEqual(dispute.evidence?.refundRefusalExplanation, "Rasengan")
                XCTAssertEqual(dispute.evidence?.serviceDate, "Rasengan")
                XCTAssertEqual(dispute.evidence?.serviceDocumentation, "Rasengan")
                XCTAssertEqual(dispute.evidence?.shippingAddress, "Rasengan")
                XCTAssertEqual(dispute.evidence?.shippingCarrier, "Rasengan")
                XCTAssertEqual(dispute.evidence?.shippingDate, "Rasengan")
                XCTAssertEqual(dispute.evidence?.shippingDocumentation, "Rasengan")
                XCTAssertEqual(dispute.evidence?.shippingTrackingNumber, "Rasengan")
                XCTAssertEqual(dispute.evidence?.uncategorizedFile, "Rasengan")
                XCTAssertEqual(dispute.evidence?.uncategorizedText, "Rasengan")
                
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
