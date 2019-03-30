//
//  ValueListItemTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 3/30/19.
//

import XCTest
@testable import Stripe
@testable import Vapor

class ValueListItemTests: XCTestCase {
    let valuelistItemString = """
{
  "id": "rsli_1EHbsyAU9AiAmxbBEiInzVPl",
  "object": "radar.value_list_item",
  "created": 1553455296,
  "created_by": "jenny@example.com",
  "livemode": false,
  "value": "1.2.3.4",
  "value_list": "rsl_1EHbsyAU9AiAmxbBeW2aRbec"
}
"""
    func testValueListItemarsesProperly() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let body = HTTPBody(string: valuelistItemString)
        var headers: HTTPHeaders = [:]
        headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
        let request = HTTPRequest(headers: headers, body: body)
        let valueListItem = try decoder.decode(StripeValueListItem.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
        
        XCTAssertEqual(valueListItem.createdBy, "jenny@example.com")
        XCTAssertEqual(valueListItem.created, Date(timeIntervalSince1970: 1553455296))
        XCTAssertEqual(valueListItem.valueList, "rsl_1EHbsyAU9AiAmxbBeW2aRbec")
    }
}
