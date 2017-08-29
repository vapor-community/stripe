//
//  ChargeTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor




class ChargeTests: XCTestCase {
    
    var drop: Droplet?
    var chargeId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            let tokenId = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
                                                                   expirationMonth: 10,
                                                                   expirationYear: 2018,
                                                                   cvc: 123,
                                                                   name: "Test Card",
                                                                   customer: nil,
                                                                   currency: nil)
                                                                   .serializedResponse().id ?? ""
            
            chargeId = try drop?.stripe?.charge.create(amount: 10_00,
                                                         in: .usd,
                                                         withFee: nil,
                                                         toAccount: nil,
                                                         capture: true,
                                                         description: "Vapor Stripe: Test Description",
                                                         destinationAccountId: nil,
                                                         destinationAmount: nil,
                                                         transferGroup: nil,
                                                         onBehalfOf: nil,
                                                         receiptEmail: nil,
                                                         shippingLabel: nil,
                                                         customer: nil,
                                                         statementDescriptor: nil,
                                                         source: tokenId,
                                                         metadata: nil)
                                                         .serializedResponse().id ?? ""
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    override func tearDown() {
        drop = nil
        chargeId = ""
    }
    
    func testCharge() throws {
        
        do {
            let paymentToken = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
                                                                        expirationMonth: 10,
                                                                        expirationYear: 2018,
                                                                        cvc: 123,
                                                                        name: "Test Card",
                                                                        customer: nil,
                                                                        currency: nil)
                                                                        .serializedResponse().id ?? ""
            
            let object = try drop?.stripe?.charge.create(amount: 10_00,
                                                         in: .usd,
                                                         withFee: nil,
                                                         toAccount: nil,
                                                         capture: true,
                                                         description: "Vapor Stripe: Test Description",
                                                         destinationAccountId: nil,
                                                         destinationAmount: nil,
                                                         transferGroup: nil,
                                                         onBehalfOf: nil,
                                                         receiptEmail: nil,
                                                         shippingLabel: nil,
                                                         customer: nil,
                                                         statementDescriptor: nil,
                                                         source: paymentToken,
                                                         metadata: nil)
                                                         .serializedResponse()
            XCTAssertNotNil(object)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testRetrieveCharge() throws {
        do {
            let object = try drop?.stripe?.charge.retrieve(charge: chargeId).serializedResponse()
            XCTAssertNotNil(object)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testListAllCharges() throws {
        do {
            let object = try drop?.stripe?.charge.listAll(filter: nil).serializedResponse()
            XCTAssertNotNil(object)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFilterAllCharges() throws {
        do {
            let filter = StripeFilter()
            filter.limit = 1
            let object = try drop?.stripe?.charge.listAll(filter: filter).serializedResponse()
            XCTAssertEqual(object?.items?.count, 1)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testChargeUpdate() throws {
        do {
            
            let description = "Vapor description"
            
            let fraudReport = try Node(node: ["user_report":FraudReport.safe.rawValue])
            let fraudDetails = try FraudDetails(node: fraudReport)
            
            let metadata = try Node(node:["hello": "world"])
            let receiptEmail = "vapor@stripetest.com"
            
            let shippingAddress = ShippingAddress()
            shippingAddress.addressLine1 = "123 Test St"
            shippingAddress.addressLine2 = "456 Apt"
            shippingAddress.city = "Test City"
            shippingAddress.state = "CA"
            shippingAddress.postalCode = "12345"
            shippingAddress.country = "US"
            
            let shippingLabel = ShippingLabel()
            shippingLabel.name = "Test User"
            shippingLabel.phone = "555-111-2222"
            shippingLabel.carrier = "FedEx"
            shippingLabel.trackingNumber = "1234567890"
            shippingLabel.address = shippingAddress
            
            let transferGroup = "Vapor group"
            
            let updatedCharge = try drop?.stripe?.charge.update(description: description,
                                                                fraud: fraudDetails,
                                                                receiptEmail: receiptEmail,
                                                                shippingLabel: shippingLabel,
                                                                transferGroup: transferGroup,
                                                                metadata: metadata,
                                                                charge: chargeId).serializedResponse()

            XCTAssertNotNil(updatedCharge)
            
            XCTAssertEqual(updatedCharge?.description, description)
            
            XCTAssertEqual(updatedCharge?.fraud?.userReport?.rawValue, fraudDetails.userReport?.rawValue)
            
            XCTAssertEqual(updatedCharge?.metadata?["hello"], metadata["hello"])
            
            XCTAssertEqual(updatedCharge?.receiptEmail, receiptEmail)
            
            XCTAssertEqual(updatedCharge?.shippingLabel?.name, shippingLabel.name)
            
            XCTAssertEqual(updatedCharge?.shippingLabel?.phone, shippingLabel.phone)
            
            XCTAssertEqual(updatedCharge?.shippingLabel?.carrier, shippingLabel.carrier)
            
            XCTAssertEqual(updatedCharge?.shippingLabel?.trackingNumber, shippingLabel.trackingNumber)
            
            // Verify address values
            
            XCTAssertEqual(updatedCharge?.shippingLabel?.address?.addressLine1, shippingAddress.addressLine1)
            
            XCTAssertEqual(updatedCharge?.shippingLabel?.address?.addressLine2, shippingAddress.addressLine2)
            
            XCTAssertEqual(updatedCharge?.shippingLabel?.address?.city, shippingAddress.city)
            
            XCTAssertEqual(updatedCharge?.shippingLabel?.address?.state, shippingAddress.state)
            
            XCTAssertEqual(updatedCharge?.shippingLabel?.address?.postalCode, shippingAddress.postalCode)
            
            XCTAssertEqual(updatedCharge?.shippingLabel?.address?.country, shippingAddress.country)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testChargeCapture() throws {
        do {
            let paymentToken = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
                                                                        expirationMonth: 10,
                                                                        expirationYear: 2018,
                                                                        cvc: 123,
                                                                        name: "Test Card",
                                                                        customer: nil,
                                                                        currency: nil)
                                                                        .serializedResponse().id ?? ""
            
            let uncapturedCharge = try drop?.stripe?.charge.create(amount: 10_00,
                                                                   in: .usd,
                                                                   withFee: nil,
                                                                   toAccount: nil,
                                                                   capture: false,
                                                                   description: "Vapor Stripe: Test Description",
                                                                   destinationAccountId: nil,
                                                                   destinationAmount: nil,
                                                                   transferGroup: nil,
                                                                   onBehalfOf: nil,
                                                                   receiptEmail: nil,
                                                                   shippingLabel: nil,
                                                                   customer: nil,
                                                                   statementDescriptor: nil,
                                                                   source: paymentToken,
                                                                   metadata: nil)
                                                                   .serializedResponse().id ?? ""
            
            let object = try drop?.stripe?.charge.capture(charge: uncapturedCharge,
                                                          amount: nil,
                                                          applicationFee: nil,
                                                          destinationAmount: nil,
                                                          receiptEmail: nil,
                                                          statementDescriptor: "Hello govna").serializedResponse()
            
            XCTAssertNotNil(object)
            
            XCTAssert(object?.isCaptured ?? false)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
}
