//
//  ListViewController.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 19/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

internal enum Wrapper: Hashable {
    case one(CompanyCellModel)
    case two(MemberCellModel)
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

        configureTableView()
        configureDataSource()
        configurePickerView()
        bindViewModel()
        viewModel.getCompanies()
    }

    // MARK: - Actions
    @IBAction func handleSegmentChanged(_ sender: UISegmentedControl) {
        sortPickerView.hidePicker()
        updateListData()
    }

    @objc func rightButtonTapped() {
        updateSortOption()
        sortPickerView.showPicker()
    }

    // MARK: - Private
    private func bindViewModel() {

        /// Naive binding
        viewModel.filteredClubdata.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.updateListData()
            }
        }
    }
    private func configurePickerView() {

        sortPickerView.addPickerView(controller: self,
                                     pickerArray: viewModel.sortOption.company) { [weak self] (_, str) in
                                        self?.viewModel.sortCludData(
                                        (self?.compMemSegmentControl.selectedSegmentIndex == 0)
                                                ? .company
                                                : .member, sortBy: str)
        }
    }

    private func configureTableView() {
        listTableView.register(CompanyInfoCell.self)
        listTableView.register(MemberInfoCell.self)
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.estimatedRowHeight = UITableView.automaticDimension
        listTableView.keyboardDismissMode = .onDrag
    }

    private func updateSortOption() {
        sortPickerView.pickerDataSource = (compMemSegmentControl.selectedSegmentIndex == 0)
            ? viewModel.sortOption.company
            : viewModel.sortOption.member
    }
}
