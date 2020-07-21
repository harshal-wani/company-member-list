//
//  ClubDataModel.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 21/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

class ClubData: HashableClass {
    var companies: [CompanyCellModel] = []
    var members: [MemberCellModel] = []

    init(companies: [CompanyCellModel], members: [MemberCellModel]) {
        self.companies = companies
        self.members = members
    }
}

// MARK: - CompanyCellModel
class CompanyCellModel: HashableClass {
    let name: String
    let logo: String
    let about: String
    let website: String
    var isFavorite: Bool = false

    init(company: Company) {
        self.name = company.name
        self.logo = company.logo
        self.about = company.about
        self.website = company.website
    }
}

// MARK: - MemberCellModel
class MemberCellModel: HashableClass {
    let name: String
    let age: Int
    let phone: String
    let email: String

    init(member: Member) {
        self.name = member.name.first + " " + member.name.last
        self.age = member.age
        self.phone = member.phone
        self.email = member.email
    }
}
