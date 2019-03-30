//
//  ValueListItemRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/30/19.
//

import Vapor

public protocol ValueListItemRoutes {
    /// Creates a new `ValueListItem` object, which is added to the specified parent value list.
    ///
    /// - Parameters:
    ///   - value: The value of the item (whose type must match the type of the parent value list).
    ///   - valueList: The identifier of the value list which the created item will be added to.
    /// - Returns: A `StripeValueListItem`.
    /// - Throws: A `StripeError`.
    func create(value: String, valueList: String) throws -> EventLoopFuture<StripeValueListItem>
    
    /// Retrieves a `ValueListItem` object.
    ///
    /// - Parameter item: The identifier of the value list item to be retrieved.
    /// - Returns: A `StripeValueListItem`.
    /// - Throws: A `StripeError`.
    func retrieve(item: String) throws -> EventLoopFuture<StripeValueListItem>
    
    /// Deletes a `ValueListItem` object, removing it from its parent value list.
    ///
    /// - Parameter item: The identifier of the value list item to be deleted.
    /// - Returns: A `StripeValueListItem`.
    /// - Throws: A `StripeDeletedObject`.
    func delete(item: String) throws -> EventLoopFuture<StripeDeletedObject>
    
    /// Returns a list of `ValueListItem` objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/radar/value_list_items/list).
    /// - Returns: A `StripeValueListItemList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeValueListItemList>
}

extension ValueListItemRoutes {
    func create(value: String, valueList: String) throws -> EventLoopFuture<StripeValueListItem> {
        return try create(value: value, valueList: valueList)
    }
    
    func retrieve(item: String) throws -> EventLoopFuture<StripeValueListItem> {
        return try retrieve(item: item)
    }
    
    func delete(item: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try delete(item: item)
    }
    
    func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeValueListItemList> {
        return try listAll(filter: filter)
    }
}

public struct StripeValueListItemRoutes: ValueListItemRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    public func create(value: String, valueList: String) throws -> EventLoopFuture<StripeValueListItem> {
        let body = ["value": value, "value_list": valueList]
        return try request.send(method: .POST, path: StripeAPIEndpoint.valueListItem.endpoint, body: body.queryParameters)
    }
    
    public func retrieve(item: String) throws -> EventLoopFuture<StripeValueListItem> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.valueListItems(item).endpoint)
    }
    
    public func delete(item: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.valueListItems(item).endpoint)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeValueListItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.valueListItem.endpoint, query: queryParams)
    }
}
