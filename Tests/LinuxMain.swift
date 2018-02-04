// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import StripeTests

extension SourceTests {
static var allTests = [
  ("testCardSourceParsedProperly", testCardSourceParsedProperly),
  ("testThreeDSecureSourceParsedProperly", testThreeDSecureSourceParsedProperly),
  ("testSepaDebitSourceParsedProperly", testSepaDebitSourceParsedProperly),
  ("testAlipaySourceParsedProperly", testAlipaySourceParsedProperly),
  ("testGiropaySourceParsedProperly", testGiropaySourceParsedProperly),
  ("testIdealSourceParsedProperly", testIdealSourceParsedProperly),
  ("testP24SourceParsedProperly", testP24SourceParsedProperly),
  ("testSofortSourceParsedProperly", testSofortSourceParsedProperly),
  ("testBancontactSourceParsedProperly", testBancontactSourceParsedProperly),
]
}

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
  testCase(SourceTests.allTests),
  testCase(SubscriptionTests.allTests),
  testCase(TokenTests.allTests),
])
