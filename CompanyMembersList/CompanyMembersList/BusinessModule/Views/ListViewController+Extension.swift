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

    internal func updateData(_ type: Int) {

        let member = Member(name: Name(first: "Harshal", last: "Wani"),
                            memberId: "123", age: 30, email: "harshal@gmail.com", phone: "123456789")
        let member2 = Member(name: Name(first: "David", last: "John"),
                            memberId: "123", age: 30, email: "harshal@gmail.com", phone: "123456789")

        let comp = Company(name: "Comp 1", companyId: "", website: "", logo: "", about: "", members: [member, member2])
        let comp2 = Company(name: "Comp 2", companyId: "", website: "", logo: "", about: "", members: [member, member2])

        var snapshot = ListSnapshot()
        snapshot.appendSections([.main])

        switch  type {
        case 0:
            snapshot.appendItems([.one(comp)])
            snapshot.appendItems([.one(comp2)])
            dataSource.apply(snapshot, animatingDifferences: true)
        case 1:
            snapshot.appendItems([.two(member)])
            snapshot.appendItems([.two(member2)])
            dataSource.apply(snapshot, animatingDifferences: true)
        default:
            break
        }
    }
}
