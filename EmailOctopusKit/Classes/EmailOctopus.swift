//
//  EmailOctopus.swift
//  EmailOctopusKit_Example
//
//  Created by Work on 13.04.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation


public typealias EmailOctopusClosure = (_ error: Error?, _ result: Dictionary<String, Any>?) -> Void

public enum MailServiceError: Error {
    case missingAPIKey, missingProvider, listRequired, unimplemented
}

public class MailContact {
    var email: String
    var fullname: String
    
    public init(email: String, fullname: String) {
        self.email = email
        self.fullname = fullname
    }
}

public struct EmailOctopus {
    
    
    // ------------- -------------  Instance Variables -------------  -------------
    
    fileprivate static let api = "https://emailoctopus.com/api/1.3/"
    
    fileprivate static var apiKey: String? {
        if let key = Keychain.load(service: "apiKey") {
            return key
        } else {
            return nil
        }
    }
    
    
    
    // ------------- -------------  Instance Methods -------------  -------------
    
    static public func setApiKey(_ key: String) {
        Keychain.save(service: "apiKey", data: key)
    }
    
    static fileprivate func send(request: URLRequest, params: Dictionary<String, Any>,  completion: @escaping EmailOctopusClosure) {
        
        //update request
        var urlRequest = request
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // parse JSON
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        } catch let error {
            completion(error, nil)
        }
        
        // URLSession > send request to server
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) -> Void in
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                
                completion(error, jsonData)
            } catch let e {
                completion(e, nil)
            }
            }.resume()
    }
    
    
    
    
    // ------------- -------------  Campaign Management -------------  -------------
    
    public struct Campaigns {
        
        static public func getCampaign(_ id: String, completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "campaigns/" + id )!)
                request.httpMethod = "GET"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        static public func getAllCampaigns(completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "campaigns")!)
                request.httpMethod = "GET"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        // TODO: campaign reports unimplemented
    }
    
    
    
    
    
    // ------------- -------------  List Management -------------  -------------
    
    public struct Lists {
        
        static public func getContact(_ contact: String, in list: String, completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "lists/" + list + "/contacts/" + contact )!)
                request.httpMethod = "GET"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        static public func getSubscribedContacts(of list: String, completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "lists/" + list + "/contacts/subscribed")!)
                request.httpMethod = "GET"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        static public func getUnsubscribedContacts(of list: String, completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "lists/" + list + "/contacts/unsubscribed")!)
                request.httpMethod = "GET"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        static public func createContact(_ email: String, in list: String, fields: Dictionary<String, String>, subscribed: Bool = true, completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "lists/" + list + "/contacts")!)
                request.httpMethod = "POST"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                params["email_address"] = email
                params["fields"] = fields
                if subscribed {
                    params["subscribed"] = 1
                } else {
                    params["subscribed"] = 0
                }
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        static public func updateContact(_ contact: String, of list: String, newEmail: String?, newFields: Dictionary<String, String>?, subscribed: Bool = true , completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "lists/" + list + "/contacts/" + contact)!)
                request.httpMethod = "PUT"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                
                if let email = newEmail {
                    params["email_address"] = email
                }
                if let fields = newFields {
                    params["fields"] = fields
                }
                
                if subscribed {
                    params["subscribed"] = 1
                } else {
                    params["subscribed"] = 0
                }
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        static public func deleteContact(_ contact: String, of list: String, completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "lists/" + list + "/contacts/" + contact)!)
                request.httpMethod = "DELETE"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        
        static public func getList(_ list: String, completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "lists/" + list)!)
                request.httpMethod = "GET"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        static public func getAllLists(completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "lists")!)
                request.httpMethod = "GET"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        static public func createList(name: String, completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "lists")!)
                request.httpMethod = "POST"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                params["name"] = name
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
        
        static public func deleteList(_ list: String, completion: @escaping EmailOctopusClosure) {
            if EmailOctopus.apiKey == nil { completion(MailServiceError.missingAPIKey, nil) }
                
            else {
                // create request
                var request = URLRequest(url: URL(string: EmailOctopus.api + "lists/" + list)!)
                request.httpMethod = "DELETE"
                
                // set params
                var params = [String: Any]()
                params["api_key"] = EmailOctopus.apiKey
                
                // execute network call
                EmailOctopus.send(request: request, params: params) { (error, result) in
                    completion(error, result)
                }
            }
        }
    }
    
}
