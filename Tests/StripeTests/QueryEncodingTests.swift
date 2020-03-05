import XCTest
@testable import Stripe

class QueryEncodingTests: XCTestCase {
    
    func testSimpleQueryEncodedProperly() throws {
        let query = [
            "email": "accounting+furnitures@hmm.test"
        ]
        XCTAssertEqual(query.queryParameters, "email=accounting%2Bfurnitures@hmm.test")
    }
    
    func testNestedDictionaryQueryEncodedProperly() throws {
        let query: [String: Any] = [
            "shipping": ["name": "Hamlin, Hamlin & McGill"]
        ]
        XCTAssertEqual(query.queryParameters, "shipping[name]=Hamlin,%20Hamlin%20%26%20McGill")
    }
    
    func testNestedArrayQueryEncodedProperly() throws {
        let query: [String: Any] = [
            "items": [["plan": "plan_b"], ["plan": "plan_nine"]]
        ]
        XCTAssertEqual(query.queryParameters, "items[0][plan]=plan_b&items[1][plan]=plan_nine")
    }
}
