//
//  SourceTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/2/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor

class SourceTests: XCTestCase {
    let decoder = JSONDecoder()
    
    override func setUp() {
        decoder.dateDecodingStrategy = .secondsSince1970
    }
    
    let cardSourceString = """
 {
  "id": "src_1AhIN74iJb0CbkEwmbRYPsd4",
  "object": "source",
  "amount": 20,
  "client_secret": null,
  "created": 1500471469,
  "currency": "usd",
  "flow": "redirect",
  "livemode": false,
  "metadata": {
    "hello": "world"
  },
  "owner": {
    "address": {
      "city": "Berlin",
      "country": "DE",
      "line1": "Nollendorfstraße 27",
      "line2": null,
      "postal_code": "10777",
      "state": null
    },
    "email": "jenny.rosen@example.com",
    "name": "Jenny Rosen",
    "phone": "1234567",
    "verified_address": null,
    "verified_email": null,
    "verified_name": null,
    "verified_phone": null
  },
"receiver": {
    "address": "121042882-38381234567890123",
    "amount_charged": 10,
    "amount_received": 101,
    "amount_returned": 110,
    "refund_attributes_method": "email",
    "refund_attributes_status": "missing"
  },
"redirect": {
    "failure_reason": "declined",
    "return_url": "https://www.google.com",
    "status": "pending",
    "url": "https://www.apple.com"
  },
"status": "chargeable",
"type": "card",
"usage": "reusable",
"card": {
        "funding": "credit",
        "exp_month": 6,
        "country": "US",
        "three_d_secure": "optional",
        "fingerprint": "6iB9myGBwx04f4XT",
        "last4": "4242",
        "brand": "Visa",
        "exp_year": 2019
    }
}
"""
    
