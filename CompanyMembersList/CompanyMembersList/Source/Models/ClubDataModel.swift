//
//  ClubDataModel.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 21/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import Foundation

class ClubData: HashableClass, NSCopying {
    var companies: [CompanyCellModel] = []
    var members: [MemberCellModel] = []

    init(companies: [CompanyCellModel], members: [MemberCellModel]) {
        self.companies = companies
        self.members = members
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return ClubData(companies: self.companies, members: self.members)
    }
}

// MARK: - CompanyCellModel
class CompanyCellModel: HashableClass {
    let name: String
    var logo: String
    let about: String
    let website: String
    var isFavorite: Bool = false
    var isfollow: Bool = false

    init(company: Company) {
        self.name = company.name
        self.logo = company.logo
        self.about = company.about
        self.website = company.website
        self.logo = company.logo
    }
}

// MARK: - MemberCellModel
class MemberCellModel: HashableClass {
    let name: String
    let age: Int
    let phone: String
    let email: String
    var isFavorite: Bool = false

    init(member: Member) {
        self.name = member.name.first + " " + member.name.last
        self.age = member.age
        self.phone = member.phone
        self.email = member.email
    }
}
