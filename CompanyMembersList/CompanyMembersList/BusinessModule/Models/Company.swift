//
//  Company.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 19/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import Foundation

struct Company: Decodable, Hashable {
    let name: String
    let companyId: String
    let website: String
    let logo: String
    let about: String
    let members: [Member]

    enum CodingKeys: String, CodingKey {
        case name = "company"
        case companyId = "_id"
        case website = "website"
        case logo = "logo"
        case about = "about"
        case members = "members"
    }
}
