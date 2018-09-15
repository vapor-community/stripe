//
//  FileUpload.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/15/18.
//

import Vapor

/// There are various times when you’ll want to upload files to Stripe (for example, when uploading dispute evidence). This can be done by creating a File Upload object. When you upload a file, the API responds with a file upload token and other information about the upload. The token can then be used to retrieve a File Upload object.
public struct StripeFileUpload: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// A filename for the file, suitable for saving to a filesystem.
    public var filename: String?
    /// A list of file links.
    public var links: FileLinkList?
    /// The purpose of the uploaded file.
    public var purpose: FilePurpose?
    /// The size in bytes of the file upload object.
    public var size: Int?
    /// The type of the file returned.
    public var type: FileType?
    /// A read-only URL where the uploaded file can be accessed. Will be nil if the purpose of the uploaded file is identity_document. Also nil if retrieved with the publishable API key.
    public var url: String?
}

public enum FilePurpose: String, Content {
    case businessLogo = "business_logo"
    case customerSignature = "customer_signature"
    case disputeEvidence = "dispute_evidence"
    case identityDocument = "identity_document"
    case pciDocument = "pci_document"
    case taxDocumentUserUpload = "tax_document_user_upload"
}

public enum FileType: String, Content {
    case csv
    case docx
    case gif
    case jpg
    case pdf
    case png
    case xls
    case xlsx
}
