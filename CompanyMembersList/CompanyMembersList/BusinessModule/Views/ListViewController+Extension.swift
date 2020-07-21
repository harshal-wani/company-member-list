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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    // MARK: - Private

    internal func configureDataSource() {

        dataSource = ListDataSource(tableView: listTableView,
                                    cellProvider: { [weak self] (_, indexPath, wrapper) -> UITableViewCell? in

                                        switch wrapper {

                                        case .one(let company):
                                            if let cell: CompanyInfoCell = self?.listTableView.dequeueReusableCell(for: indexPath) {
                                                    return cell
                                                }

                                        case .two(let member):

                                            if let cell: MemberInfoCell = self?.listTableView.dequeueReusableCell(for: indexPath) {
                                                return cell
                                            }
                                        }
                                        return UITableViewCell()
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

// MARK: - UISearchBarDelegate Delegates
extension ListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncDeduped(target: self, after: 0.25) { [weak self] in
            print("Text= \(searchText)")
        }
    }
}
