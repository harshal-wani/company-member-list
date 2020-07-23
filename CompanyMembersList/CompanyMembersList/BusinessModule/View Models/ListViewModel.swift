//
//  ListViewModel.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 20/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

enum ClubTabs {
    case company
    case member
}

protocol ObservableViewModelProtocol {
    func getCompanies()
    var filteredClubdata: Observable<ClubData?> { get  set }
}

final class ListViewModel: ObservableViewModelProtocol {

    /// Local
    private var clubData: ClubData?
    var filteredClubdata: Observable<ClubData?> = Observable(nil)
    private(set) var sortOption = SortOption()

    // Closure
    var updateCompanyData: (() -> Void)?

    // MARK: - Public
    func getCompanies() {

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

        filteredClubdata.value = ClubData(
            companies: (str.trimmingCharacters(in: .whitespacesAndNewlines) != "")
                ? clubData!.companies.filter {$0.name.lowercased().contains(str.lowercased()) }
                : clubData!.companies,
            members: (str.trimmingCharacters(in: .whitespacesAndNewlines) != "")
                ? clubData!.members.filter {$0.name.lowercased().contains(str.lowercased()) }
                : clubData!.members)
    }

    func sortCludData(_ tab: ClubTabs, sortBy: String) {

        switch tab {
        case .company:
            filteredClubdata.value?.companies.sort {$0.name < $1.name}

        case .member:
            if sortBy == "name" {
                filteredClubdata.value?.members.sort {$0.name < $1.name}
            } else if sortBy == "age" {
                filteredClubdata.value?.members.sort {$0.age < $1.age}
            }
        }
        filteredClubdata.value = ClubData(
                       companies: filteredClubdata.value!.companies,
                       members: filteredClubdata.value!.members)
    }

    // MARK: - Private
    private func processFetchedData(_ models: [Company]) {

        let companies = models.map { CompanyCellModel(company: $0) }

        let members = models.compactMap { $0.members}
            .joined()
            .map { MemberCellModel(member: $0) }

        clubData = ClubData(companies: companies, members: members)
        filteredClubdata.value = self.clubData?.copy() as? ClubData
    }
}

// MARK: - SortOption
struct SortOption {
    let company = ["name"]
    let member = ["name", "age"]
}
