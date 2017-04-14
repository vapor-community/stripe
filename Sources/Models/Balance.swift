//
//  Balance.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Node

public final class Balance: StripeModelProtocol {

    public init(node: Node) throws {
        
    }

}

extension Balance: NodeRepresentable {

    public func makeNode(in context: Context?) throws -> Node {
        let obj = Node([:])

        return obj
    }

}
