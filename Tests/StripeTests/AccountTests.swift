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
  "business_logo": "logourl",
  "business_name": "Stripe.com",
  "business_url": "https://www.stripe.com",
  "charges_enabled": false,
  "country": "US",
  "created": 1385798567,
  "debit_negative_balances": true,
  "decline_charge_on": {
    "avs_failure": true,
    "cvc_failure": false
  },
  "default_currency": "usd",
  "details_submitted": false,
  "display_name": "Stripe.com",
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
                "fingerprint": "H5flqusa75kgwmml",
                "funding": "unknown",
                "id": "card_1BoJ2IKrZ43eBVAbSXsWRMXT",
                "last4": "4242",
                "metadata": {},
                "object": "card"
            }
    ],
    "has_more": false,
    "total_count": 2,
    "url": "/v1/accounts/acct_1032D82eZvKYlo2C/external_accounts"
  },
  "legal_entity": {
    "additional_owners": [
        {
            "first_name": "Malcom",
            "last_name": "X",
            "maiden_name": "old",
            "personal_id_number_provided": true,
            "verification": {
              "details": null,
              "details_code": "failed_other",
              "document": null,
              "status": "verified"
            },
            "dob": {
              "day": 10,
              "month": 10,
              "year": 2016
            }
        }
    ],
    "address": {
      "city": null,
      "country": "US",
      "line1": null,
      "line2": null,
      "postal_code": null,
      "state": null
    },
    "business_name": "Vapor codes",
    "business_tax_id_provided": false,
    "dob": {
      "day": 10,
      "month": 10,
      "year": 2016
    },
    "first_name": "Mike",
    "last_name": "Jones",
    "personal_address": {
      "city": null,
      "country": "US",
      "line1": null,
      "line2": null,
      "postal_code": "12345",
      "state": null
    },
    "personal_id_number_provided": false,
    "ssn_last_4_provided": false,
    "type": "individual",
    "verification": {
      "details": null,
      "details_code": "failed_other",
      "document": null,
      "status": "unverified"
    }
  },
  "metadata": {
  },
  "payout_schedule": {
    "delay_days": 7,
    "interval": "daily"
  },
  "payout_statement_descriptor": "",
  "payouts_enabled": false,
  "product_description": "Vapor",
  "statement_descriptor": "",
  "support_email": null,
  "support_phone": null,
  "timezone": "US/Pacific",
  "tos_acceptance": {
    "date": 1385798567,
    "ip": "0.0.0.0",
    "user_agent": "ios-safari"
  },
  "type": "standard",
  "verification": {
    "disabled_reason": "fields_needed",
    "due_by": 1385798567,
    "fields_needed": [
      "business_url",
      "external_account",
      "legal_entity.address.city",
      "legal_entity.address.line1",
      "legal_entity.address.postal_code",
      "legal_entity.address.state",
      "legal_entity.dob.day",
      "legal_entity.dob.month",
      "legal_entity.dob.year",
      "legal_entity.first_name",
      "legal_entity.last_name",
      "legal_entity.type",
      "product_description",
      "support_phone",
      "tos_acceptance.date",
      "tos_acceptance.ip"
    ]
  }
}
"""
    
    func testAccountParsedProperll() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let body = HTTPBody(string: accountString)
            let futureAccount = try decoder.decode(StripeConnectAccount.self, from: body, on: EmbeddedEventLoop())
            
            futureAccount.do { (account) in
                XCTAssertEqual(account.id, "acct_1032D82eZvKYlo2C")
                XCTAssertEqual(account.object, "account")
                XCTAssertEqual(account.businessLogo, "logourl")
                XCTAssertEqual(account.businessName, "Stripe.com")
                XCTAssertEqual(account.businessUrl, "https://www.stripe.com")
                XCTAssertEqual(account.chargesEnabled, false)
                XCTAssertEqual(account.country, "US")
                XCTAssertEqual(account.created, Date(timeIntervalSince1970: 1385798567))
                XCTAssertEqual(account.debitNegativeBalances, true)
                XCTAssertEqual(account.declineChargeOn?["avsFailure"], true)
                XCTAssertEqual(account.declineChargeOn?["cvcFailure"], false)
                XCTAssertEqual(account.defaultCurrency, .usd)
                XCTAssertEqual(account.detailsSubmitted, false)
                XCTAssertEqual(account.displayName, "Stripe.com")
                XCTAssertEqual(account.email, "site@stripe.com")
                
                // Payout Schedule
                XCTAssertEqual(account.payoutSchedule?.delayDays, 7)
                XCTAssertEqual(account.payoutSchedule?.interval, .daily)
                
                XCTAssertEqual(account.payoutStatementDescriptor, "")
                XCTAssertEqual(account.payoutsEnabled, false)
                XCTAssertEqual(account.productDescription, "Vapor")
                XCTAssertEqual(account.statementDescriptor, "")
                XCTAssertEqual(account.supportEmail, nil)
                XCTAssertEqual(account.supportPhone, nil)
                XCTAssertEqual(account.timezone, "US/Pacific")
                
                // TOS acceptance
                XCTAssertEqual(account.tosAcceptance?.date, Date(timeIntervalSince1970: 1385798567))
                XCTAssertEqual(account.tosAcceptance?.ip, "0.0.0.0")
                XCTAssertEqual(account.tosAcceptance?.userAgent, "ios-safari")
                
                XCTAssertEqual(account.type, .standard)
                
                // Verification
                XCTAssertEqual(account.verification?.disabledReason, "fields_needed")
                XCTAssertEqual(account.verification?.dueBy, Date(timeIntervalSince1970: 1385798567))
                XCTAssertEqual(account.verification?.fieldsNeeded, ["business_url",
                                                                    "external_account",
                                                                    "legal_entity.address.city",
                                                                    "legal_entity.address.line1",
                                                                    "legal_entity.address.postal_code",
                                                                    "legal_entity.address.state",
                                                                    "legal_entity.dob.day",
                                                                    "legal_entity.dob.month",
                                                                    "legal_entity.dob.year",
                                                                    "legal_entity.first_name",
                                                                    "legal_entity.last_name",
                                                                    "legal_entity.type",
                                                                    "product_description",
                                                                    "support_phone",
                                                                    "tos_acceptance.date",
                                                                    "tos_acceptance.ip"])
                
                // ExternalAccounts
                XCTAssertEqual(account.externalAccounts?.object, "list")
                XCTAssertEqual(account.externalAccounts?.hasMore, false)
                XCTAssertEqual(account.externalAccounts?.totalCount, 2)
                XCTAssertEqual(account.externalAccounts?.url, "/v1/accounts/acct_1032D82eZvKYlo2C/external_accounts")
                XCTAssertEqual(account.externalAccounts?.cardAccounts?.count, 1)
                XCTAssertEqual(account.externalAccounts?.bankAccounts?.count, 1)
                XCTAssertEqual(account.externalAccounts?.cardAccounts?[0].id, "card_1BoJ2IKrZ43eBVAbSXsWRMXT")
                XCTAssertEqual(account.externalAccounts?.bankAccounts?[0].id, "ba_1BnxhQ2eZvKYlo2C5cM6hYK1")
                
                // LegalEntity
                XCTAssertEqual(account.legalEntity?.address?.country, "US")
                XCTAssertEqual(account.legalEntity?.businessName, "Vapor codes")
                XCTAssertEqual(account.legalEntity?.businessTaxIdProvided, false)
                XCTAssertEqual(account.legalEntity?.dob?["day"], 10)
                XCTAssertEqual(account.legalEntity?.dob?["month"], 10)
                XCTAssertEqual(account.legalEntity?.dob?["year"], 2016)
                XCTAssertEqual(account.legalEntity?.firstName, "Mike")
                XCTAssertEqual(account.legalEntity?.lastName, "Jones")
                XCTAssertEqual(account.legalEntity?.personalAddress?.country, "US")
                XCTAssertEqual(account.legalEntity?.personalAddress?.postalCode, "12345")
                XCTAssertEqual(account.legalEntity?.personalIdNumberProvided, false)
                XCTAssertEqual(account.legalEntity?.ssnLast4Provided, false)
                XCTAssertEqual(account.legalEntity?.type, "individual")
                XCTAssertEqual(account.legalEntity?.verification?.detailsCode, .failedOther)
                XCTAssertEqual(account.legalEntity?.verification?.status, .unverified)

                // Additional Owners
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].firstName, "Malcom")
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].lastName, "X")
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].maidenName, "old")
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].personalIdNumberProvided, true)
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].verification?.details, nil)
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].verification?.detailsCode, .failedOther)
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].verification?.document, nil)
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].verification?.status, .verified)
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].dob?["day"], 10)
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].dob?["month"], 10)
                XCTAssertEqual(account.legalEntity?.additionalOwners?[0].dob?["year"], 2016)
                
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
