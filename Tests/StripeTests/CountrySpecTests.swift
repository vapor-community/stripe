//
//  CountrySpecTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 3/23/19.
//

import XCTest
@testable import Stripe
@testable import Vapor

class CountrySpecTests: XCTestCase {
    let countrySpecString = """
{
  "id": "US",
  "object": "country_spec",
  "default_currency": "usd",
  "supported_bank_account_currencies": {
    "usd": [
      "US"
    ]
  },
  "supported_payment_currencies": [
    "usd",
    "aed",
    "afn",
  ],
  "supported_payment_methods": [
    "card",
    "stripe"
  ],
  "supported_transfer_countries": [
    "US"
  ],
  "verification_fields": {
    "company": {
      "additional": [
        "relationship.account_opener"
      ],
      "minimum": [
        "business_profile.mcc",
        "business_profile.url",
        "business_type",
        "company.address.city",
        "company.address.line1",
        "company.address.postal_code",
        "company.address.state",
        "company.name",
        "company.phone",
        "company.tax_id",
        "external_account",
        "relationship.account_opener",
        "relationship.owner",
        "tos_acceptance.date",
        "tos_acceptance.ip"
      ]
    },
    "individual": {
      "additional": [
        "individual.id_number"
      ],
      "minimum": [
        "business_profile.mcc",
        "business_profile.url",
        "business_type",
        "external_account",
        "individual.address.city",
        "individual.address.line1",
        "individual.address.postal_code",
        "individual.address.state",
        "individual.dob.day",
        "individual.dob.month",
        "individual.dob.year",
        "individual.email",
        "individual.first_name",
        "individual.last_name",
        "individual.phone",
        "individual.ssn_last_4",
        "tos_acceptance.date",
        "tos_acceptance.ip"
      ]
    }
  }
}
"""
    
    func testCountrySpecParsesProperly() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let body = HTTPBody(string: countrySpecString)
        var headers: HTTPHeaders = [:]
        headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
        let request = HTTPRequest(headers: headers, body: body)
        let spec = try decoder.decode(StripeCountrySpec.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
        
        XCTAssertEqual(spec.supportedBankAccountCurrencies?["usd"], ["US"])
        XCTAssertEqual(spec.supportedPaymentCurrencies?.count, 3)
        XCTAssertEqual(spec.verificationFields?.company?.additional?.count, 1)
        XCTAssertEqual(spec.verificationFields?.individual?.minimum?.count, 18)
    }
}
