//
//  StripeModel.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

import Vapor
import Foundation

public protocol StripeModel: Content {
    func toEncodedBody() throws -> String
    func toEncodedDictionary() throws -> [String: Any]
}

extension StripeModel {
    public func toEncodedBody() throws -> String {
        return try self.toEncodedDictionary().queryParameters
    }
    
    public func toEncodedDictionary() throws -> [String: Any] {
        let encoded = try JSONEncoder().encode(self)
        
        let jsonString = String(data: encoded, encoding: .utf8) ?? ""
        
        let final = try JSONDecoder().decode(AnyDecodable.self, from: jsonString.data(using: .utf8) ??  Data()).value as? [String: Any] ?? [:]
        
        return final
    }
}

public struct AnyDecodable: Decodable {
    public var value: Any
    
    private struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
        init?(stringValue: String) { self.stringValue = stringValue }
    }
    
    public init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            var result = [String: Any]()
            try container.allKeys.forEach { (key) throws in
                result[key.stringValue] = try container.decode(AnyDecodable.self, forKey: key).value
            }
            value = result
        } else if var container = try? decoder.unkeyedContainer() {
            var result = [Any]()
            while !container.isAtEnd {
                result.append(try container.decode(AnyDecodable.self).value)
            }
            value = result
        } else if let container = try? decoder.singleValueContainer() {
            if let intVal = try? container.decode(Int.self) {
                value = intVal
            } else if let doubleVal = try? container.decode(Double.self) {
                value = doubleVal
            } else if let boolVal = try? container.decode(Bool.self) {
                value = boolVal
            } else if let stringVal = try? container.decode(String.self) {
                value = stringVal
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "the container contains nothing serialisable")
            }
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not serialise"))
        }
    }
}

extension Dictionary where Key == String {
    var queryParameters: String {
        // A quick implementation of URLEncodedFormSerializer that includes indices in array key-paths
        // -> `items[0][plan]=...` instead of `items[][plan]=...`
        return Dictionary.queryComponents(keyPath: [], self).map { keyPath, value in
            "\(keyPath.queryKeyPercentEncoded)=\(value.queryValuePercentEncoded)"
        }.joined(separator: "&")
    }
    
    private static func queryComponents(keyPath: [String], _ value: Any) -> [([String], String)] {
        if let dictionary = value as? [String: Any] {
            return dictionary.flatMap { key, value in
                queryComponents(keyPath: keyPath + [key], value)
            }
        } else if let array = value as? [Any] {
            return array.enumerated().flatMap { idx, value in
                queryComponents(keyPath: keyPath + ["\(idx)"], value)
            }
        } else {
            return [(keyPath, "\(value)")]
        }
    }
}

private extension CharacterSet {
    static var queryComponentAllowed: CharacterSet = {
        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.remove("&")
        characterSet.remove("+")
        return characterSet
    }()
}

private extension Sequence where Element == String {
    var queryKeyPercentEncoded: String {
        return enumerated().map { idx, key in
            let encodedKey = key.queryValuePercentEncoded
            return idx == 0 ? encodedKey : "[\(encodedKey)]"
        }.joined()
    }
}

private extension String {
    var queryValuePercentEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .queryComponentAllowed) ?? ""
    }
}
