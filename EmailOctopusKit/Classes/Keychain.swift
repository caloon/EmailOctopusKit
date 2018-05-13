//
//  Keychain.swift
//  MailServiceKit
//
//  Created by Work on 24.01.18.
//

import Foundation
import Security


internal let userAccount = "default"
internal let accessGroup = "EmailOctopus"

internal let kSecClassValue = NSString(format: kSecClass)
internal let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
internal let kSecValueDataValue = NSString(format: kSecValueData)
internal let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
internal let kSecAttrServiceValue = NSString(format: kSecAttrService)
internal let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
internal let kSecReturnDataValue = NSString(format: kSecReturnData)
internal let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

public class Keychain: NSObject {
    
    class func save(service: String, data: String) {
        let dataFromString: Data = data.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        // Add the new keychain item
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        
        if (status != errSecSuccess) {    // Always check the status
            print("Write failed: \(status). Attempting update.")
            update(service: service, data: data)
        }
    }
    
    class func load(service: String) -> String? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
    
    private class func update(service: String, data: String) {
        let dataFromString: Data = data.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)! as Data
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, ], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue
            ])
        
        let status = SecItemUpdate(keychainQuery as CFDictionary, [kSecValueDataValue:dataFromString] as CFDictionary)
        
        if (status != errSecSuccess) {
            print("Update failed: \(status)")
        }
    }
    
}

