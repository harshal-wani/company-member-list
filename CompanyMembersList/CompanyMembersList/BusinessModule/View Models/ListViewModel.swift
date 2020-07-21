//
//  ListViewModel.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 20/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

final class ListViewModel: NSObject {

    /// Local
    private(set) var clubData: ClubData?
    private(set) var sortOption = ["name", "age"]

    // Closure
    var updateCompanyData: (() -> Void)?

    // MARK: - Public
    func getCompList() {

        let url = Bundle.main.url(forResource: "compList", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode([Company].self, from: data)
            self.processFetchedData(response)
        } catch { }
    }

    // MARK: - Private
    private func processFetchedData(_ models: [Company]) {

        let companies = models.map { CompanyCellModel(company: $0) }

        let members = models.compactMap { $0.members}.joined()
            .map { MemberCellModel(member: $0) }

        clubData = ClubData(companies: companies, members: members)
        self.updateCompanyData?()

    }
}

// MARK: - ClubData
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
