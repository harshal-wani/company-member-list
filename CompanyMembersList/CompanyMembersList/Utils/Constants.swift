//
//  Constants.swift
//  WordGame
//
//  Created by Harshal Wani on 26/06/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import Foundation

/// API Constants
struct BaseUrl {
    static let scheme = "https"
    static let host = "next.json-generator.com"
}

/// HTTPMethod type
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct LocalizableStrings {

    /// Screen title
    static let listScreenTitle = "List"

    /// Common
    static let alert = "Alert"
    static let error = "Error"
    static let ok = "Ok"
    static let cancel = "Cancel"
    static let yes = "Yes"

}
