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
    private var clubData: ClubData?
    private(set) var searchedClubData: ClubData?
    private(set) var sortOption = SortOption()

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

    func updateClubDataActionItem(_ wrapper: Wrapper, type: ActionType) {

        switch wrapper {
        case .one(let model):
            switch type {
            case .favorite:
                model.isFavorite = !model.isFavorite
            case .follow:
                model.isfollow = !model.isfollow
            }
        case .two(let model):
            model.isFavorite = !model.isFavorite
        }
    }

    func getSearchResult(_ str: String) {

        searchedClubData?.companies =  (str.trimmingCharacters(in: .whitespacesAndNewlines) != "")
            ? clubData!.companies.filter {$0.name.lowercased().contains(str.lowercased()) }
            : clubData!.companies

        searchedClubData?.members =  (str.trimmingCharacters(in: .whitespacesAndNewlines) != "")
        ? clubData!.members.filter {$0.name.lowercased().contains(str.lowercased()) }
        : clubData!.members

        self.updateCompanyData?()
    }

    func sortCludData() {

        searchedClubData?.companies.sort {$0.name < $1.name}
        self.updateCompanyData?()
    }

    // MARK: - Private
    private func processFetchedData(_ models: [Company]) {

        let companies = models.map { CompanyCellModel(company: $0) }

        let members = models.compactMap { $0.members}.joined()
            .map { MemberCellModel(member: $0) }

        clubData = ClubData(companies: companies, members: members)
        searchedClubData = clubData?.copy() as? ClubData
        self.updateCompanyData?()
    }
}

// MARK: - SortOption
struct SortOption {
    let company = ["name"]
    let member = ["name", "age"]
}
