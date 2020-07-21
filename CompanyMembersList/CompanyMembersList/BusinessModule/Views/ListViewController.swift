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
    let sortPickerView = PickerView()

    // MARK: - View life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizableStrings.listScreenTitle
        UIHelper.setNavigationItem(viewController: self,
                                   position: .right,
                                   image: nil,
                                   title: "Sort",
                                   action: #selector(rightButtonTapped))

        listTableView.register(CompanyInfoCell.self)
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.estimatedRowHeight = UITableView.automaticDimension
        configureDataSource()
        configurePickerView()
        bindViewModel()
        viewModel.getCompList()
    }

    // MARK: - Actions
    @IBAction func handleSegmentChanged(_ sender: UISegmentedControl) {
        updateListData()
    }

    @objc func rightButtonTapped() {
        sortPickerView.showPicker()
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
    private func configurePickerView() {
        sortPickerView.addPickerView(controller: self, pickerArray: viewModel.sortOption) { (index, str) in
            print(index)
            print(str)
        }
    }
}
