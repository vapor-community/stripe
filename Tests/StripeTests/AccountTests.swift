//
//  AccountTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/9/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor

class AccountTests: XCTestCase {
    let accountString = """
{
  "id": "acct_1032D82eZvKYlo2C",
  "object": "account",
  "business_profile": {
    "mcc": "hello",
    "name": "Vapor",
    "product_description": "Something",
    "support_address" : {
      "city": null,
      "country": "US",
      "line1": null,
      "line2": null,
      "postal_code": "12345",
      "state": null
    },
    "support_email": "a@b.com",
    "support_phone": "1",
    "support_url": "http",
    "url": "https://www.stripe.com"
   },
  "business_type": "individual",
  "capabilities": {
    "card_payments": "active",
    "platform_payments": "inactive"
  },
  "charges_enabled": false,
  "company": {
    "address": {
      "city": null,
      "country": "US",
      "line1": null,
      "line2": null,
      "postal_code": null,
      "state": null
    },
    "directors_provided": false,
    "name": "Vapor",
    "owners_provided": true,
    "phone": "1",
    "tax_id_provided": false,
    "tax_id_registrar": "bob",
    "vat_id_provided": true
  },
  "country": "US",
  "created": 1385798567,
  "default_currency": "usd",
  "details_submitted": false,
  "email": "site@stripe.com",
  "external_accounts": {
    "object": "list",
    "data": [
            {
                "id": "ba_1BnxhQ2eZvKYlo2C5cM6hYK1",
                "object": "bank_account",
                "account_holder_name": "Jane Austen",
                "account_holder_type": "individual",
                "bank_name": "STRIPE TEST BANK",
                "country": "US",
                "currency": "usd",
                "fingerprint": "1JWtPxqbdX5Gamtc",
                "last4": "6789",
                "metadata": {
                    "hello": "world"
                },
                "routing_number": "110000000",
                "status": "new"
            },
            {
                "brand": "Visa",
                "exp_month": 8,
                "exp_year": 2019,
                "country": "US",
                "fingerprint": "H5flqusa75kgwmml",
                "funding": "unknown",
                "id": "card_1BoJ2IKrZ43eBVAbSXsWRMXT",
                "last4": "4242",
                "metadata": {},
                "object": "card"
            }
    ],
    "has_more": false,
    "url": "/v1/accounts/acct_1032D82eZvKYlo2C/external_accounts"
  },
  "individual": {
    "id": "person_8VPUvxRDdnt3Q8",
    "object": "person",
    "account": "acct_16Ds3sAU9AiAmxbB",
    "address": {
      "city": null,
      "country": "US",
      "line1": null,
      "line2": null,
      "postal_code": null,
      "state": null
    },
    "created": 1434353476,
    "dob": {
      "day": 1,
      "month": 1,
      "year": 2019
    },
    "first_name": null,
    "id_number_provided": false,
    "last_name": "carl",
    "metadata": {},
    "relationship": {
      "account_opener": true,
      "director": false,
      "owner": true,
      "percent_ownership": 100.0,
      "title": "CEO"
    },
    "requirements": {
      "currently_due": [
        "dob.day",
        "dob.month",
        "dob.year",
        "first_name",
        "last_name",
        "ssn_last_4"
      ],
      "eventually_due": [],
      "past_due": []
    },
    "ssn_last_4_provided": false,
    "verification": {
      "details": null,
      "details_code": "scan_name_mismatch",
      "document": {
        "back": null,
        "details": null,
        "details_code": "document_id_country_not_supported",
        "front": null
      },
      "status": "unverified"
    }
  },
  "metadata": {
  },
  "payouts_enabled": false,
  "requirements": {
    "current_deadline": null,
    "currently_due": [
      "external_account",
      "individual.address.city",
      "individual.address.line1",
      "individual.address.postal_code",
      "individual.address.state",
      "individual.dob.day",
      "individual.dob.month",
      "individual.dob.year",
      "individual.first_name",
      "individual.last_name",
      "individual.ssn_last_4",
      "product_description",
      "tos_acceptance.date",
      "tos_acceptance.ip"
    ],
    "disabled_reason": "requirements.past_due",
    "eventually_due": [
      "external_account",
      "product_description",
      "tos_acceptance.date",
      "tos_acceptance.ip"
    ],
    "past_due": []
  },
  "settings": {
    "branding": {
      "icon": "wow",
      "logo": null,
      "primary_color": "FFFFFF"
    },
    "card_payments": {
      "decline_on": {
        "avs_failure": false,
        "cvc_failure": true
      }
    },
    "dashboard": {
      "display_name": "StripeVapor",
      "timezone": "America/Indianapolis"
    },
    "payments": {
      "statement_descriptor": "BLAH"
    },
    "payouts": {
      "debit_negative_balances": true,
      "schedule": {
        "delay_days": 2,
        "interval": "daily"
      },
      "statement_descriptor": "MORE"
    }
  },
  "tos_acceptance": {
    "date": 1385798567,
    "ip": "0.0.0.0",
    "user_agent": "ios-safari"
  },
  "type": "standard"
}
"""
    
