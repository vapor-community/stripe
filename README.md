# Vapor Stripe Provider

![Swift](http://img.shields.io/badge/swift-3.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-2.0-brightgreen.svg)
![Build](https://img.shields.io/badge/build-passing-brightgreen.svg)

[Stripe][stripe_home] is a payment platform that handles credit cards, bitcoin and ACH transfers. They have become one of the best platforms for handling payments for projects, services or products.

## Why Create this?
There wasn't a library for it that worked with Vapor, and I needed one for my project.
The Stripe API is huge, and therefor I only plan on implementing the things that deal with payments. If there is something you need outside of that scope, feel free to submit a Pull Request.

## Getting Started
In your `Package.swift` file, add a Package
~~~~swift
.Package(url: "https://github.com/vapor-community/stripe.git", Version(1,0,0, prereleaseIdentifiers: ["beta"]))
~~~~

You'll need a config file as well. Place a `stripe.json` file in your `Config` folder
~~~~json
{
    "apiKey": "YOUR_API_KEY"
}
~~~~

Add the provider to your droplet
~~~~swift
try drop.addProvider(Stripe.Provider.self)
~~~~

And you are all set. Interacting with the API is quite easy. Everything is Node backed with a simple API.

Making calls to the api is a simple one line
~~~~swift
let object = try drop.stripe?.balance.history().serializedResponse()
~~~~
The object is returned response model, or model array.

## Testing

To avoid having to remember to add tests to `LinuxMain.swift` you can use [Sourcery][sourcery] to add your tets cases there for you. Just install the sourcery binary with Homebrew `brew install sourcery`, navigate to your project folder, and from the command line run the following:
~~~~bash
sourcery --sources Tests/ --templates Sourcery/LinuxMain.stencil --args testimports='@testable import StripeTests'
~~~~
It will generate the following with your tests added:

~~~~swift
import XCTest
@testable import StripeTests
extension BalanceTests {
static var allTests = [
  ("testBalance", testBalance),
  ...
]
}
.
.
XCTMain([
  testCase(BalanceTests.allTests),
  ...
])
~~~~

## Whats Implemented
* [x] Balance Fetching
* [x] Charges
* [x] Customers
* [x] Coupons
* [x] Plans
* [x] Refunds
* [x] Tokens
* [x] Sources
* [x] Subscriptions
* [x] Connect account
* [x] Orders
* [x] Order Items
* [x] Products
* [x] Disputes  
* [x] Invoices
* [x] Invoice Items

[stripe_home]: http://stripe.com "Stripe"
[stripe_api]: https://stripe.com/docs/api "Stripe API Endpoints"
[sourcery]: https://github.com/krzysztofzablocki/Sourcery "Sourcery"

## License

Vapor Stripe Provider is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Want to help?
Feel free to submit a pull request whether it's a clean up, a new approach to handling things, adding a new part of the API, or even if it's just a typo. All help is welcomed! 😀
