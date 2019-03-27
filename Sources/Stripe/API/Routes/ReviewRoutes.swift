//
//  ReviewRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/26/19.
//

import Vapor

public protocol ReviewRoutes {
    /// Approves a `Review` object, closing it and removing it from the list of reviews.
    ///
    /// - Parameter review: The identifier of the review to be approved.
    /// - Returns: A `StripeReview`.
    /// - Throws: A `StripeError`.
    func approve(review: String) throws -> EventLoopFuture<StripeReview>
    
    /// Retrieves a Review object.
    ///
    /// - Parameter review: The identifier of the review to be retrieved.
    /// - Returns: A `StripeReview`.
    /// - Throws: A `StripeError`.
    func retrieve(review: String) throws -> EventLoopFuture<StripeReview>
    
    /// Returns a list of `Review` objects that have `open` set to `true`. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/radar/reviews/list).
    /// - Returns: A `StripeReviewList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?)  throws -> EventLoopFuture<StripeReviewList>
}

extension ReviewRoutes {
    func approve(review: String) throws -> EventLoopFuture<StripeReview> {
        return try approve(review: review)
    }
    
    func retrieve(review: String) throws -> EventLoopFuture<StripeReview> {
        return try retrieve(review: review)
    }
    
    func listAll(filter: [String: Any]? = nil)  throws -> EventLoopFuture<StripeReviewList> {
        return try listAll(filter: filter)
    }
}

public struct StripeReviewRoutes: ReviewRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    public func approve(review: String) throws -> EventLoopFuture<StripeReview> {
        return try request.send(method: .POST, path: StripeAPIEndpoint.reviewsApprove(review).endpoint)
    }
    
    public func retrieve(review: String) throws -> EventLoopFuture<StripeReview> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.reviews(review).endpoint)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeReviewList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.review.endpoint, query: queryParams)
    }
}
