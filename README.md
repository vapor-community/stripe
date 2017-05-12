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
.Package(url: "https://github.com/anthonycastelli/vapor-stripe.git", Version(0,0,1, prereleaseIdentifiers: ["beta"]))
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

## Whats Implemented
* [x] Balance Fetching
    * [x] History
    * [x] Balance by ID
* [x] Charges
    * [x] Creating Charges
    * [x] Retrieving a charge by id
    * [x] Listing all charges
    * [x] Updating a charge
    * [x] Capturing a charge
* [x] Customers
    * [x] Creating
    * [x] Updating
    * [x] Deleting
    * [x] Fetching by Customer ID
    * [x] Listing All Customers (With filters)
* [ ] Disputes
* [ ] Events
* [ ] Refunds
* [x] Tokens
	* [x] Card Creation
	* [x] Bank Creation
	* [x] Token Retrieval
* [ ] Cards
* [ ] Orders
* [ ] Order Items

[stripe_home]: http://stripe.com "Stripe"
[stripe_api]: https://stripe.com/docs/api "Stripe API Endpoints"
