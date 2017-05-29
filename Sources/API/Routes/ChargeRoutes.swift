//
//  ChargeRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Foundation
import Node
import HTTP
import Models
import Helpers

public enum ChargeType {
    /**
     A card or token id
    */
    case source(String)
    
    /**
     A customer id to charge
     */
    case customer(String)
}

public final class ChargeRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create a Charge
     To charge a credit card, you create a charge object. If your API key is in test mode, the supplied payment source 
     (e.g., card or Bitcoin receiver) won't actually be charged, though everything else will occur as if in live mode. 
     (Stripe assumes that the charge would have completed successfully).
     
     - parameter amount:      The payment amount in cents
     - parameter currency:    The currency in which the charge will be under
     - parameter type:        The charge type. Either source (card id or token id) or customer (a customer id to charge)
     - parameter description: An optional description for charges.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func create(amount: Int, in currency: StripeCurrency, for type: ChargeType, description: String? = nil, capture: Bool = true) throws -> StripeRequest<Charge> {
        return try self.create(amount: amount, in: currency, for: type, withFee: nil, toAccount: nil, description: description, receiptEmail: nil, capture: capture)
    }
    
    /**
     Create a Charge
     To charge a credit card, you create a charge object. If your API key is in test mode, the supplied payment source
     (e.g., card or Bitcoin receiver) won't actually be charged, though everything else will occur as if in live mode.
     (Stripe assumes that the charge would have completed successfully).
     
     NOTE: Accounts and Fees are only applicable to connected accounts
     
     - parameter amount:      The payment amount in cents
     - parameter currency:    The currency in which the charge will be under
     - parameter type:        The charge type. Either source (card id or token id) or customer (a customer id to charge)
     - parameter fee:         A fee to charge if you are using connected accounts (Must be in cents)
     - parameter account:     The account id which the payment would be sent to.
     - parameter description: An optional description for charges.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func create(amount: Int, in currency: StripeCurrency, for type: ChargeType, withFee fee: Int?, toAccount account: String?, description: String? = nil, receiptEmail: String? = nil, capture: Bool = true) throws -> StripeRequest<Charge> {
        // Setup our params
        var body: [String : Any] = [
            "amount": amount,
            "currency": currency.rawValue,
            "capture": capture
        ]
        switch type {
        case .source(let id): body["source"] = id
        case .customer(let id): body["customer"] = id
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        // Create the headers
        var headers: [HeaderKey : String]?
        if let fee = fee, let account = account {
            body["application_fee"] = fee
            headers = [
                StripeHeader.Account: account
            ]
        }
        
        // Create the body node
        let node = try Node(node: body)
        
        return try StripeRequest(client: self.client, method: .post, route: .charges, query: [:], body: Body.data(node.formURLEncoded()), headers: headers)
    }
    
    /**
     Update a charge
     Updates the specified charge by setting the values of the parameters passed. Any parameters not provided will be left 
     unchanged. This request accepts only the `description`, `metadata`, `receipt_email`, `fraud_details`, and `shipping` as arguments.
     
     - parameter chargeId:        A charges ID to update
     
     - parameter withFraudReport: One of the FraudReport items (safe, or fraudulent). Note that you must refund a charge before 
                                  setting the user_report to fraudulent. Stripe will use the information you send to improve 
                                  our fraud detection algorithms.
     
     - parameter metadata:        An optional dictionary of aditional metadata
     
     - parameter receiptEmail:    This is the email address that the receipt for this charge will be sent to. If this field is 
                                  updated, then a new email receipt will be sent to the updated address. This will be unset 
                                  if you POST an empty value.
     
     - parameter shippingLabl:    Shipping information for the charge. Helps prevent fraud on charges for physical goods.
                                  Create a ShippingLabel() node and pass it here
     
     - parameter transferGroup:   A string that identifies this transaction as part of a group. transfer_group may only 
                                  be provided if it has not been set. See the Connect documentation for details.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func update(charge chargeId: String, withFraudReport fraud: FraudReport?=nil, description: String?=nil, metadata: [String : String]?=nil, receiptEmail: String?=nil, shippingLabel: ShippingLabel?=nil, transferGroup: String?=nil) throws -> StripeRequest<Charge> {
        var body = Node([:])
        if let fraud = fraud {
            body["fraud_details"] = ["user_report": Node(fraud.rawValue)]
        }
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let metadata = metadata {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = try Node(node: value)
            }
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = Node(receiptEmail)
        }
        
        if let shippingLabel = shippingLabel {
            if let name = shippingLabel.name {
                body["shipping[name]"] = Node(name)
            }
            
            if let carrier = shippingLabel.carrier {
                body["shipping[carrier]"] = Node(carrier)
            }
            
            if let phone = shippingLabel.phone {
                body["shipping[phone]"] = Node(phone)
            }
            
            if let trackingNumber = shippingLabel.trackingNumber {
                body["shipping[tracking_number]"] = Node(trackingNumber)
            }
            
            if let address = shippingLabel.address {
                if let line1 = address.addressLine1 {
                    body["shipping[address][line1]"] = Node(line1)
                }
                
                if let city = address.city {
                    body["shipping[address][city]"] = Node(city)
                }
                
                if let country = address.country {
                    body["shipping[address][country]"] = Node(country)
                }
                
                if let postalCode = address.postalCode {
                    body["shipping[address][postal_code]"] = Node(postalCode)
                }
                
                if let state = address.state {
                    body["shipping[address][state]"] = Node(state)
                }
                
                if let line2 = address.addressLine2 {
                    body["shipping[address][line2]"] = Node(line2)
                }
            }
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = Node(transferGroup)
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .charge(chargeId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Retrieve a charge
     Retrieves the details of a charge that has previously been created. Supply the unique charge ID that was 
     returned from your previous request, and Stripe will return the corresponding charge information. The same 
     information is returned when creating or refunding the charge.
     
     - parameter charge: The chargeId is the ID of the charge
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieve(charge chargeId: String) throws -> StripeRequest<Charge> {
        return try StripeRequest(client: self.client, method: .get, route: .charge(chargeId), query: [:], body: nil, headers: nil)
    }
    
    /**
     List all Charges
     Returns a list of charges you’ve previously created. The charges are returned in sorted order, with the most 
     recent charges appearing first.
     
     - parameter filter: A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll(filter: StripeFilter?=nil) throws -> StripeRequest<ChargeList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .charges, query: query, body: nil, headers: nil)
    }
    
    /**
     Capture a charge
     Capture the payment of an existing, uncaptured, charge. This is the second half of the two-step payment flow, 
     where first you created a charge with the capture option set to false. Uncaptured payments expire exactly 
     seven days after they are created. If they are not captured by that point in time, they will be marked as 
     refunded and will no longer be capturable.
     
     - parameter chargeId:            The chargeId is the ID of the charge
     
     - parameter amount:              The amount to capture, which must be less than or equal to the original amount. 
                                      Any additional amount will be automatically refunded.
     
     - parameter applicationFee:      An application fee to add on to this charge. Can only be used with Stripe Connect.
     
     - parameter destinationAmount:   A new destination amount to use. Can only be used with destination charges created 
                                      with Stripe Connect.The portion of this charge to send to the destination account. 
                                      Must be less than or equal to the captured amount of the charge.
     
     - parameter receiptEmail:        The email address to send this charge’s receipt to. This will override the 
                                      previously-specified email address for this charge, if one was set. Receipts 
                                      will not be sent in test mode.
     
     - parameter statementDescriptor: An arbitrary string to be displayed on your customer’s credit card statement. 
                                      This may be up to 22 characters. The statement description may not include <>"' 
                                      characters, and will appear on your customer’s statement in capital letters. 
                                      Non-ASCII characters are automatically stripped. Updating this value will overwrite 
                                      the previous statement descriptor of this charge. While most banks display this 
                                      information consistently, some may display it incorrectly or not at all.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func capture(charge chargeId: String, amount: Int?=nil, applicationFee: Int?=nil, destinationAmount: Int?=nil, receiptEmail: String?=nil, statementDescriptor: String?=nil) throws -> StripeRequest<Charge> {
        var body = Node([:])
        
        if let amount = amount {
            body["amount"] = Node(amount)
        }
        
        if let applicationFee = applicationFee {
            body["application_fee"] = Node(applicationFee)
        }
        
        if let destination = destinationAmount {
            body["destination[amount]"] = Node(destination)
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = Node(receiptEmail)
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = Node(statementDescriptor)
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .captureCharge(chargeId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }

}
