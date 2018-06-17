//
//  BillingScheme.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/17/18.
//

import Foundation

public enum BillingScheme: String, Codable {
    case perUnit = "per_unit"
    case tiered
}

public enum TiersMode: String, Codable {
    case graduated
    case volume
}

public enum PlanUsageType: String, Codable {
    case metered
    case licensed
}
