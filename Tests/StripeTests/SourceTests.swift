////
////  SourceTests.swift
////  Stripe
////
////  Created by Andrew Edwards on 6/2/17.
////
////
//
//import XCTest
//
//@testable import Stripe
//@testable import Vapor
//
//
//
//
//
//class SourceTests: XCTestCase {
//    
//    var drop: Droplet?
//    var sourceId: String = ""
//    override func setUp() {
//        do {
//            drop = try self.makeDroplet()
//            
//            let card = Node(["number":"4242 4242 4242 4242", "cvc":123,"exp_month":10, "exp_year":2018])
//            
//            sourceId = try drop?.stripe?.sources.createNewSource(sourceType: .card,
//                                                                source: card,
//                                                                amount: nil,
//                                                                currency: nil,
//                                                                flow: nil,
//                                                                owner: nil,
//                                                                redirectReturnUrl: nil,
//                                                                token: nil,
//                                                                usage: nil,
//                                                                metadata: nil).serializedResponse().id ?? ""
//
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            fatalError("Setup failed: \(error.localizedDescription)")
//        }
//    }
//    
//    override func tearDown() {
//        drop = nil
//        sourceId = ""
//    }
//    
//    func testRetrieveSource() throws {
//        do {
//            let retrievedSource = try drop?.stripe?.sources.retrieveSource(withId: sourceId).serializedResponse()
//            
//            XCTAssertNotNil(retrievedSource)
//            
//            XCTAssertEqual(retrievedSource?.type, SourceType.card)
//            
//            XCTAssertNotNil(retrievedSource?.returnedSource)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testUpdateSource() throws {
//        do {
//            let metadata = try Node(node:["hello": "world"])
//            
//            let updatedSource = try drop?.stripe?.sources.update(owner: nil,
//                                                                 metadata: metadata,
//                                                                 forSourceId: sourceId).serializedResponse()
//            
//            XCTAssertNotNil(updatedSource)
//            
//            XCTAssertEqual(updatedSource?.metadata?["hello"], metadata["hello"])
//            
//            XCTAssertEqual(updatedSource?.type, SourceType.card)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//}

