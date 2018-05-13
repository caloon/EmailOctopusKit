//
//  ViewController.swift
//  EmailOctopusKit
//
//  Created by caloon on 04/13/2018.
//  Copyright (c) 2018 caloon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // When first launching your app, set the API Key
        EmailOctopus.setApiKey("your-api-key")
        
        
        // Managing Campaigns
        // EmailOctopus.Campaigns.getAllCampaigns() { (error, result) in }
        // EmailOctopus.Campaigns.getCampaign("campaign-id") { (error, result) in }
        
        
        // Managing Lists
        // EmailOctopus.Lists.getSubscribedContacts(of: "list-id") { (error, result) in }
        // EmailOctopus.Lists.getUnsubscribedContacts(of: "list-id") { (error, result) in }
        
        // EmailOctopus.Lists.getContact("contact-id", in: "list-id") { (error, result) in }
        // EmailOctopus.Lists.createContact("email-address", in: "list-id", fields: [:]) { (error, result) in }
        // EmailOctopus.Lists.updateContact("contact-id", of: "list-id", newEmail: nil, newFields: nil, subscribed: true) { (error, result) in }
        // EmailOctopus.Lists.deleteContact("contact-id", of:"list-id") { (error, result) in }
        
        // EmailOctopus.Lists.getAllLists { (error, result) in }
        // EmailOctopus.Lists.getList("list-id") { (error, result) in }
        // EmailOctopus.Lists.createList(name: "list-name") { (error, result) in }
        // EmailOctopus.Lists.deleteList("list-id") { (error, result) in }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}

