//
//  ChargeRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Node
import HTTP

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

open class ChargeRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create a Charge
     To charge a credit card, you create a charge object. If your API key is in test mode, the supplied payment source
     (e.g., card or Bitcoin receiver) won't actually be charged, though everything else will occur as if in live mode.
     (Stripe assumes that the charge would have completed successfully).
     
     NOTE: Accounts and Fees are only applicable to connected accounts
     
     - parameter amount:                The payment amount in cents.
     
     - parameter currency:              The currency in which the charge will be under.

     - parameter account:               The account id which the payment would be sent to.
     
     - parameter capture:               Whether or not to immediately capture the charge.
     
     - parameter description:           An optional description for charges.
     
     - parameter destinationAccountId:  If specified, the charge will be attributed to the destination account for tax reporting,
                                        and the funds from the charge will be transferred to the destination account.
     
     - parameter destinationAmount:     The amount to transfer to the destination account in cents. Calculate this value by subtracting
                                        your platform’s fees from the total charge amount. Note that destination amount is capped
                                        at the total charge amount.
     
     - parameter transferGroup:         A string that identifies this transaction as part of a group.
     
     - parameter onBehalfOf:            The Stripe account ID that these funds are intended for.
     
     - parameter receiptEmail:          The email address to send this charge's receipt to.
     
     - parameter shippingLabel:         Shipping information for the charge.
     
     - parameter customer:              The ID of an existing customer that will be charged in this request.
     
     - parameter source:                A payment source to be charged, such as a credit card.
     
     - parameter statementDescriptor:   An arbitrary string to be displayed on your customer's credit card statement.
     
     - parameter metadata:              Set of key/value pairs that you can attach to an object.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func create(amount: Int, in currency: StripeCurrency, toAccount account: String? = nil, capture: Bool? = nil, description: String? = nil, destinationAccountId: String? = nil, destinationAmount: Int? = nil, transferGroup: String? = nil, onBehalfOf: String? = nil,  receiptEmail: String? = nil, shippingLabel: ShippingLabel? = nil, customer: String? = nil, statementDescriptor: String? = nil, source: String? = nil, metadata: Node? = nil) throws -> StripeRequest<Charge> {
        // Setup our params
        var body: [String : Any] = [
            "amount": amount,
            "currency": currency.rawValue,
        ]
        
        // Create the headers
        var headers: [HeaderKey : String]?
        if let account = account {
            headers = [
                StripeHeader.Account: account
            ]
        }
        
        if let capture = capture {
            body["capture"] = capture
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let destinationAccountId = destinationAccountId, let destinationAmount = destinationAmount {
            body["destination[account]"] = destinationAccountId
            body["destination[amount]"] = destinationAmount
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let onBehalfOf = onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
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
        
        if let source = source {
            body["source"] = source
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = Node(statementDescriptor)
        }
        
        // Create the body node
        let node = try Node(node: body)
        
        return try StripeRequest(client: self.client, method: .post, route: .charges, query: [:], body: Body.data(node.formURLEncoded()), headers: headers)
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
     Update a charge
     Updates the specified charge by setting the values of the parameters passed. Any parameters not provided will 
     be left unchanged. This request accepts only the `description`, `metadata`, `receipt_email`, `fraud_details`, 
     and `shipping` as arguments.
     
     - parameter description:   An arbitrary string which you can attach to a charge object.
     
     - parameter fraud:         A set of key/value pairs you can attach to a charge giving information about its riskiness.
     
     - parameter receiptEmail:  This is the email address that the receipt for this charge will be sent to.
     
     - parameter shippingLabel: Shipping information for the charge. Helps prevent fraud on charges for physical goods.
     
     - parameter transferGroup: A string that identifies this transaction as part of a group.
     
     - parameter metadata:      Set of key/value pairs that you can attach to an object.
     
     - parameter chargeId:      A charges ID to update
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func update(charge chargeId: String, description: String? = nil, fraud: FraudDetails? = nil, receiptEmail: String? = nil, shippingLabel: ShippingLabel? = nil, transferGroup: String? = nil, metadata: Node? = nil) throws -> StripeRequest<Charge> {
        var body = Node([:])
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let fraud = fraud {
            if let userReport = fraud.userReport?.rawValue {
                body["fraud_details[user_report]"] = Node(userReport)
            }
            
            if let stripeReport = fraud.stripeReport?.rawValue {
                body["fraud_details[stripe_report]"] = Node(stripeReport)
            }
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
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
     Capture a charge
     Capture the payment of an existing, uncaptured, charge. This is the second half of the two-step payment flow,
     where first you created a charge with the capture option set to false. Uncaptured payments expire exactly
     seven days after they are created. If they are not captured by that point in time, they will be marked as
     refunded and will no longer be capturable.
     
     - parameter chargeId:              The chargeId is the ID of the charge
     
     - parameter amount:                The amount to capture, which must be less than or equal to the original amount.
                                        Any additional amount will be automatically refunded.
     
     - parameter applicationFee:        An application fee to add on to this charge. Can only be used with Stripe Connect.
     
     - parameter destinationAmount:     A new destination amount to use. Can only be used with destination charges created
                                        with Stripe Connect.The portion of this charge to send to the destination account.
                                        Must be less than or equal to the captured amount of the charge.
     
     - parameter receiptEmail:          The email address to send this charge’s receipt to. This will override the
                                        previously-specified email address for this charge, if one was set. Receipts
                                        will not be sent in test mode.
     
     - parameter statementDescriptor:   An arbitrary string to be displayed on your customer’s credit card statement.
                                        This may be up to 22 characters.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func capture(charge chargeId: String, amount: Int? = nil, applicationFee: Int? = nil, destinationAmount: Int? = nil, receiptEmail: String? = nil, statementDescriptor: String? = nil) throws -> StripeRequest<Charge> {
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
    
    /**
     List all Charges
     Returns a list of charges you’ve previously created. The charges are returned in sorted order, with the most
     recent charges appearing first.
     
     - parameter filter: A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<ChargeList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .charges, query: query, body: nil, headers: nil)
    }
    
    
}
