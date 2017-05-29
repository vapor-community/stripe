//
//  StripeDuration.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

public enum StripeDuration: String
{
    case forever = "forever"
    case once = "once"
    case repeating = "repeating"
    case never = "never"
    
    var description: String {
        return self.rawValue.uppercased()
    }
}
