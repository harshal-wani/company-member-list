//
//  Member.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 19/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import Foundation

struct Member: Decodable, Hashable {
    let name: Name
    let memberId: String
    let age: Int
    let email: String
    let phone: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case memberId = "_id"
        case age = "age"
        case email = "email"
        case phone = "phone"
    }
}

struct Name: Decodable, Hashable {
    let first, last: String
}
