//
//  PayoutSchedule.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation
import Vapor


public final class PayoutSchedule: StripeModelProtocol {
    
    public private(set) var delayDays: Int?
    public private(set) var interval: StripePayoutInterval?
    public private(set) var monthlyAnchor: Int?
    public private(set) var weeklyAnchor: StripeWeeklyAnchor?
    
    public init(node: Node) throws {
        
        self.delayDays = try node.get("delay_days")
        if let interval = node["interval"]?.string {
            self.interval = StripePayoutInterval(rawValue: interval)
        }
        if let weeklyAnchor = node["weekly_anchor"]?.string {
            self.weeklyAnchor = StripeWeeklyAnchor(rawValue: weeklyAnchor)
        }
        self.monthlyAnchor = try node.get("monthly_anchor")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "delay_days": self.delayDays,
            "interval": self.interval,
            "weekly_anchor": self.weeklyAnchor,
            "monthly_anchor": self.monthlyAnchor
        ]
        return try Node(node: object)
    }
}