    func testCardSourceParsedProperly() throws {
        do {
            let body = HTTPBody(string: cardSourceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let source = try decoder.decode(StripeSource.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            source.do { (source) in
                XCTAssertNil(source.threeDSecure)
                XCTAssertNil(source.giropay)
                XCTAssertNil(source.sepaDebit)
                XCTAssertNil(source.ideal)
                XCTAssertNil(source.sofort)
                XCTAssertNil(source.bancontact)
                XCTAssertNil(source.alipay)
                XCTAssertNil(source.p24)
                XCTAssertNil(source.achCreditTransfer)

                // Cards have already been tested in the token tests.
                XCTAssertNotNil(source.card)
                
                XCTAssertEqual(source.id, "src_1AhIN74iJb0CbkEwmbRYPsd4")
                XCTAssertEqual(source.object, "source")
                XCTAssertEqual(source.amount, 20)
                XCTAssertEqual(source.clientSecret, nil)
                XCTAssertEqual(source.created, Date(timeIntervalSince1970: 1500471469))
                XCTAssertEqual(source.currency, .usd)
                XCTAssertEqual(source.flow, Flow.redirect)
                XCTAssertEqual(source.livemode, false)
                XCTAssertEqual(source.metadata["hello"], "world")
                XCTAssertEqual(source.status, .chargeable)
                XCTAssertEqual(source.type, .card)
                XCTAssertEqual(source.usage, "reusable")
                
                // This tests covers the owner object
                XCTAssertNotNil(source.owner)
                XCTAssertEqual(source.owner?.address?.city, "Berlin")
                XCTAssertEqual(source.owner?.address?.country, "DE")
                XCTAssertEqual(source.owner?.address?.line1, "Nollendorfstraße 27")
                XCTAssertEqual(source.owner?.address?.line2, nil)
                XCTAssertEqual(source.owner?.address?.postalCode, "10777")
                XCTAssertEqual(source.owner?.address?.state, nil)
                XCTAssertEqual(source.owner?.email, "jenny.rosen@example.com")
                XCTAssertEqual(source.owner?.name, "Jenny Rosen")
                XCTAssertEqual(source.owner?.phone, "1234567")
                XCTAssertEqual(source.owner?.verifiedEmail, nil)
                XCTAssertEqual(source.owner?.verifiedName, nil)
                XCTAssertEqual(source.owner?.verifiedPhone, nil)
                
                // This tests covers the receiver object
                XCTAssertNotNil(source.receiver)
                XCTAssertEqual(source.receiver?.address, "121042882-38381234567890123")
                XCTAssertEqual(source.receiver?.amountCharged, 10)
                XCTAssertEqual(source.receiver?.amountReceived, 101)
                XCTAssertEqual(source.receiver?.amountReturned, 110)
                XCTAssertEqual(source.receiver?.refundAttributesMethod, "email")
                XCTAssertEqual(source.receiver?.refundAttributesStatus, "missing")
                
                // This tests covers the redirect object
                XCTAssertNotNil(source.redirect)
                XCTAssertEqual(source.redirect?.failureReason, "declined")
                XCTAssertEqual(source.redirect?.returnUrl, "https://www.google.com")
                XCTAssertEqual(source.redirect?.status, "pending")
                XCTAssertEqual(source.redirect?.url, "https://www.apple.com")
                
            }.catch { (error) in
                XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    let threeDSecureSourceString = """
    {
    "id": "src_19YlvWAHEMiOZZp1QQlOD79v",
    "object": "source",
    "amount": 1099,
    "client_secret": "src_client_secret_kBwCSm6Xz5MQETiJ43hUH8qv",
    "created": 1483663790,
    "currency": "eur",
    "flow": "redirect",
    "livemode": false,
    "metadata": {},
    "owner": {
    "address": null,
    "email": null,
    "name": null,
    "phone": null,
    "verified_address": null,
    "verified_email": null,
    "verified_name": null,
    "verified_phone": null
    },
    "redirect": {
    "return_url": "https://shop.example.com/crtA6B28E1",
    "status": "pending",
    "url": "https://hooks.stripe.com/redirect/authenticate/src_19YlvWAHEMiOZZp1QQlOD79v?client_secret=src_client_secret_kBwCSm6Xz5MQETiJ43hUH8qv"
    },
    "status": "pending",
    "type": "three_d_secure",
    "usage": "single_use",
    "three_d_secure": {
    "card": "src_19YP2AAHEMiOZZp1Di4rt1K6",
    "customer": null,
    "authenticated": false
    }
    }
"""
    
    func testThreeDSecureSourceParsedProperly() throws {
        do {
            let body = HTTPBody(string: threeDSecureSourceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let source = try decoder.decode(StripeSource.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            source.do { (source) in
                XCTAssertNil(source.card)
                XCTAssertNil(source.giropay)
                XCTAssertNil(source.sepaDebit)
                XCTAssertNil(source.ideal)
                XCTAssertNil(source.sofort)
                XCTAssertNil(source.bancontact)
                XCTAssertNil(source.alipay)
                XCTAssertNil(source.p24)
                XCTAssertNil(source.achCreditTransfer)
                
                XCTAssertNotNil(source.threeDSecure)
                XCTAssertEqual(source.threeDSecure?.card, "src_19YP2AAHEMiOZZp1Di4rt1K6")
                XCTAssertEqual(source.threeDSecure?.customer, nil)
                XCTAssertEqual(source.threeDSecure?.authenticated, false)

                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    let sepaDebitSourceString = """
{
  "id": "src_18HgGjHNCLa1Vra6Y9TIP6tU",
  "object": "source",
  "amount": null,
  "client_secret": "src_client_secret_XcBmS94nTg5o0xc9MSliSlDW",
  "created": 1464803577,
  "currency": "eur",
  "flow": "none",
  "metadata": {},
  "livemode": false,
  "owner": {
    "address": null,
    "email": null,
    "name": "Jenny Rosen",
    "phone": null,
    "verified_address": null,
    "verified_email": null,
    "verified_name": null,
    "verified_phone": null
  },
  "status": "chargeable",
  "type": "sepa_debit",
  "usage": "reusable",
  "sepa_debit": {
    "bank_code": "37040044",
    "country": "DE",
    "fingerprint": "NxdSyRegc9PsMkWy",
    "last4": "3001",
    "mandate_reference": "NXDSYREGC9PSMKWY",
    "mandate_url": "https://hooks.stripe.com/adapter/sepa_debit/file/src_18HgGjHNCLa1Vra6Y9TIP6tU/src_client_secret_XcBmS94nTg5o0xc9MSliSlDW"
  }
}
"""
    
    func testSepaDebitSourceParsedProperly() throws {
        do {
            let body = HTTPBody(string: sepaDebitSourceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let source = try decoder.decode(StripeSource.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            source.do { (source) in
                XCTAssertNil(source.card)
                XCTAssertNil(source.giropay)
                XCTAssertNil(source.threeDSecure)
                XCTAssertNil(source.ideal)
                XCTAssertNil(source.sofort)
                XCTAssertNil(source.bancontact)
                XCTAssertNil(source.alipay)
                XCTAssertNil(source.p24)
                XCTAssertNil(source.achCreditTransfer)
                
                XCTAssertNotNil(source.sepaDebit)
                XCTAssertEqual(source.sepaDebit?.bankCode, "37040044")
                XCTAssertEqual(source.sepaDebit?.country, "DE")
                XCTAssertEqual(source.sepaDebit?.fingerprint, "NxdSyRegc9PsMkWy")
                XCTAssertEqual(source.sepaDebit?.last4, "3001")
                XCTAssertEqual(source.sepaDebit?.mandateReference, "NXDSYREGC9PSMKWY")
                XCTAssertEqual(source.sepaDebit?.mandateUrl, "https://hooks.stripe.com/adapter/sepa_debit/file/src_18HgGjHNCLa1Vra6Y9TIP6tU/src_client_secret_XcBmS94nTg5o0xc9MSliSlDW")
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    let alipaySourceString = """
{
  "id": "src_16xhynE8WzK49JbAs9M21jaR",
  "object": "source",
  "amount": 1099,
  "client_secret": "src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU",
  "created": 1445277809,
  "currency": "usd",
  "flow": "redirect",
  "metadata": {},
  "livemode": true,
  "owner": {
    "address": null,
    "email": null,
    "name": "null",
    "phone": null,
    "verified_address": null,
    "verified_email": null,
    "verified_name": "null",
    "verified_phone": null
  },
  "redirect": {
    "return_url": "https://shop.example.com/crtA6B28E1",
    "status": "pending",
    "url": "https://pay.stripe.com/redirect/src_16xhynE8WzK49JbAs9M21jaR?client_secret=src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU"
  },
  "statement_descriptor": null,
  "status": "pending",
  "type": "alipay",
  "usage": "single_use",
  "alipay": {
    "statement_descriptor": "Veggies are healthy",
    "native_url": "https://www.vapor.codes"
  }
}
"""

    func testAlipaySourceParsedProperly() throws {
        do {
            let body = HTTPBody(string: alipaySourceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let source = try decoder.decode(StripeSource.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            source.do { (source) in
                XCTAssertNil(source.card)
                XCTAssertNil(source.giropay)
                XCTAssertNil(source.threeDSecure)
                XCTAssertNil(source.ideal)
                XCTAssertNil(source.sofort)
                XCTAssertNil(source.bancontact)
                XCTAssertNil(source.sepaDebit)
                XCTAssertNil(source.p24)
                XCTAssertNil(source.achCreditTransfer)
                
                XCTAssertNotNil(source.alipay)
                XCTAssertEqual(source.alipay?.statementDescriptor, "Veggies are healthy")
                XCTAssertEqual(source.alipay?.nativeUrl, "https://www.vapor.codes")
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    
    let giroPaySourceString = """
{
  "id": "src_16xhynE8WzK49JbAs9M21jaR",
  "object": "source",
  "amount": 1099,
  "client_secret": "src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU",
  "created": 1445277809,
  "currency": "eur",
  "flow": "redirect",
  "metadata": {},
  "livemode": true,
  "owner": {
    "address": null,
    "email": null,
    "name": null,
    "phone": null,
    "verified_address": null,
    "verified_email": null,
    "verified_name": "Jenny Rosen",
    "verified_phone": null
  },
  "redirect": {
    "return_url": "https://shop.example.com/crtA6B28E1",
    "status": "pending",
    "url": "https://pay.stripe.com/redirect/src_16xhynE8WzK49JbAs9M21jaR?client_secret=src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU"
  },
  "statement_descriptor": null,
  "status": "pending",
  "type": "giropay",
  "usage": "single_use",
  "giropay": {
    "bank_code": "76547382",
    "bic": "No idea what this is",
    "bank_name": "Vapor Bank",
    "statement_descriptor": "Buy more Vapor Cloud"
  }
}
"""
    
    func testGiropaySourceParsedProperly() throws {
        do {
            let body = HTTPBody(string: giroPaySourceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let source = try decoder.decode(StripeSource.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            source.do { (source) in
                XCTAssertNil(source.card)
                XCTAssertNil(source.alipay)
                XCTAssertNil(source.threeDSecure)
                XCTAssertNil(source.ideal)
                XCTAssertNil(source.sofort)
                XCTAssertNil(source.bancontact)
                XCTAssertNil(source.sepaDebit)
                XCTAssertNil(source.p24)
                XCTAssertNil(source.achCreditTransfer)
                
                XCTAssertNotNil(source.giropay)
                XCTAssertEqual(source.giropay?.bankCode, "76547382")
                XCTAssertEqual(source.giropay?.bic, "No idea what this is")
                XCTAssertEqual(source.giropay?.bankName, "Vapor Bank")
                XCTAssertEqual(source.giropay?.statementDescriptor, "Buy more Vapor Cloud")
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }

    
    let idealSourceString = """
{
  "id": "src_16xhynE8WzK49JbAs9M21jaR",
  "object": "source",
  "amount": 1099,
  "client_secret": "src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU",
  "created": 1445277809,
  "currency": "eur",
  "flow": "redirect",
  "metadata": {},
  "livemode": true,
  "owner": {
    "address": null,
    "email": null,
    "name": "Jenny Rosen",
    "phone": null,
    "verified_address": null,
    "verified_email": null,
    "verified_name": "Jenny Rosen",
    "verified_phone": null
  },
  "redirect": {
    "return_url": "https://shop.example.com/crtA6B28E1",
    "status": "pending",
    "url": "https://pay.stripe.com/redirect/src_16xhynE8WzK49JbAs9M21jaR?client_secret=src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU"
  },
  "statement_descriptor": null,
  "status": "pending",
  "type": "ideal",
  "usage": "single_use",
  "ideal": {
    "bank": "Vapor Bank",
    "bic": "who knows",
    "iban_last4": "1234",
    "statement_descriptor": "Buy more Vapor Cloud"
  }
}
"""
    
    func testIdealSourceParsedProperly() throws {
        do {
            let body = HTTPBody(string: idealSourceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let source = try decoder.decode(StripeSource.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            source.do { (source) in
                XCTAssertNil(source.card)
                XCTAssertNil(source.alipay)
                XCTAssertNil(source.threeDSecure)
                XCTAssertNil(source.giropay)
                XCTAssertNil(source.sofort)
                XCTAssertNil(source.bancontact)
                XCTAssertNil(source.sepaDebit)
                XCTAssertNil(source.p24)
                XCTAssertNil(source.achCreditTransfer)
                
                XCTAssertNotNil(source.ideal)
                XCTAssertEqual(source.ideal?.bank, "Vapor Bank")
                XCTAssertEqual(source.ideal?.bic, "who knows")
                XCTAssertEqual(source.ideal?.ibanLast4, "1234")
                XCTAssertEqual(source.ideal?.statementDescriptor, "Buy more Vapor Cloud")
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    
    let p24SourceString = """
{
  "id": "src_16xhynE8WzK49JbAs9M21jaR",
  "object": "source",
  "amount": 1099,
  "client_secret": "src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU",
  "created": 1445277809,
  "currency": "eur",
  "flow": "redirect",
  "metadata": {},
  "livemode": true,
  "owner": {
    "address": null,
    "email": "jenny.rosen@example.com",
    "name": "Jenny Rosen",
    "phone": null,
    "verified_address": null,
    "verified_email": "jenny.rosen@example.com",
    "verified_name": "Jenny Rosen",
    "verified_phone": null
  },
  "redirect": {
    "return_url": "https://shop.example.com/crtA6B28E1",
    "status": "pending",
    "url": "https://pay.stripe.com/redirect/src_16xhynE8WzK49JbAs9M21jaR?client_secret=src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU"
  },
  "statement_descriptor": null,
  "status": "pending",
  "type": "p24",
  "usage": "single_use",
  "p24": {
    "reference": "P24-000-111-222"
  }
}
"""
    
    func testP24SourceParsedProperly() throws {
        do {
            let body = HTTPBody(string: p24SourceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let source = try decoder.decode(StripeSource.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            source.do { (source) in
                XCTAssertNil(source.card)
                XCTAssertNil(source.alipay)
                XCTAssertNil(source.threeDSecure)
                XCTAssertNil(source.giropay)
                XCTAssertNil(source.sofort)
                XCTAssertNil(source.bancontact)
                XCTAssertNil(source.sepaDebit)
                XCTAssertNil(source.ideal)
                XCTAssertNil(source.achCreditTransfer)
                
                XCTAssertNotNil(source.p24)
                XCTAssertEqual(source.p24?.reference, "P24-000-111-222")
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    
    let sofortSourceString = """
{
  "id": "src_16xhynE8WzK49JbAs9M21jaR",
  "object": "source",
  "amount": 1099,
  "client_secret": "src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU",
  "created": 1445277809,
  "currency": "eur",
  "flow": "redirect",
  "metadata": {},
  "livemode": true,
  "owner": {
    "address": null,
    "email": null,
    "name": "Jenny Rosen",
    "phone": null,
    "verified_address": null,
    "verified_email": null,
    "verified_name": "Jenny Rosen",
    "verified_phone": null
  },
  "redirect": {
    "return_url": "https://shop.example.com/crtA6B28E1",
    "status": "pending",
    "url": "https://pay.stripe.com/redirect/src_16xhynE8WzK49JbAs9M21jaR?client_secret=src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU"
  },
  "statement_descriptor": null,
  "status": "pending",
  "type": "sofort",
  "usage": "single_use",
  "sofort": {
    "country": "DE",
    "bank_code": "34569",
    "bic": "Meh",
    "bank_name": "Vapor Bank",
    "iban_last4": "4560",
    "preferred_language": "English",
    "statement_descriptor": "Henlo friend"
  }
}
"""
    
    func testSofortSourceParsedProperly() throws {
        do {
            let body = HTTPBody(string: sofortSourceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let source = try decoder.decode(StripeSource.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            source.do { (source) in
                XCTAssertNil(source.card)
                XCTAssertNil(source.alipay)
                XCTAssertNil(source.threeDSecure)
                XCTAssertNil(source.giropay)
                XCTAssertNil(source.p24)
                XCTAssertNil(source.bancontact)
                XCTAssertNil(source.sepaDebit)
                XCTAssertNil(source.ideal)
                XCTAssertNil(source.achCreditTransfer)
                
                XCTAssertNotNil(source.sofort)
                XCTAssertEqual(source.sofort?.country, "DE")
                XCTAssertEqual(source.sofort?.bankCode, "34569")
                XCTAssertEqual(source.sofort?.bic, "Meh")
                XCTAssertEqual(source.sofort?.bankName, "Vapor Bank")
                XCTAssertEqual(source.sofort?.ibanLast4, "4560")
                XCTAssertEqual(source.sofort?.preferredLanguage, "English")
                XCTAssertEqual(source.sofort?.statementDescriptor, "Henlo friend")
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    
    let bancontactSourceString = """
{
  "id": "src_16xhynE8WzK49JbAs9M21jaR",
  "object": "source",
  "amount": 1099,
  "client_secret": "src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU",
  "created": 1445277809,
  "currency": "eur",
  "statement_descriptor": null,
  "flow": "redirect",
  "metadata": {},
  "livemode": true,
  "owner": {
    "address": null,
    "email": null,
    "name": "Jenny Rosen",
    "phone": null,
    "verified_address": null,
    "verified_email": null,
    "verified_name": "Jenny Rosen",
    "verified_phone": null
  },
  "redirect": {
    "return_url": "https://shop.example.com/crtA6B28E1",
    "status": "pending",
    "url": "https://pay.stripe.com/redirect/src_16xhynE8WzK49JbAs9M21jaR?client_secret=src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU"
  },
  "status": "pending",
  "type": "bancontact",
  "usage": "single_use",
  "bancontact": {
    "bank_code": "33333",
    "bic": "Unknown",
    "bank_name": "Vapor Bank",
    "statement_descriptor": "Eat veggies",
    "preferred_language": "English"
  }
}
"""
    
    func testBancontactSourceParsedProperly() throws {
        do {
            let body = HTTPBody(string: bancontactSourceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let source = try decoder.decode(StripeSource.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            source.do { (source) in
                XCTAssertNil(source.card)
                XCTAssertNil(source.alipay)
                XCTAssertNil(source.threeDSecure)
                XCTAssertNil(source.giropay)
                XCTAssertNil(source.p24)
                XCTAssertNil(source.sofort)
                XCTAssertNil(source.sepaDebit)
                XCTAssertNil(source.ideal)
                XCTAssertNil(source.achCreditTransfer)
                
                XCTAssertNotNil(source.bancontact)
                XCTAssertEqual(source.bancontact?.bankCode, "33333")
                XCTAssertEqual(source.bancontact?.bic, "Unknown")
                XCTAssertEqual(source.bancontact?.bankName, "Vapor Bank")
                XCTAssertEqual(source.bancontact?.statementDescriptor, "Eat veggies")
                XCTAssertEqual(source.bancontact?.preferredLanguage, "English")
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    let achSourceString = """
{
  "id": "src_16xhynE8WzK49JbAs9M21jaR",
  "object": "source",
  "amount": 1099,
  "client_secret": "src_client_secret_UfwvW2WHpZ0s3QEn9g5x7waU",
  "created": 1445277809,
  "currency": "eur",
  "statement_descriptor": null,
  "flow": "code_verification",
  "metadata": {},
  "livemode": true,
  "owner": {
    "address": null,
    "email": null,
    "name": "Jenny Rosen",
    "phone": null,
    "verified_address": null,
    "verified_email": null,
    "verified_name": "Jenny Rosen",
    "verified_phone": null
  },
  "code_verification": {
    "attempts_remaining": 30,
    "status": "pending",
  },
  "status": "pending",
  "type": "ach_credit_transfer",
  "usage": "single_use",
  "ach_credit_transfer": {
    "account_number": "test_52796e3294dc",
    "routing_number": "110000000",
    "fingerprint": "nfd2882gh38h",
    "bank_name": "TEST BANK",
    "swift_code": "TSTEZ122"
  }
}
"""
    
    func testACHSourceParsedProperly() throws {
        do {
            let body = HTTPBody(string: achSourceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let source = try decoder.decode(StripeSource.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            source.do { (source) in
                XCTAssertNil(source.card)
                XCTAssertNil(source.alipay)
                XCTAssertNil(source.threeDSecure)
                XCTAssertNil(source.giropay)
                XCTAssertNil(source.p24)
                XCTAssertNil(source.sofort)
                XCTAssertNil(source.sepaDebit)
                XCTAssertNil(source.ideal)
                XCTAssertNil(source.bancontact)
                
                XCTAssertNotNil(source.achCreditTransfer)
                XCTAssertEqual(source.achCreditTransfer?.accountNumber, "test_52796e3294dc")
                XCTAssertEqual(source.achCreditTransfer?.routingNumber, "110000000")
                XCTAssertEqual(source.achCreditTransfer?.fingerprint, "nfd2882gh38h")
                XCTAssertEqual(source.achCreditTransfer?.bankName, "TEST BANK")
                XCTAssertEqual(source.achCreditTransfer?.swiftCode, "TSTEZ122")
                
                // CodeVerification
                XCTAssertEqual(source.codeVerification?.attemptsRemaining, 30)
                XCTAssertEqual(source.codeVerification?.status, .pending)
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
}
