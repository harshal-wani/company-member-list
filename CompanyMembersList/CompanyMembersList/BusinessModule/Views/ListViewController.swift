//
//  ListViewController.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 19/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

internal enum Wrapper: Hashable {
    case one(Company)
    case two(Member)
}

internal enum Section: CaseIterable {
    case main
}

internal typealias ListDataSource = UITableViewDiffableDataSource<Section, Wrapper>
internal typealias ListSnapshot = NSDiffableDataSourceSnapshot<Section, Wrapper>

final class ListViewController: UIViewController, Storyboarded {

    /// Outlet
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var compMemSegmentControl: UISegmentedControl!

    /// Local
    internal var dataSource: ListDataSource!
    internal var viewModel = ListViewModel()

    // MARK: - View life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizableStrings.listScreenTitle
        configureDataSource()
        bindViewModel()
        viewModel.getCompList()
    }

    // MARK: - Actions
    @IBAction func handleSegmentChanged(_ sender: UISegmentedControl) {
        updateListData()
  }

    // MARK: - Private
    private func bindViewModel() {

        /// Naive binding
        viewModel.updateCompanyData = { [weak self] () in
            DispatchQueue.main.async {
                self?.updateListData()
            }
        }
    }
}
