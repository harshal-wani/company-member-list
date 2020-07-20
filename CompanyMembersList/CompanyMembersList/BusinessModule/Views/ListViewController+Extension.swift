//
//  ListViewController+Extension.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 19/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate Delegates
extension ListViewController: UITableViewDelegate {

    // MARK: - Private
    internal func configureDataSource() {

        dataSource = ListDataSource(tableView: listTableView,
                                    cellProvider: { [weak self] (_, indexPath, wrapper) -> UITableViewCell? in

                                        switch wrapper {

                                        case .one(let company):
                                            let cell = self?.listTableView.dequeueReusableCell(withIdentifier: "Cell",
                                                                                               for: indexPath)
                                            cell?.textLabel?.text = company.name
                                            return cell
                                        case .two(let member):

                                            let cell = self?.listTableView.dequeueReusableCell(withIdentifier: "Cell",
                                                                                               for: indexPath)
                                            cell?.textLabel?.text = member.name.first
                                            return cell
                                        }
        })

    }

    internal func updateListData() {

        let tab = compMemSegmentControl.selectedSegmentIndex
        var snapshot = ListSnapshot()
        snapshot.appendSections([.main])

        switch  tab {
        case 0:
            viewModel.companies
                .forEach { snapshot.appendItems([.one($0)]) }

            dataSource.apply(snapshot, animatingDifferences: true)

        case 1:
            viewModel.companies
                .compactMap {$0.members}
                .joined()
                .forEach { snapshot.appendItems([.two($0)]) }

            dataSource.apply(snapshot, animatingDifferences: true)
        default:
            break
        }
    }
}
