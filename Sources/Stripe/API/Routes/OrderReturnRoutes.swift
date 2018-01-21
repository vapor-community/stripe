//
//  OrderReturnRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/25/17.
//
//

//import Node
//
//open class OrderReturnRoutes {
//    let client: StripeClient
//    
//    init(client: StripeClient) {
//        self.client = client
//    }
//    
//    /**
//     Retrieve an order return
//     Retrieves the returned order by the given id
//     
//     - parameter orderReturnId: The ID of the desired return order.
//     
//     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
//     */
//    public func retrieve(orderReturn orderReturnId: String) throws -> StripeRequest<OrderReturn> {
//        return try StripeRequest(client: self.client, method: .get, route: .orderReturns(orderReturnId), query: [:], body: nil, headers: nil)
//    }
//    
//    /**
//     List all order returns
//     Returns a list of your order returns.
//     
//     - parameter filter: A Filter item to pass query parameters when fetching results
//     
//     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
//     */
//    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<OrderReturnList> {
//        var query = [String : NodeRepresentable]()
//        
//        if let data = try filter?.createQuery() {
//            query = data
//        }
//        return try StripeRequest(client: self.client, method: .get, route: .orderReturn, query: query, body: nil, headers: nil)
//    }
//}

