import XCTest
@testable import StripeTests

XCTMain([
    testCase(ProviderTests.allTests),
    
    testCase(BalanceTests.allTests),
    testCase(ChargeTests.allTests),
    testCase(CustomerTests.allTests),
])
