import XCTest
@testable import StripeTests

XCTMain([
    testCase(ProviderTests.allTests),
    testCase(BalanceTests.allTests),
])
