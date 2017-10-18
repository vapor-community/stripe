//
//  EphemeralKeyTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 10/17/17.
//

import XCTest

@testable import Stripe
@testable import Vapor

class EphemeralKeyTests: XCTestCase {
    
    var drop: Droplet?
    var ephemeralKeyId: String = ""
    
    override func setUp() {
        
        do {
            drop = try self.makeDroplet()
            
            let customerId = try drop?.stripe?.customer.create(description: "Vapor test Account",
                                                               email: "vapor@stripetest.com").serializedResponse().id ?? ""
            
            ephemeralKeyId = try drop?.stripe?.ephemeralKeys.create(customerId: customerId).serializedResponse().id ?? ""
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
    
    func testCreateEphemeralKey() throws {
        
        do {
            let customerId = try drop?.stripe?.customer.create(description: "Vapor test Account",
                                                               email: "vapor@stripetest.com").serializedResponse().id ?? ""
            
            let ephemeralKey = try drop?.stripe?.ephemeralKeys.create(customerId: customerId).serializedResponse()
            
            XCTAssertNotNil(ephemeralKey)
            
            XCTAssertNotNil(ephemeralKey?.associatedObjects?.array)
            
            XCTAssertNotNil(ephemeralKey?.associatedObjects?.array?.first)
            
            XCTAssertNotNil(ephemeralKey?.associatedObjects?.array?.first?.object)
            
            XCTAssertNotNil(ephemeralKey?.associatedObjects?.array?.first?.object?["type"]?.string)
            
            XCTAssertNotNil(ephemeralKey?.associatedObjects?.array?.first?.object?["id"]?.string)
            
            XCTAssertNotNil(ephemeralKey?.secret)
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
    
    func testDeleteEphemeralKey() throws {
        
        do {
            
            let ephemeralKey = try drop?.stripe?.ephemeralKeys.delete(ephemeralKeyId: ephemeralKeyId).serializedResponse()
            
            XCTAssertNotNil(ephemeralKey)
            
            XCTAssertNotNil(ephemeralKey?.associatedObjects?.array)
            
            XCTAssertNotNil(ephemeralKey?.associatedObjects?.array?.first)
            
            XCTAssertNotNil(ephemeralKey?.associatedObjects?.array?.first?.object)
            
            XCTAssertNotNil(ephemeralKey?.associatedObjects?.array?.first?.object?["type"]?.string)
            
            XCTAssertNotNil(ephemeralKey?.associatedObjects?.array?.first?.object?["id"]?.string)
            
            XCTAssertNil(ephemeralKey?.secret)
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
