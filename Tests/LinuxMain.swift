// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import StripeTests

extension DisputeTests {
static var allTests = [
  ("testDisputeParsedProperly", testDisputeParsedProperly),
]
}

extension EphemeralKeyTests {
static var allTests = [
  ("testEphemeralKeyParsedProperly", testEphemeralKeyParsedProperly),
]
}

extension InvoiceTests {
static var allTests = [
  ("testInvoiceParsedProperly", testInvoiceParsedProperly),
  ("testInvoiceItemParsedProperly", testInvoiceItemParsedProperly),
]
}

extension OrderTests {
static var allTests = [
  ("testOrderIsProperlyParsed", testOrderIsProperlyParsed),
]
}

extension ProductTests {
static var allTests = [
  ("testProductParsedProperly", testProductParsedProperly),
]
}

extension RefundTests {
static var allTests = [
  ("testRefundParsedProperly", testRefundParsedProperly),
]
}

extension SKUTests {
static var allTests = [
  ("testSkuParsedProperly", testSkuParsedProperly),
]
}

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
  testCase(DisputeTests.allTests),
  testCase(EphemeralKeyTests.allTests),
  testCase(InvoiceTests.allTests),
  testCase(OrderTests.allTests),
  testCase(ProductTests.allTests),
  testCase(RefundTests.allTests),
  testCase(SKUTests.allTests),
  testCase(SourceTests.allTests),
  testCase(SubscriptionTests.allTests),
  testCase(TokenTests.allTests),
])
