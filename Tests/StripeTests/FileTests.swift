//
//  FileTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 9/15/18.
//

import XCTest
@testable import Stripe
@testable import Vapor

class FileTests: XCTestCase {
    let fileLinkString = """
{
  "id": "link_1DAf602eZvKYlo2CwXzohqY4",
  "object": "file_link",
  "created": 1537023004,
  "expired": false,
  "expires_at": null,
  "file": "file_1CcHwQ2eZvKYlo2CS8LDX4wK",
  "livemode": false,
  "metadata": {
  },
  "url": "https://files.stripe.com/links/fl_test_iBHkHOhKU7YuwN7wXjKGOhcw"
}
"""
    
    func testFileLinkParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: fileLinkString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let fileLink = try decoder.decode(StripeFileLink.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            fileLink.do { (link) in
                XCTAssertEqual(link.id, "link_1DAf602eZvKYlo2CwXzohqY4")
                XCTAssertEqual(link.object, "file_link")
                XCTAssertEqual(link.created, Date(timeIntervalSince1970: 1537023004))
                XCTAssertEqual(link.expired, false)
                XCTAssertEqual(link.expiresAt, nil)
                XCTAssertEqual(link.file, "file_1CcHwQ2eZvKYlo2CS8LDX4wK")
                XCTAssertEqual(link.livemode, false)
                XCTAssertEqual(link.metadata, [:])
                XCTAssertEqual(link.url, "https://files.stripe.com/links/fl_test_iBHkHOhKU7YuwN7wXjKGOhcw")
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
    
    let fileUploadString = """
{
  "id": "file_1CcHwQ2eZvKYlo2CS8LDX4wK",
  "object": "file_upload",
  "created": 1528830846,
  "filename": "icon1.png",
  "links": {
    "object": "list",
    "data": [
      {
        "id": "link_1DAf5z2eZvKYlo2CScuVuZnv",
        "object": "file_link",
        "created": 1537023003,
        "expired": false,
        "expires_at": null,
        "file": "file_1CcHwQ2eZvKYlo2CS8LDX4wK",
        "livemode": false,
        "metadata": {
        },
        "url": "https://files.stripe.com/links/fl_test_980v1485SYKS1DVGCO5SFd7d"
      }
    ],
    "has_more": true,
    "url": "/v1/file_links?file=file_1CcHwQ2eZvKYlo2CS8LDX4wK"
  },
  "purpose": "business_logo",
  "size": 9676,
  "type": "png",
  "url": "https://files.stripe.com/files/f_test_F3TKCoF1vHGS0B5EmdyH1sUn"
}
"""
    
    func testFileUploadParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: fileUploadString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let fileUpload = try decoder.decode(StripeFileUpload.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            fileUpload.do { (upload) in
                XCTAssertEqual(upload.id, "file_1CcHwQ2eZvKYlo2CS8LDX4wK")
                XCTAssertEqual(upload.object, "file_upload")
                XCTAssertEqual(upload.created, Date(timeIntervalSince1970: 1528830846))
                XCTAssertEqual(upload.filename, "icon1.png")
                XCTAssertEqual(upload.purpose, .businessLogo)
                XCTAssertEqual(upload.size, 9676)
                XCTAssertEqual(upload.type, .png)
                XCTAssertEqual(upload.url, "https://files.stripe.com/files/f_test_F3TKCoF1vHGS0B5EmdyH1sUn")
                
                XCTAssertEqual(upload.links?.object, "list")
                XCTAssertEqual(upload.links?.hasMore, true)
                XCTAssertEqual(upload.links?.url, "/v1/file_links?file=file_1CcHwQ2eZvKYlo2CS8LDX4wK")
                XCTAssertEqual(upload.links?.data?.count, 1)
                
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
