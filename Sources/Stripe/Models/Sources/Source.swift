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

public protocol Source {
    associatedtype R: Receiver
    associatedtype O: Owner
    associatedtype C: Card
    
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var clientSecret: String? { get }
    var codeVerification: CodeVerification? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var flow: String? { get }
    var isLive: Bool? { get }
    var metadata: [String: String]? { get }
    var owner: O? { get }
    var receiver: R? { get }
    var redirect: SourceRedirect? { get }
    var statementDescriptor: String? { get }
    var status: StripeStatus? { get }
    var type: SourceType? { get }
    var usage: String? { get }
    var card: C? { get }
    var threeDSecure: ThreeDSecure? { get }
    var giropay: Giropay? { get }
    var bitcoin: Bitcoin? { get }
    var sepaDebit: SepaDebit? { get }
    var ideal: iDEAL? { get }
    var sofort: SOFORT? { get }
    var bancontact: Bancontact? { get }
    var alipay: Alipay? { get }
    var p24: P24? { get }
}

public struct StripeSource: Source, StripeModelProtocol {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var clientSecret: String?
    public var codeVerification: CodeVerification?
    public var created: Date?
    public var currency: StripeCurrency?
    public var flow: String?
    public var isLive: Bool?
    public var metadata: [String: String]?
    public var owner: StripeOwner?
    public var receiver: StripeReceiver?
    public var redirect: SourceRedirect?
    public var statementDescriptor: String?
    public var status: StripeStatus?
    public var type: SourceType?
    public var usage: String?
    public var card: StripeCard?
    public var threeDSecure: ThreeDSecure?
    public var giropay: Giropay?
    public var bitcoin: Bitcoin?
    public var sepaDebit: SepaDebit?
    public var ideal: iDEAL?
    public var sofort: SOFORT?
    public var bancontact: Bancontact?
    public var alipay: Alipay?
    public var p24: P24?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case clientSecret = "client_secret"
        case codeVerification = "code_verification"
        case created
        case currency
        case flow
        case isLive = "livemode"
        case metadata
        case owner
        case receiver
        case redirect
        case statementDescriptor = "statement_descriptor"
        case status
        case type
        case usage
        case card
        case threeDSecure = "three_d_secure"
        case giropay
        case bitcoin
        case sepaDebit = "sepa_debit"
        case ideal
        case sofort
        case bancontact
        case alipay
        case p24
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        object = try container.decode(String.self, forKey: .object)
        amount = try container.decode(Int.self, forKey: .amount)
        clientSecret = try container.decode(String.self, forKey: .clientSecret)
        codeVerification = try container.decode(CodeVerification.self, forKey: .codeVerification)
        created = try container.decode(Date.self, forKey: .created)
        currency = try container.decode(StripeCurrency.self, forKey: .currency)
        flow = try container.decode(String.self, forKey: .flow)
        isLive = try container.decode(Bool.self, forKey: .isLive)
        metadata = try container.decode([String: String].self, forKey: .metadata)
        owner = try container.decode(StripeOwner.self, forKey: .owner)
        receiver = try container.decode(StripeReceiver.self, forKey: .receiver)
        redirect = try container.decode(SourceRedirect.self, forKey: .redirect)
        statementDescriptor = try container.decode(String.self, forKey: .statementDescriptor)
        status = try container.decode(StripeStatus.self, forKey: .status)
        usage = try container.decode(String.self, forKey: .usage)
        
        type = try container.decode(SourceType.self, forKey: .type)
        
        switch type! {
        case .card:
            card = try container.decode(StripeCard.self, forKey: .card)

        case .bitcoin:
            bitcoin = try container.decode(Bitcoin.self, forKey: .bitcoin)
            
        case .threeDSecure:
            threeDSecure = try container.decode(ThreeDSecure.self, forKey: .threeDSecure)
            
        case .giropay:
            giropay = try container.decode(Giropay.self, forKey: .giropay)
            
        case .sepaDebit:
            sepaDebit = try container.decode(SepaDebit.self, forKey: .sepaDebit)
            
        case .ideal:
            ideal = try container.decode(iDEAL.self, forKey: .ideal)
            
        case .sofort:
            sofort = try container.decode(SOFORT.self, forKey: .sofort)
            
        case .bancontact:
            bancontact = try container.decode(Bancontact.self, forKey: .bancontact)
            
        case .alipay:
            alipay = try container.decode(Alipay.self, forKey: .alipay)
            
        case .p24:
            p24 = try container.decode(P24.self, forKey: .p24)
        }
    }
}
