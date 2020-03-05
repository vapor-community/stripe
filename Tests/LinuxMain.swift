import XCTest

import StripeTests

var tests = [XCTestCaseEntry]()
tests += StripeTests.__allTests()

XCTMain(tests)
