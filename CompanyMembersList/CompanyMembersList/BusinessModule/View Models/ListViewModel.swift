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
    private(set) var companies: [Company] = [Company]() {
        didSet {
            self.updateCompanyData?()
        }
    }
    private(set) var sortOption = ["name", "age"]

    // Closure
    var updateCompanyData: (() -> Void)?

    // MARK: - Public
    func getCompList() {

        let url = Bundle.main.url(forResource: "compList", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode([Company].self, from: data)
            self.companies = response
        } catch { }
    }
}
