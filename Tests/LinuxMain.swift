// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import StripeTests

extension AccountTests {
static var allTests = [
  ("testCreateAccount", testCreateAccount),
  ("testRetrieveAccount", testRetrieveAccount),
  ("testUpdateAccount", testUpdateAccount),
  ("testDeleteAccount", testDeleteAccount),
  ("testRejectAccount", testRejectAccount),
  ("testListAllAccounts", testListAllAccounts),
  ("testFilterAccounts", testFilterAccounts),
]
}

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
  ("testAddNewSourceForCustomer", testAddNewSourceForCustomer),
  ("testAddNewCardSourceForCustomer", testAddNewCardSourceForCustomer),
  ("testAddNewBankAccountSourceForCustomer", testAddNewBankAccountSourceForCustomer),
  ("testDeleteDiscount", testDeleteDiscount),
  ("testDeleteCustomer", testDeleteCustomer),
  ("testRetrieveAllCustomers", testRetrieveAllCustomers),
  ("testFilterCustomers", testFilterCustomers),
]
}

extension DisputeTests {
static var allTests = [
  ("testRetrieveDispute", testRetrieveDispute),
  ("testUpdateDispute", testUpdateDispute),
  ("testCloseDispute", testCloseDispute),
  ("testListAllDisputes", testListAllDisputes),
  ("testFilterDisputes", testFilterDisputes),
]
}

extension OrderReturnTests {
static var allTests = [
  ("testRetrieveOrderReturn", testRetrieveOrderReturn),
  ("testListAllOrderReturns", testListAllOrderReturns),
  ("testFilterOrderReturns", testFilterOrderReturns),
]
}

extension OrderTests {
static var allTests = [
  ("testRetrieveOrder", testRetrieveOrder),
  ("testUpdateOrder", testUpdateOrder),
  ("testPayOrder", testPayOrder),
  ("testListAllOrders", testListAllOrders),
  ("testFilterOrders", testFilterOrders),
  ("testReturnOrder", testReturnOrder),
]
}

extension PlanTests {
static var allTests = [
  ("testCreatePlan", testCreatePlan),
  ("testRetrievePlan", testRetrievePlan),
  ("testUpdatePlan", testUpdatePlan),
  ("testDeletePlan", testDeletePlan),
  ("testListAllPlans", testListAllPlans),
  ("testFilterPlans", testFilterPlans),
]
}

extension ProductTests {
static var allTests = [
  ("testRetrieveProduct", testRetrieveProduct),
  ("testUpdateProduct", testUpdateProduct),
  ("testDeleteProduct", testDeleteProduct),
  ("testListAllProducts", testListAllProducts),
  ("testFilterProducts", testFilterProducts),
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

extension SKUTests {
static var allTests = [
  ("testRetrieveSKU", testRetrieveSKU),
  ("testUpdateSKU", testUpdateSKU),
  ("testDeleteSKU", testDeleteSKU),
  ("testListAllSKUs", testListAllSKUs),
  ("testFilterSKUs", testFilterSKUs),
]
}

extension SourceTests {
static var allTests = [
  ("testRetrieveSource", testRetrieveSource),
  ("testUpdateSource", testUpdateSource),
]
}

extension SubscriptionItemTests {
static var allTests = [
  ("testRetrieveSubscriptionItem", testRetrieveSubscriptionItem),
  ("testUpdateSubscriptionItem", testUpdateSubscriptionItem),
  ("testDeleteSubscriptionItem", testDeleteSubscriptionItem),
  ("testFilterSubscriptionItems", testFilterSubscriptionItems),
]
}

extension SubscriptionTests {
static var allTests = [
  ("testRetrieveSubscription", testRetrieveSubscription),
  ("testUpdateSubscription", testUpdateSubscription),
  ("testDeleteDiscount", testDeleteDiscount),
  ("testCancelSubscription", testCancelSubscription),
  ("testFilterSubscriptionItems", testFilterSubscriptionItems),
]
}

extension TokenTests {
static var allTests = [
  ("testCardTokenCreation", testCardTokenCreation),
  ("testTokenRetrieval", testTokenRetrieval),
  ("testBankAccountTokenCreation", testBankAccountTokenCreation),
]
}


XCTMain([
  testCase(AccountTests.allTests),
  testCase(BalanceTests.allTests),
  testCase(ChargeTests.allTests),
  testCase(CouponTests.allTests),
  testCase(CustomerTests.allTests),
  testCase(DisputeTests.allTests),
  testCase(OrderReturnTests.allTests),
  testCase(OrderTests.allTests),
  testCase(PlanTests.allTests),
  testCase(ProductTests.allTests),
  testCase(ProviderTests.allTests),
  testCase(RefundTests.allTests),
  testCase(SKUTests.allTests),
  testCase(SourceTests.allTests),
  testCase(SubscriptionItemTests.allTests),
  testCase(SubscriptionTests.allTests),
  testCase(TokenTests.allTests),
])
