// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import StripeTests

extension SubscriptionTests {
static var allTests = [
  ("testSubscriptionParsedProperly", testSubscriptionParsedProperly),
]
}

extension TokenTests {
static var allTests = [
  ("testCardTokenParsedProperly", testCardTokenParsedProperly),
  ("testBankTokenParsedProperly", testBankTokenParsedProperly),
]
}


XCTMain([
  testCase(SubscriptionTests.allTests),
  testCase(TokenTests.allTests),
])
