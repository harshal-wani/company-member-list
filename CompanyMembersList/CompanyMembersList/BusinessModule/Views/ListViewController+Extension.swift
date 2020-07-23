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
}

// MARK: - UITableView Datasource
extension ListViewController {

    internal func configureDataSource() {

        dataSource = ListDataSource(tableView: listTableView,
                                    cellProvider: { [weak self] (_, indexPath, wrapper) -> UITableViewCell? in

                                        switch wrapper {

                                        case .one(let company):
                                            if let cell: CompanyInfoCell = self?.listTableView.dequeueReusableCell(for: indexPath) {
                                                cell.companyCellModel = company

                                                cell.userFavFollowAction = { [unowned self] type in
                                                    self?.viewModel.updateClubDataActionItem(wrapper, type: type)
                                                    cell.setActionButtonImage(type)
                                                }
                                                return cell
                                            }

                                        case .two(let member):

                                            if let cell: MemberInfoCell = self?.listTableView.dequeueReusableCell(for: indexPath) {
                                                cell.memberCellModel = member
                                                cell.userFavAction = { [unowned self] type in
                                                    self?.viewModel.updateClubDataActionItem(wrapper, type: .favorite)
                                                    cell.setActionButtonImage(.favorite)
                                                }
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
            viewModel.filteredClubdata.value?.companies
                .forEach { snapshot.appendItems([.one($0)]) }

            dataSource.apply(snapshot, animatingDifferences: true)

        case 1:
            viewModel.filteredClubdata.value?.members
                .forEach { snapshot.appendItems([.two($0)]) }

            dataSource.apply(snapshot, animatingDifferences: true)
        default:
            break
        }
    }
}

// MARK: - UISearchBarDelegate Delegates
extension ListViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        sortPickerView.hidePicker()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncDeduped(target: self, after: 0.25) { [weak self] in
            self?.viewModel.getSearchResult(searchText)
        }
    }
}
