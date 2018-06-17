// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import StripeTests

extension AccountTests {
static var allTests = [
  ("testAccountParsedProperly", testAccountParsedProperly),
]
}

extension BalanceTests {
static var allTests = [
  ("testBalanceParsedProperly", testBalanceParsedProperly),
  ("testBalanceTransactionParsedProperly", testBalanceTransactionParsedProperly),
]
}

extension ChargeTests {
static var allTests = [
  ("testChargeParsedProperly", testChargeParsedProperly),
]
}

extension CustomerTests {
static var allTests = [
  ("testCustomerParsedProperly", testCustomerParsedProperly),
]
}

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

extension ErrorTests {
static var allTests = [
  ("testErrorParsedProperly", testErrorParsedProperly),
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
  ("testACHSourceParsedProperly", testACHSourceParsedProperly),
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

extension TransferTests {
static var allTests = [
  ("testTransferParsedProperly", testTransferParsedProperly),
]
}


XCTMain([
  testCase(AccountTests.allTests),
  testCase(BalanceTests.allTests),
  testCase(ChargeTests.allTests),
  testCase(CustomerTests.allTests),
  testCase(DisputeTests.allTests),
  testCase(EphemeralKeyTests.allTests),
  testCase(ErrorTests.allTests),
  testCase(InvoiceTests.allTests),
  testCase(OrderTests.allTests),
  testCase(ProductTests.allTests),
  testCase(RefundTests.allTests),
  testCase(SKUTests.allTests),
  testCase(SourceTests.allTests),
  testCase(SubscriptionTests.allTests),
  testCase(TokenTests.allTests),
  testCase(TransferTests.allTests),
])
