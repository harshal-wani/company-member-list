//
//  ListViewModel.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 20/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

enum ClubTabs: Int, CaseIterable {
    case company = 0, member = 1

    var description: String {
        switch self {
        case .company: return "Company"
        case .member: return "Member"
        }
    }
}

enum ListViewState {
    case idle
    case loading
    case finished
    case clubDataUpdates
    case error(APIError)
}
protocol ObservableViewModelProtocol {
    func getCompanies()
    var listViewState: Observable<ListViewState> { get set }
}

final class ListViewModel: ObservableViewModelProtocol {

    /// Local
    private var clubData: ClubData?
    private(set)var filteredClubData: ClubData?
    private(set) var sortOption = SortOption()
    private let apiService: APIServiceProtocol

    var listViewState: Observable<ListViewState> = Observable(.idle)

    // MARK: - Initialization
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    // MARK: - Public
    func getCompanies() {

        listViewState.value = .loading

        apiService.fetch(.clubDataList(), [Company].self) { [weak self] (result) in
            self?.listViewState.value = .finished

            switch result {
            case .success(let company):
                guard !company.isEmpty else {
                    self?.listViewState.value = .error(.noData)
                    return
                }
                self?.processFetchedData(company)

            case .failure(let error):
                self?.listViewState.value = .error(error)
            }
        }
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
        let text = str.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        filteredClubData = ClubData(
            companies: (text != "")
                ? clubData!.companies.filter {$0.name.lowercased().contains(text) }
                : clubData!.companies,
            members: (text != "")
                ? clubData!.members.filter {$0.name.lowercased().contains(text) }
                : clubData!.members)

        listViewState.value = .clubDataUpdates
    }

    func sortCludData(_ tab: ClubTabs, sortBy: String) {

        switch tab {
        case .company:
            filteredClubData?.companies.sort {$0.name < $1.name}
        case .member:
            if sortBy == "name" {
                filteredClubData?.members.sort {$0.name < $1.name}
            } else if sortBy == "age" {
                filteredClubData?.members.sort {$0.age < $1.age}
            }
        }
        listViewState.value = .clubDataUpdates
    }

    func loadSegmentWiseData() {
        listViewState.value = .clubDataUpdates
    }

    // MARK: - Private
    private func processFetchedData(_ models: [Company]) {

        let companies = models.map { CompanyCellModel(company: $0) }

        let members = models.compactMap { $0.members}
            .joined()
            .map { MemberCellModel(member: $0) }

        clubData = ClubData(companies: companies, members: members)
        filteredClubData = clubData?.copy() as? ClubData
        listViewState.value = .clubDataUpdates
    }
}

// MARK: - SortOption
struct SortOption {
    let company = ["name"]
    let member = ["name", "age"]
}
