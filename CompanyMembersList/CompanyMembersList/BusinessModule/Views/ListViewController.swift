//
//  ListViewController.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 19/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

private enum Section: CaseIterable {
    case main
}
private typealias ListDataSource = UITableViewDiffableDataSource<Section, Company>
private typealias ListSnapshot = NSDiffableDataSourceSnapshot<Section, Company>

final class ListViewController: UIViewController, Storyboarded {

    /// Outlet
    @IBOutlet fileprivate weak var listTableView: UITableView!

    /// Local
    private var dataSource: ListDataSource!

    // MARK: - View life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizableStrings.listScreenTitle
        configureDataSource()
        let comp1 = Company(name: "Abc", companyId: "", website: "", logo: "", about: "", members: nil)
        let comp2 = Company(name: "Xyz", companyId: "", website: "", logo: "", about: "", members: nil)
        createSnapshot([comp1, comp2])
    }
}

// MARK: - UITableViewDelegate Delegates
extension ListViewController: UITableViewDelegate {

    // MARK: - Private
    private func configureDataSource() {

        dataSource = ListDataSource(tableView: listTableView,
                                    cellProvider: { [weak self] (_, indexPath, company) -> UITableViewCell? in

                                        guard let `self` = self else {
                                            return UITableViewCell()
                                        }
                                        let cell = self.listTableView.dequeueReusableCell(withIdentifier: "Cell",
                                                                                          for: indexPath)
                                        cell.textLabel?.text = company.name
                                        return cell
        })
    }

    private func createSnapshot(_ company: [Company]) {

        var snapshot = ListSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(company)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
