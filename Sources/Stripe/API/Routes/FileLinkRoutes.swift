//
//  FileLinkRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/14/18.
//

import Vapor

public protocol FileLinkRoutes {
    /// Creates a new file link object.
    ///
    /// - Parameters:
    ///   - file: The ID of the file.
    ///   - expires: A future timestamp after which the link will no longer be usable.
    ///   - metadata: Set of key-value pairs that you can attach to an object.
    /// - Returns: Returns the file link object if successful, and returns an error otherwise.
    func create(file: String, expires: Date?, metadata: [String: String]?) throws -> Future<StripeFileLink>
    
    /// Retrieves the file link with the given ID.
    ///
    /// - Parameter link: The identifier of the file link to be retrieved.
    /// - Returns: Returns a file link object if a valid identifier was provided, and returns an error otherwise.
    func retrieve(link: String) throws -> Future<StripeFileLink>
    
    /// Updates an existing file link object. Expired links can no longer be updated
    ///
    /// - Parameters:
    ///   - link: The ID of the file link.
    ///   - expires: A future timestamp after which the link will no longer be usable, or `now` to expire the link immediately.
    ///   - metadata: Set of key-value pairs that you can attach to an object.
    /// - Returns: Returns the file link object if successful, and returns an error otherwise.
    func update(link: String, expires: Any?, metadata: [String: String]?) throws -> Future<StripeFileLink>
    
    
    /// Returns a list of file links.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/curl#list_file_links).
    /// - Returns: A `FileLinkList`.
    func listAll(filter: [String: Any]?) throws -> Future<FileLinkList>
}

extension FileLinkRoutes {
    public func create(file: String, expires: Date? = nil, metadata: [String: String]? = nil) throws -> Future<StripeFileLink> {
        return try create(file: file, expires: expires, metadata: metadata)
    }
    
    public func retrieve(link: String) throws -> Future<StripeFileLink> {
        return try retrieve(link: link)
    }
    
    public func update(link: String, expires: Any? = nil, metadata: [String: String]? = nil) throws -> Future<StripeFileLink> {
        return try update(link: link, expires: expires, metadata: metadata)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> Future<FileLinkList> {
        return try listAll(filter: filter)
    }
}

public struct StripeFileLinkRoutes: FileLinkRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    public func create(file: String, expires: Date?, metadata: [String: String]?) throws -> Future<StripeFileLink> {
        var body: [String: Any] = [:]
        if let expires = expires {
            body["expires_at"] = Int(expires.timeIntervalSince1970)
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1}
        }
        return try request.send(method: .POST, path: StripeAPIEndpoint.fileLink.endpoint, body: body.queryParameters)
    }
    
    public func retrieve(link: String) throws -> Future<StripeFileLink> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.fileLinks(link).endpoint)
    }
    
    public func update(link: String, expires: Any?, metadata: [String: String]?) throws -> Future<StripeFileLink> {
        var body: [String: Any] = [:]
        
        if let expires = expires as? Date {
            body["expires_at"] = Int(expires.timeIntervalSince1970)
        }
        
        if let expires = expires as? String {
            body["expires_at"] = expires
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1}
        }
        return try request.send(method: .POST, path: StripeAPIEndpoint.fileLinks(link).endpoint, body: body.queryParameters)
    }
    
    public func listAll(filter: [String: Any]?) throws -> Future<FileLinkList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.fileLink.endpoint, query: queryParams)
    }
}
