import XCTest

extension AccountTests {
    static let __allTests = [
        ("testAccountParsedProperly", testAccountParsedProperly),
    ]
}

extension BalanceTests {
    static let __allTests = [
        ("testBalanceParsedProperly", testBalanceParsedProperly),
        ("testBalanceTransactionParsedProperly", testBalanceTransactionParsedProperly),
    ]
}

extension ChargeTests {
    static let __allTests = [
        ("testChargeParsedProperly", testChargeParsedProperly),
    ]
}

extension CustomerTests {
    static let __allTests = [
        ("testCustomerParsedProperly", testCustomerParsedProperly),
    ]
}

extension DisputeTests {
    static let __allTests = [
        ("testDisputeParsedProperly", testDisputeParsedProperly),
    ]
}

extension EphemeralKeyTests {
    static let __allTests = [
        ("testEphemeralKeyParsedProperly", testEphemeralKeyParsedProperly),
    ]
}

extension ErrorTests {
    static let __allTests = [
        ("testErrorParsedProperly", testErrorParsedProperly),
    ]
}

extension FileTests {
    static let __allTests = [
        ("testFileLinkParsedProperly", testFileLinkParsedProperly),
        ("testFileUploadParsedProperly", testFileUploadParsedProperly),
    ]
}

extension InvoiceTests {
    static let __allTests = [
        ("testInvoiceItemParsedProperly", testInvoiceItemParsedProperly),
        ("testInvoiceParsedProperly", testInvoiceParsedProperly),
    ]
}

extension OrderTests {
    static let __allTests = [
        ("testOrderIsProperlyParsed", testOrderIsProperlyParsed),
    ]
}

extension PaymentSourceTests {
    static let __allTests = [
        ("testSourceListIsProperlyParsed", testSourceListIsProperlyParsed),
    ]
}

extension PayoutTests {
    static let __allTests = [
        ("testPayoutsParsedProperly", testPayoutsParsedProperly),
    ]
}

extension ProductTests {
    static let __allTests = [
        ("testProductParsedProperly", testProductParsedProperly),
    ]
}

extension QueryEncodingTests {
    static let __allTests = [
        ("testNestedArrayQueryEncodedProperly", testNestedArrayQueryEncodedProperly),
        ("testNestedDictionaryQueryEncodedProperly", testNestedDictionaryQueryEncodedProperly),
        ("testSimpleQueryEncodedProperly", testSimpleQueryEncodedProperly),
    ]
}

extension RefundTests {
    static let __allTests = [
        ("testRefundParsedProperly", testRefundParsedProperly),
    ]
}

extension SKUTests {
    static let __allTests = [
        ("testSkuParsedProperly", testSkuParsedProperly),
    ]
}

extension SourceTests {
    static let __allTests = [
        ("testACHSourceParsedProperly", testACHSourceParsedProperly),
        ("testAlipaySourceParsedProperly", testAlipaySourceParsedProperly),
        ("testBancontactSourceParsedProperly", testBancontactSourceParsedProperly),
        ("testCardSourceParsedProperly", testCardSourceParsedProperly),
        ("testGiropaySourceParsedProperly", testGiropaySourceParsedProperly),
        ("testIdealSourceParsedProperly", testIdealSourceParsedProperly),
        ("testP24SourceParsedProperly", testP24SourceParsedProperly),
        ("testSepaDebitSourceParsedProperly", testSepaDebitSourceParsedProperly),
        ("testSofortSourceParsedProperly", testSofortSourceParsedProperly),
        ("testThreeDSecureSourceParsedProperly", testThreeDSecureSourceParsedProperly),
    ]
}

extension SubscriptionTests {
    static let __allTests = [
        ("testSubscriptionParsedProperly", testSubscriptionParsedProperly),
    ]
}

extension TokenTests {
    static let __allTests = [
        ("testBankTokenParsedProperly", testBankTokenParsedProperly),
        ("testCardTokenParsedProperly", testCardTokenParsedProperly),
    ]
}

extension TransferTests {
    static let __allTests = [
        ("testTransferParsedProperly", testTransferParsedProperly),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AccountTests.__allTests),
        testCase(BalanceTests.__allTests),
        testCase(ChargeTests.__allTests),
        testCase(CustomerTests.__allTests),
        testCase(DisputeTests.__allTests),
        testCase(EphemeralKeyTests.__allTests),
        testCase(ErrorTests.__allTests),
        testCase(FileTests.__allTests),
        testCase(InvoiceTests.__allTests),
        testCase(OrderTests.__allTests),
        testCase(PaymentSourceTests.__allTests),
        testCase(PayoutTests.__allTests),
        testCase(ProductTests.__allTests),
        testCase(QueryEncodingTests.__allTests),
        testCase(RefundTests.__allTests),
        testCase(SKUTests.__allTests),
        testCase(SourceTests.__allTests),
        testCase(SubscriptionTests.__allTests),
        testCase(TokenTests.__allTests),
        testCase(TransferTests.__allTests),
    ]
}
#endif
