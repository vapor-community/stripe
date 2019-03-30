//
//  ValueListTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 3/30/19.
//

import XCTest
@testable import Stripe
@testable import Vapor

class ValueListTests: XCTestCase {
    let valueListString = """
{
  "id": "rsl_1EHbsyAU9AiAmxbBTcesVX1w",
  "object": "radar.value_list",
  "alias": "custom_ip_blocklist",
  "created": 1553455296,
  "created_by": "jenny@example.com",
  "item_type": "ip_address",
  "list_items": {
    "object": "list",
    "data": [],
    "has_more": false,
    "total_count": 0,
    "url": "/v1/radar/value_list_items?value_list=rsl_1EHbsyAU9AiAmxbBTcesVX1w"
  },
  "livemode": false,
  "metadata": {},
  "name": "Custom IP Blocklist"
}
"""
    func testValueListItemarsesProperly() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let body = HTTPBody(string: valueListString)
        var headers: HTTPHeaders = [:]
        headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
        let request = HTTPRequest(headers: headers, body: body)
        let valueList = try decoder.decode(StripeValueList.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
        
        XCTAssertEqual(valueList.alias, "custom_ip_blocklist")
        XCTAssertEqual(valueList.createdBy, "jenny@example.com")
        XCTAssertEqual(valueList.itemType, .ipAddress)
        XCTAssertEqual(valueList.created, Date(timeIntervalSince1970: 1553455296))
        XCTAssertEqual(valueList.listItems?.url, "/v1/radar/value_list_items?value_list=rsl_1EHbsyAU9AiAmxbBTcesVX1w")
        XCTAssertEqual(valueList.name, "Custom IP Blocklist")
    }
}
