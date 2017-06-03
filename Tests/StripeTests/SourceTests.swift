//
//  SourceTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/2/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor
@testable import Models
@testable import API
@testable import Helpers

class SourceTests: XCTestCase {
    
    var drop: Droplet?
    var sourceId: String = ""
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            let card: [String: Node] = ["number":"4242 4242 4242 4242", "cvc":123,"exp_month":10, "exp_year":2018]
            
            sourceId = try drop?.stripe?.sources.createNewSource(sourceType: .card,
                                                                source: card,
                                                                amount: nil,
                                                                currency: nil,
                                                                flow: nil,
                                                                metadata: nil,
                                                                owner: nil,
                                                                redirectReturnUrl: nil,
                                                                token: nil,
                                                                usage: nil).serializedResponse().id ?? ""

        } catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testRetrieveSource() throws {
        let retrievedSource = try drop?.stripe?.sources.retrieveSource(withId: sourceId).serializedResponse()
        
        XCTAssertNotNil(retrievedSource)
        
        XCTAssertEqual(retrievedSource?.type, SourceType.card)
        
        XCTAssertNotNil(retrievedSource?.returnedSource)
    }
    
    func testUpdateSource() throws {
        
        let metadata = try Node(node:["hello": "world"])
        
        let updatedSource = try drop?.stripe?.sources.update(owner: nil,
                                                             metadata: metadata,
                                                             forSourceId: sourceId).serializedResponse()
        
        XCTAssertNotNil(updatedSource)
        
        XCTAssertEqual(updatedSource?.metadata?["hello"], metadata["hello"])
        
        XCTAssertEqual(updatedSource?.type, SourceType.card)
    }
}
