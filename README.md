# Stripe

![Swift](http://img.shields.io/badge/swift-5.2-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-4.0-brightgreen.svg)


### Stripe is a Vapor wrapper around [StripeKit](https://github.com/vapor-community/stripe-kit)

## Usage guide
In your `Package.swift` file, add the following

~~~~swift
.package(url: "https://github.com/vapor-community/stripe.git", from: "5.0.0")
~~~~


To use Stripe in your Vapor application, set the environment variable for you Stripe API key
~~~
export STRIPE_API_KEY="sk_123456"      
~~~

Now you can access a `StripeClient` via `Request`.
~~~~swift

struct ChargeToken: Content {
    var token: String
}

func chargeCustomer(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
    return try req.content.decode(ChargeToken.self).flatMap { charge in
        return req.stripe.charge.create(amount: 2500, currency: .usd, source: charge.stripeToken).map { stripeCharge in
            if stripeCharge.status == .success {
                return .ok
            } else {
                print("Stripe charge status: \(stripeCharge.status.rawValue)")
                return .badRequest
            }
        }
    }
}
~~~~

And you can always check the documentation to see the required paramaters for specific API calls.

## Whats Implemented

### Core Resources
* [x] Balance
* [x] Charges
* [x] Customers
* [x] Disputes  
* [ ] Events
* [x] File Links
* [x] File Uploads
* [x] PaymentIntents
* [x] Payouts
* [x] Products
* [x] Refunds
* [x] Tokens
---
### Payment Methods
* [x] Bank Accounts
* [x] Cards
* [x] Sources
---
### Checkout
* [ ] Sessions
---
### Billing
* [x] Coupons
* [x] Discounts
* [x] Invoices
* [x] Invoice Items
* [x] Products
* [x] Plans
* [x] Subscriptions
* [x] Subscription items
* [ ] Usage Records
---
### Connect
* [x] Account
* [ ] Application Fee Refunds
* [ ] Application Fees
* [ ] Country Specs
* [ ] External Accounts
* [x] Persons
* [ ] Top-ups
* [x] Transfers
* [x] Transfer Reversals
---
### Fraud
* [ ] Reviews
* [ ] Value Lists
* [ ] Value List Items
---
### Issuing
* [ ] Authorizations
* [ ] Cardholders
* [ ] Cards
* [ ] Disputes
* [ ] Transactions
---
### Terminal
* [ ] Connection Tokens
* [ ] Locations
* [ ] Readers
---
### Orders
* [x] Orders
* [x] Order Items
* [x] Returns
* [x] SKUs
* [x] Ephemeral Keys
---
### Sigma
* [ ] Scheduled Queries
---
### Webhooks
* [ ] Webhook Endpoints

[stripe_home]: http://stripe.com "Stripe"
[stripe_api]: https://stripe.com/docs/api "Stripe API Endpoints"

## License

Stripe is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Want to help?
Feel free to submit a pull request whether it's a clean up, a new approach to handling things, adding a new part of the API, or even if it's just a typo. All help is welcomed! 😀
