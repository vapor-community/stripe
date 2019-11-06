# StripeProvider

![Swift](http://img.shields.io/badge/swift-5.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-4.0-brightgreen.svg)


### StripeProvider is a Vapor wrapper around [StripeKit](https://github.com/vapor-community/StripeKit)

## API versioning
The current version of StripeProvider supports api version [2019-11-05](https://stripe.com/docs/upgrades#2019-11-05)
Check the releases page to pin the StripeProvider to a specific Stripe API version.
(But you should probably upgrade when you get a chance to stay current 😉)

## Usage guide
In your `Package.swift` file, add the following

~~~~swift
.package(url: "https://github.com/vapor-community/stripe-provider.git", from: "3.0.0-beta")
~~~~

Register the provider in `configure.swift`
~~~~swift
import Stripe

app.provider(StripeProvider(apiKey: "YOUR_API_KEY"))
~~~~

Now to make a charge
~~~~swift
import Stripe

struct ChargeToken: Content {
    var stripeToken: String
}

func chargeCustomer(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
    return try req.content.decode(ChargeToken.self).flatMap { charge in
        return req.make(StripeClient.self).charge.create(amount: 2500, currency: .usd, source: charge.stripeToken).map { stripeCharge in
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

## License

Vapor Stripe Provider is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Want to help?
Feel free to submit a pull request whether it's a clean up, a new approach to handling things, adding a new part of the API, or even if it's just a typo. All help is welcomed! 😀
