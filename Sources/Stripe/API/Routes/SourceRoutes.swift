//
//  SourceRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/1/17.
//
//

import Node
import HTTP

public final class SourceRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create a Source
     Creates a new customer object.
     
     - parameter type:              The type of the source to create.
     
     - parameter amount:            Amount associated with the source. This is the amount for which the source 
                                    will be chargeable once ready.
     
     - parameter currency:          This is the currency for which the source will be chargeable once ready.
     
     - parameter flow:              The authentication flow of the source to create.
     
     - parameter owner:             Information about the owner of the payment instrument that may be used or 
                                    required by particular source types.
     
     - parameter redirectReturnUrl: The URL you provide to redirect the customer back to you after they
                                    authenticated their payment.
     
     - parameter token:             An optional token used to create the source. When passed, token properties 
                                    will override source parameters.
     
     - parameter usage:             Either reusable or single_use.
     
     - parameter metadata:          A set of key/value pairs that you can attach to a customer object.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func createNewSource(sourceType: SourceType, source: Node, amount: Int? = nil, currency: StripeCurrency? = nil, flow: String? = nil, owner: Owner? = nil, redirectReturnUrl: String? = nil, token: String? = nil, usage: String? = nil, metadata: Node? = nil) throws -> StripeRequest<Source> {
        
        var body = Node([:])
        
        body["type"] = Node(sourceType.rawValue)
        
        switch sourceType{
            
        case .card:
            if let source = source.object {
                for (key,val) in source {
                    body["card[\(key)]"] = val
                }
            }
        case .bitcoin:
            if let source = source.object {
                for (key,val) in source {
                    body["bitcoin[\(key)]"] = val
                }
            }
        case .threeDSecure:
            if let source = source.object {
                for (key,val) in source {
                    body["three_d_secure[\(key)]"] = val
                }
            }
            
        case .bancontact:
            if let source = source.object {
                for (key,val) in source {
                    body["bancontact[\(key)]"] = val
                }
            }
        case .giropay:
            if let source = source.object {
                for (key,val) in source {
                    body["giropay[\(key)]"] = val
                }
            }
        case .ideal:
            if let source = source.object {
                for (key,val) in source {
                    body["ideal[\(key)]"] = val
                }
            }
        case .sepaDebit:
            if let source = source.object {
                for (key,val) in source {
                    body["sepa_debit[\(key)]"] = val
                }
            }
        case .sofort:
            if let source = source.object {
                for (key,val) in source {
                    body["sofort[\(key)]"] = val
                }
            }
        default:
            body[""] = ""
        }
        
        if let amount = amount {
            
            body["amount"] = Node(amount)
        }
        
        if let currency = currency {
            body["currency"] = Node(currency.rawValue)
        }
        
        if let flow = flow {
            body["flow"] = Node(flow)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        if let owner = owner {
         
            if let email = owner.email {
                body["owner[email]"] = Node(email)
            }
            
            if let name = owner.name {
                body["owner[name]"] = Node(name)
            }
            
            if let phone = owner.phone {
                body["owner[phone]"] = Node(phone)
            }
            
            if let address = owner.address {
                
                if let line1 = address.addressLine1 {
                    body["owner[address][line1]"] = Node(line1)
                }
                
                if let city = address.city {
                    body["owner[address][city]"] = Node(city)
                }
                
                if let country = address.country {
                    body["owner[address][country]"] = Node(country)
                }
                
                if let postalCode = address.postalCode {
                    body["owner[address][postal_code]"] = Node(postalCode)
                }
                
                if let state = address.state {
                    body["owner[address][state]"] = Node(state)
                }
                
                if let line2 = address.addressLine2 {
                    body["owner[address][line2]"] = Node(line2)
                }
            }
        }
        
        if let redirectReturnUrl = redirectReturnUrl {
            body["redirect[return_url]"] = Node(redirectReturnUrl)
        }
        
        if let token = token {
            body["token"] = Node(token)
        }
        
        if let usage = usage {
            body["usage"] = Node(usage)
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .sources, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Retrieve a source
     Retrieves an existing source object. Supply the unique source ID from a source creation request and Stripe will return the corresponding up-to-date source object information.
     
     - parameter sourceId: The identifier of the source to be retrieved.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieveSource(withId sourceId: String) throws -> StripeRequest<Source> {
        return try StripeRequest(client: self.client, method: .get, route: .source(sourceId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Update a Source
     Updates the specified source by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
     
     - parameter metadata:  A set of key/value pairs that you can attach to a source object.
     
     - parameter owner:     Information about the owner of the payment instrument that may be used or required by particular 
                            source types.
     
     - parameter sourceId:  The identifier of the source to be updated.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node.
     */
    
    public func update(owner: Owner? = nil, metadata: Node? = nil, forSourceId sourceId: String) throws -> StripeRequest<Source> {
        var body = Node([:])
        
        if let owner = owner {
            
            if let email = owner.email {
                body["owner[email]"] = Node(email)
            }
            
            if let name = owner.name {
                body["owner[name]"] = Node(name)
            }
            
            if let phone = owner.phone {
                body["owner[phone]"] = Node(phone)
            }
            
            if let address = owner.address {
                
                if let line1 = address.addressLine1 {
                    body["owner[address][line1]"] = Node(line1)
                }
                
                if let city = address.city {
                    body["owner[address][city]"] = Node(city)
                }
                
                if let country = address.country {
                    body["owner[address][country]"] = Node(country)
                }
                
                if let postalCode = address.postalCode {
                    body["owner[address][postal_code]"] = Node(postalCode)
                }
                
                if let state = address.state {
                    body["owner[address][state]"] = Node(state)
                }
                
                if let line2 = address.addressLine2 {
                    body["owner[address][line2]"] = Node(line2)
                }
            }
        }

        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        return try StripeRequest(client: self.client, method: .post, route: .source(sourceId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
}
