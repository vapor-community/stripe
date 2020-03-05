//
//  Source.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

/**
 Source object
 https://stripe.com/docs/api/curl#source_object
 */

// TODO: - Add multibanco, EPS
// https://stripe.com/docs/sources

public struct StripeSource: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int?
    public var clientSecret: String?
    public var codeVerification: CodeVerification?
    public var created: Date?
    public var currency: StripeCurrency?
    public var flow: Flow?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var owner: StripeOwner?
    public var receiver: StripeReceiver?
    public var redirect: SourceRedirect?
    public var statementDescriptor: String?
    public var status: StripeStatus?
    public var type: SourceType?
    public var usage: String?
    public var card: StripeBasicCard?
    public var threeDSecure: ThreeDSecure?
    public var giropay: Giropay?
    public var sepaDebit: SepaDebit?
    public var ideal: iDEAL?
    public var sofort: SOFORT?
    public var bancontact: Bancontact?
    public var alipay: Alipay?
    public var p24: P24?
    public var achCreditTransfer: ACHCreditTransfer?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        object = try container.decode(String.self, forKey: .object)
        amount = try container.decodeIfPresent(Int.self, forKey: .amount)
        clientSecret = try container.decodeIfPresent(String.self, forKey: .clientSecret)
        codeVerification = try container.decodeIfPresent(CodeVerification.self, forKey: .codeVerification)
        created = try container.decodeIfPresent(Date.self, forKey: .created)
        currency = try container.decodeIfPresent(StripeCurrency.self, forKey: .currency)
        flow = try container.decodeIfPresent(Flow.self, forKey: .flow)
        livemode = try container.decodeIfPresent(Bool.self, forKey: .livemode)
        metadata = try container.decode([String: String].self, forKey: .metadata)
        owner = try container.decodeIfPresent(StripeOwner.self, forKey: .owner)
        receiver = try container.decodeIfPresent(StripeReceiver.self, forKey: .receiver)
        redirect = try container.decodeIfPresent(SourceRedirect.self, forKey: .redirect)
        statementDescriptor = try container.decodeIfPresent(String.self, forKey: .statementDescriptor)
        status = try container.decodeIfPresent(StripeStatus.self, forKey: .status)
        usage = try container.decodeIfPresent(String.self, forKey: .usage)
        type = try container.decodeIfPresent(SourceType.self, forKey: .type)
        if let sourceType = type {
            switch sourceType {
            case .card:
                card = try container.decodeIfPresent(StripeBasicCard.self, forKey: .card)
                
            case .threeDSecure:
                threeDSecure = try container.decodeIfPresent(ThreeDSecure.self, forKey: .threeDSecure)
                
            case .giropay:
                giropay = try container.decodeIfPresent(Giropay.self, forKey: .giropay)
                
            case .sepaDebit:
                sepaDebit = try container.decodeIfPresent(SepaDebit.self, forKey: .sepaDebit)
                
            case .ideal:
                ideal = try container.decodeIfPresent(iDEAL.self, forKey: .ideal)
                
            case .sofort:
                sofort = try container.decodeIfPresent(SOFORT.self, forKey: .sofort)
                
            case .bancontact:
                bancontact = try container.decodeIfPresent(Bancontact.self, forKey: .bancontact)
                
            case .alipay:
                alipay = try container.decodeIfPresent(Alipay.self, forKey: .alipay)
                
            case .p24:
                p24 = try container.decodeIfPresent(P24.self, forKey: .p24)
                
            case .achCreditTransfer:
                achCreditTransfer = try container.decodeIfPresent(ACHCreditTransfer.self, forKey: .achCreditTransfer)
            }
        }
    }
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case clientSecret = "client_secret"
        case codeVerification = "code_verification"
        case created
        case currency
        case flow
        case livemode
        case metadata
        case owner
        case receiver
        case redirect
        case statementDescriptor = "statement_descriptor"
        case status
        case usage
        case type
        case card
        case threeDSecure = "three_d_secure"
        case giropay
        case sepaDebit = "sepa_debit"
        case ideal
        case sofort
        case bancontact
        case alipay
        case p24
        case achCreditTransfer = "ach_credit_transfer"
    }
}