    func testAccountParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: accountString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let account = try decoder.decode(StripeConnectAccount.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
            
            XCTAssertEqual(account.id, "acct_1032D82eZvKYlo2C")
            XCTAssertEqual(account.object, "account")
            XCTAssertEqual(account.businessProfile?.url, "https://www.stripe.com")
            XCTAssertEqual(account.businessProfile?.name, "Vapor")
            XCTAssertEqual(account.businessProfile?.mcc, "hello")
            XCTAssertEqual(account.businessProfile?.supportUrl, "http")
            XCTAssertEqual(account.businessProfile?.productDescription, "Something")
            XCTAssertEqual(account.businessProfile?.supportAddress?.postalCode, "12345")
            XCTAssertEqual(account.businessProfile?.supportPhone, "1")
            XCTAssertEqual(account.businessProfile?.supportEmail, "a@b.com")
            XCTAssertEqual(account.businessType, .individual)
            XCTAssertEqual(account.capabilities?.cardPayments, .active)
            XCTAssertEqual(account.capabilities?.platformPayments, .inactive)
            XCTAssertEqual(account.chargesEnabled, false)
            XCTAssertEqual(account.company?.address?.country, "US")
            XCTAssertEqual(account.company?.directorsProvided, false)
            XCTAssertEqual(account.company?.name, "Vapor")
            XCTAssertEqual(account.company?.ownersProvided, true)
            XCTAssertEqual(account.company?.phone, "1")
            XCTAssertEqual(account.company?.taxIdProvided, false)
            XCTAssertEqual(account.company?.taxIdRegistrar, "bob")
            XCTAssertEqual(account.company?.vatIdProvided, true)
            XCTAssertEqual(account.country, "US")
            XCTAssertEqual(account.created, Date(timeIntervalSince1970: 1385798567))
            XCTAssertEqual(account.defaultCurrency, .usd)
            XCTAssertEqual(account.detailsSubmitted, false)
            XCTAssertEqual(account.email, "site@stripe.com")
            
            // ExternalAccounts
            XCTAssertEqual(account.externalAccounts?.object, "list")
            XCTAssertEqual(account.externalAccounts?.hasMore, false)
            XCTAssertEqual(account.externalAccounts?.url, "/v1/accounts/acct_1032D82eZvKYlo2C/external_accounts")
            XCTAssertEqual(account.externalAccounts?.cardAccounts?.count, 1)
            XCTAssertEqual(account.externalAccounts?.bankAccounts?.count, 1)
            XCTAssertEqual(account.externalAccounts?.cardAccounts?[0].id, "card_1BoJ2IKrZ43eBVAbSXsWRMXT")
            XCTAssertEqual(account.externalAccounts?.bankAccounts?[0].id, "ba_1BnxhQ2eZvKYlo2C5cM6hYK1")
            
            // Individual/Person
            XCTAssertEqual(account.individual?.id, "person_8VPUvxRDdnt3Q8")
            XCTAssertEqual(account.individual?.object, "person")
            XCTAssertEqual(account.individual?.account, "acct_16Ds3sAU9AiAmxbB")
            XCTAssertEqual(account.individual?.address?.country, "US")
            XCTAssertEqual(account.individual?.created, Date(timeIntervalSince1970: 1434353476))
            XCTAssertEqual(account.individual?.dob?.day, 1)
            XCTAssertEqual(account.individual?.dob?.month, 1)
            XCTAssertEqual(account.individual?.dob?.year, 2019)
            XCTAssertEqual(account.individual?.firstName, nil)
            XCTAssertEqual(account.individual?.idNumberProvided, false)
            XCTAssertEqual(account.individual?.lastName, "carl")
            XCTAssertEqual(account.individual?.metadata, [:])
            XCTAssertEqual(account.individual?.relationship?.accountOpener, true)
            XCTAssertEqual(account.individual?.relationship?.director, false)
            XCTAssertEqual(account.individual?.relationship?.owner, true)
            XCTAssertEqual(account.individual?.relationship?.percentOwnership, 100.0)
            XCTAssertEqual(account.individual?.relationship?.title, "CEO")
            XCTAssertEqual(account.individual?.requirements?.currentlyDue?.count, 6)
            XCTAssertEqual(account.individual?.requirements?.eventuallyDue?.count, 0)
            XCTAssertEqual(account.individual?.requirements?.pastDue?.count, 0)
            XCTAssertEqual(account.individual?.ssnLast4Provided, false)
            XCTAssertEqual(account.individual?.verification?.details, nil)
            XCTAssertEqual(account.individual?.verification?.detailsCode, .scanNameMismatch)
            XCTAssertEqual(account.individual?.verification?.document?.detailsCode, .documentIdCountryNotSupported)
            XCTAssertEqual(account.individual?.verification?.status, .unverified)
            
            XCTAssertEqual(account.metadata, [:])
            XCTAssertEqual(account.payoutsEnabled, false)
            
            // Requirements
            XCTAssertEqual(account.requirements?.currentDeadline, nil)
            XCTAssertEqual(account.requirements?.currentlyDue?.count, 14)
            XCTAssertEqual(account.requirements?.disabledReason, "requirements.past_due")
            XCTAssertEqual(account.requirements?.eventuallyDue?.count, 4)
            XCTAssertEqual(account.requirements?.pastDue?.count, 0)
            
            // Settings
            XCTAssertEqual(account.settings?.branding?.icon, "wow")
            XCTAssertEqual(account.settings?.branding?.logo, nil)
            XCTAssertEqual(account.settings?.branding?.primaryColor, "FFFFFF")
            
            XCTAssertEqual(account.settings?.cardPayments?.declineOn?.avsFailure, false)
            XCTAssertEqual(account.settings?.cardPayments?.declineOn?.cvcFailure, true)
            
            XCTAssertEqual(account.settings?.dashboard?.displayName, "StripeVapor")
            XCTAssertEqual(account.settings?.dashboard?.timezone, "America/Indianapolis")
            
            XCTAssertEqual(account.settings?.payments?.statementDescriptor, "BLAH")
            XCTAssertEqual(account.settings?.payouts?.debitNegativeBalances, true)
            XCTAssertEqual(account.settings?.payouts?.schedule?.delayDays, 2)
            XCTAssertEqual(account.settings?.payouts?.schedule?.interval, .daily)
            XCTAssertEqual(account.settings?.payouts?.statementDescriptor, "MORE")
            
            // TOS acceptance
            XCTAssertEqual(account.tosAcceptance?.date, Date(timeIntervalSince1970: 1385798567))
            XCTAssertEqual(account.tosAcceptance?.ip, "0.0.0.0")
            XCTAssertEqual(account.tosAcceptance?.userAgent, "ios-safari")
            
            XCTAssertEqual(account.type, .standard)
        }
        catch {
            XCTFail("\(error)")
        }
    }
}
