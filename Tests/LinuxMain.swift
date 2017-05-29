// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import StripeTests

extension BalanceTests {
static var allTests = [
  ("testBalance", testBalance),
  ("testBalanceTransactionItem", testBalanceTransactionItem),
  ("testBalanceHistory", testBalanceHistory),
  ("testFilterBalanceHistory", testFilterBalanceHistory),
]
}

extension ChargeTests {
static var allTests = [
  ("testCharge", testCharge),
  ("testRetrieveCharge", testRetrieveCharge),
  ("testListAllCharges", testListAllCharges),
  ("testFilterAllCharges", testFilterAllCharges),
  ("testChargeUpdate", testChargeUpdate),
  ("testChargeCapture", testChargeCapture),
]
}

extension CouponTests {
static var allTests = [
  ("testCreateCoupon", testCreateCoupon),
  ("testRetrieveCoupon", testRetrieveCoupon),
  ("testUpdateCoupon", testUpdateCoupon),
  ("testDeleteCoupon", testDeleteCoupon),
  ("testListAllCoupons", testListAllCoupons),
  ("testFilterCoupons", testFilterCoupons),
]
}

extension CustomerTests {
static var allTests = [
  ("testCreateCustomer", testCreateCustomer),
  ("testRetrieveCustomer", testRetrieveCustomer),
  ("testUpdateCustomer", testUpdateCustomer),
  ("testDeleteCustomer", testDeleteCustomer),
  ("testRetrieveAllCustomers", testRetrieveAllCustomers),
  ("testFilterCustomers", testFilterCustomers),
]
}

extension ProviderTests {
static var allTests = [
  ("testProvider", testProvider),
]
}

extension RefundTests {
static var allTests = [
  ("testRefunding", testRefunding),
  ("testUpdatingRefund", testUpdatingRefund),
  ("testRetrievingRefund", testRetrievingRefund),
  ("testListingAllRefunds", testListingAllRefunds),
]
}

extension TokenTests {
static var allTests = [
  ("testTokenCreation", testTokenCreation),
  ("testTokenRetrieval", testTokenRetrieval),
  ("testBankAccountCreation", testBankAccountCreation),
]
}


XCTMain([
  testCase(BalanceTests.allTests),
  testCase(ChargeTests.allTests),
  testCase(CouponTests.allTests),
  testCase(CustomerTests.allTests),
  testCase(ProviderTests.allTests),
  testCase(RefundTests.allTests),
  testCase(TokenTests.allTests),
])
