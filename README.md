# EmailOctopusKit

[![CI Status](http://img.shields.io/travis/caloon/EmailOctopusKit.svg?style=flat)](https://travis-ci.org/caloon/EmailOctopusKit)
[![Version](https://img.shields.io/cocoapods/v/EmailOctopusKit.svg?style=flat)](http://cocoapods.org/pods/EmailOctopusKit)
[![License](https://img.shields.io/cocoapods/l/EmailOctopusKit.svg?style=flat)](http://cocoapods.org/pods/EmailOctopusKit)
[![Platform](https://img.shields.io/cocoapods/p/EmailOctopusKit.svg?style=flat)](http://cocoapods.org/pods/EmailOctopusKit)

EmailOctopus is an affordable email campaign and marketing automation platform. EmailOctopusKit makes use of the EmailOctopus API and lets you manage contacts and email lists on EmailOctopus. 

One possible use case of this pod might be signing up mobile app users to your email lists and sending them automated emails (e.g. Welcome Email).

New to EmailOctopus? [Use this link to signup and get 15$ credit.](https://emailoctopus.com/?urli=zzJ7l)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

To use the EmailOctopus to send email campaigns, you need to create an account at [EmailOctopus.com](https://emailoctopus.com/?urli=zzJ7l) and [Amazon SES](https://aws.amazon.com/ses/).
EmailOctopus has a detailed [API documentation](https://emailoctopus.com/api-documentation/) and [FAQs](https://support.emailoctopus.com/hc/en-us) that can help you navigating the process.

## Installation

EmailOctopusKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'EmailOctopusKit'
```

## Usage

The primary use case of the EmailOctopus API for usage in iOS is managing contacts and email lists. EmailOctopusKit lets you create, edit and delete contacts and manage lists. It also has (limited) support for campaign management.

### API Key

Register your EmailOctopus API key:

```
EmailOctopus.setApiKey("your-api-key")
```

This will save your API key to the keychain. You only need to set it once (e.g. in AppDelegate).

### Managing Contacts

```
EmailOctopus.Lists.getContact("contact-id", in: "list-id") { (error, result) in }
EmailOctopus.Lists.getSubscribedContacts(of: "list-id") { (error, result) in }
EmailOctopus.Lists.getUnsubscribedContacts(of: "list-id") { (error, result) in }

EmailOctopus.Lists.createContact("email-address", in: "list-id", fields: [:]) { (error, result) in }
EmailOctopus.Lists.updateContact("contact-id", of: "list-id", newEmail: nil, newFields: nil, subscribed: true) { (error, result) in }
EmailOctopus.Lists.deleteContact("contact-id", of:"list-id") { (error, result) in }
```

### Managing Email Lists

```
EmailOctopus.Lists.getAllLists { (error, result) in }
EmailOctopus.Lists.getList("list-id") { (error, result) in }

EmailOctopus.Lists.createList(name: "list-name") { (error, result) in }
EmailOctopus.Lists.deleteList("list-id") { (error, result) in }
```

### Campaign Management

```
EmailOctopus.Campaigns.getAllCampaigns() { (error, result) in }
EmailOctopus.Campaigns.getCampaign("campaign-id") { (error, result) in }
```

## Contributors

We welcome contribution to this project by opening issues or pull request.

This Cocoapod was created by Josef Moser. I am an independent iOS Developer, and the co-founder of [Cora Health](https://www.cora.health/) and [Cryptoradar](https://www.cryptoradar.co).

## License

EmailOctopusKit is available under the MIT license. See the LICENSE file for more info.
