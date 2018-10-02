//
//  BillingScheme.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/17/18.
//

import Foundation

extension StripePlan {
    
    public enum BillingScheme: String, Codable {
        case perUnit = "per_unit"
        case tiered
    }
    
    public enum RoundMode: String, Codable {
        case up
        case down
    }
    
    public struct Tier: Codable {
        public var amount: Int
        public var upTo: Int?
        
        public init(amount: Int, upTo: Int? = nil) {
            self.amount = amount
            self.upTo = upTo
        }
        
        public enum CodingKeys: String, CodingKey {
            case amount
            case upTo = "up_to"
        }
    }
    
    public enum TiersMode: String, Codable {
        case graduated
        case volume
    }
    
    public struct UsageTransformation: Codable {
        public var divideBy: Int?
        public var round: RoundMode?
        
        init(divideBy: Int, round: RoundMode) {
            self.divideBy = divideBy
            self.round = round
        }
        
        public enum CodingKeys: String, CodingKey {
            case divideBy = "divide_by"
            case round
        }
    }
    
    public enum UsageType: String, Codable {
        case metered
        case licensed
    }
}
