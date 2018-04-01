# Vapor Stripe Provider

![Swift](http://img.shields.io/badge/swift-4.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-3.0-brightgreen.svg)
[![CircleCI](https://circleci.com/gh/vapor-community/stripe-provider/tree/beta.svg?style=svg)](https://circleci.com/gh/vapor-community/stripe-provider)

[Stripe][stripe_home] is a payment platform that handles credit cards, bitcoin and ACH transfers. They have become one of the best platforms for handling payments for projects, services or products.

## Getting Started
In your `Package.swift` file, add a Package

For Swift 4
~~~~swift
.package(url: "https://github.com/vapor-community/stripe-provider.git", from: "2.0.0-rc")
~~~~

Register the config and the provider to your Application
~~~~swift
let config = StripeConfig(apiKey: "sk_12345678")

services.register(config)

try services.register(StripeProvider())

app = try Application(services: services)

stripeClient = try app.make(StripeClient.self)
~~~~

And you are all set. Interacting with the API is quite easy and adopts the `Future` syntax used in Vapor 3.
Making calls to the api is straight forward.
~~~~swift
let cardParams = ["exp_month": 1,
                  "exp_year": 2030,
                  "number": "4242424242424242",
                  "cvc": 123,
                  "object": "card"]

let futureCharge = try stripeClient.charge.create(amount: 2500, currency: .usd, source: cardParams)

futureCharge.do({ (charge) in
    // do something with charge object...
}).catch({ (error) in
    print(error)
})
~~~~

And you can always check the documentation to see the required paramaters for specific API calls.

## Whats Implemented

### Core Resources
* [x] Balance
* [x] Charges
* [x] Customers
* [x] Disputes  
* [ ] Events
* [ ] File Uploads
* [ ] Payouts
* [x] Refunds
* [x] Tokens
---
### Payment Methods
* [x] Bank Accounts
* [x] Cards
* [x] Sources
---
### Subscriptions
* [x] Coupons
* [x] Discounts
* [x] Invoices
* [x] Invoice Items
* [x] Plans
* [x] Subscriptions
* [x] Subscription items
---
### Connect
* [x] Account
* [ ] Application Fee Refunds
* [ ] Application Fees
* [ ] Country Specs
* [x] External Accounts
* [ ] Transfers
* [ ] Transfer Reversals
---
### Relay
* [x] Orders
* [x] Order Items
* [x] Products
* [x] Returns
* [x] SKUs
* [x] Ephemeral Keys

[stripe_home]: http://stripe.com "Stripe"
[stripe_api]: https://stripe.com/docs/api "Stripe API Endpoints"

## License

Vapor Stripe Provider is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Want to help?
Feel free to submit a pull request whether it's a clean up, a new approach to handling things, adding a new part of the API, or even if it's just a typo. All help is welcomed! 😀
