//
//  FileRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/15/18.
//

import Vapor

public protocol FileRoutes {
    /// Uploads a file to Stripe
    ///
    /// - Parameters:
    ///   - file: A file to upload.
    ///   - purpose: The purpose of the uploaded file.
    ///   - filename: The name of the file.
    ///   - type: The MIME type of the file.
    /// - Returns: The file object.
    func upload(file: Data, purpose: FilePurpose, filename: String, type: FileType) throws -> Future<StripeFileUpload>
    
    /// Retrieves the details of an existing file object. Supply the unique file upload ID from a file creation request, and Stripe will return the corresponding transfer information.
    ///
    /// - Parameter id: The identifier of the file upload to be retrieved.
    /// - Returns: Returns a file upload object if a valid identifier was provided, and returns an error otherwise.
    func retrieve(id: String) throws -> Future<StripeFileUpload>
    
    /// Returns a list of the files that you have uploaded to Stripe. The file uploads are returned sorted by creation date, with the most recently created file uploads appearing first.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/curl#list_file_uploads).
    /// - Returns: A `FileUploadList`
    func listAll(filter: [String: Any]?) throws -> Future<FileUploadList>
}

extension FileRoutes {
    public func upload(file: Data, purpose: FilePurpose, filename: String, type: FileType) throws -> Future<StripeFileUpload> {
        return try upload(file: file, purpose: purpose, filename: filename, type: type)
    }
    
    public func retrieve(id: String) throws -> Future<StripeFileUpload> {
        return try retrieve(id: id)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> Future<FileUploadList> {
        return try listAll(filter: filter)
    }
}

public struct StripeFileRoutes: FileRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    public func upload(file: Data, purpose: FilePurpose, filename: String, type: FileType) throws -> Future<StripeFileUpload> {
        var headers: HTTPHeaders = [:]
        var body: Data = Data()
        
        guard let fileType = MediaType.fileExtension(type.rawValue) else {
            throw StripeUploadError.unsupportedFileType
        }
        
        // Fordm data structure found here.
        // https://www.w3.org/TR/html401/interact/forms.html#h-17.13.4
        
        let boundary = "Stripe-Vapor-\(UUID().uuidString)"
        headers.replaceOrAdd(name: .contentType, value: MediaType(type: "multipart",
                                                                  subType: "form-data",
                                                                  parameters: ["boundary": boundary]).description)
        body.append("\r\n--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"purpose\"\"\r\n\r\n")
        body.append("\(purpose.rawValue)")
        body.append("\r\n--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(fileType.description)\r\n\r\n")
        body.append(file)
        body.append("\r\n--\(boundary)--")
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.file.endpoint, body: body, headers: headers)
    }
    
    public func retrieve(id: String) throws -> Future<StripeFileUpload> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.files(id).endpoint)
    }
    
    public func listAll(filter: [String: Any]?) throws -> Future<FileUploadList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.file.endpoint, query: queryParams)
    }
}

/// Thank you @vzsg for this nice little clean snippet
private extension Data {
    mutating func append(_ string: String) {
        guard let data = string.data(using: .utf8) else {
            return
        }
        self.append(data)
    }
}
