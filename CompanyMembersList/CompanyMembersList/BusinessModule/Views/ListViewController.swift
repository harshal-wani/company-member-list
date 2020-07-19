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

    /// Local
    internal var dataSource: ListDataSource!

    // MARK: - View life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizableStrings.listScreenTitle
        configureDataSource()
        updateData(0)
    }

    // MARK: - Actions
    @IBAction func handleSegmentChanged(_ sender: UISegmentedControl) {
        updateData(sender.selectedSegmentIndex)
  }
}
