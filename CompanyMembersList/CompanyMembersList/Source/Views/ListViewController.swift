//
//  ListViewController.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 19/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

enum Wrapper: Hashable {
    case one(CompanyCellModel)
    case two(MemberCellModel)
}

enum Section: CaseIterable {
    case main
}

typealias ListDataSource = UITableViewDiffableDataSource<Section, Wrapper>
typealias ListSnapshot = NSDiffableDataSourceSnapshot<Section, Wrapper>

final class ListViewController: UIViewController, Storyboarded {

    /// Outlet
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var compMemSegControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    /// Local
    var dataSource: ListDataSource!
    var viewModel = ListViewModel()
    let sortPickerView = PickerView()

    // MARK: - View life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizableStrings.listScreenTitle
        UIHelper.setNavigationItem(viewController: self,
                                   position: .right,
                                   image: nil,
                                   title: "Sort",
                                   action: #selector(rightButtonTapped))

        configureSegmentView()
        configureTableView()
        configureDataSource()
        configurePickerView()
        bindViewModel()
        viewModel.getCompanies()
    }

    // MARK: - Actions
    @IBAction func handleSegmentChanged(_ sender: UISegmentedControl) {
        sortPickerView.hidePicker()
        viewModel.loadSegmentWiseData()
    }

    @objc func rightButtonTapped() {
        updateSortOption()
        sortPickerView.showPicker()
    }

    // MARK: - Private
    private func bindViewModel() {

        /// Naive binding
        viewModel.listViewState.bind { [weak self]  (state) in

            switch state {
            case .idle: break
            case .loading:
                DispatchQueue.main.async {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.listTableView.alpha = 0.0
                    })
                }
            case .finished:
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.listTableView.alpha = 1.0
                    })
                }
            case .clubDataUpdates:
                DispatchQueue.main.async {
                    self?.updateListData()
                }
            case .error(let err):
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    UIAlertController.showAlert(title: LocalizableStrings.error,
                                                message: err.rawValue,
                                                cancelButton: LocalizableStrings.ok)
                }
            }
        }
    }
    private func configurePickerView() {

        sortPickerView.addPickerView(controller: self,
                                     pickerArray: viewModel.sortOption.company) { [weak self] (_, str) in

                                        guard let tab = ClubTabs.init(
                                            rawValue: ((self?.compMemSegControl.selectedSegmentIndex)!))
                                            else { return }

                                        self?.viewModel.sortCludData(
                                            (tab == ClubTabs.company)
                                                ? .company : .member,
                                            sortBy: str)
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
        sortPickerView.pickerDataSource = (compMemSegControl.selectedSegmentIndex == 0)
            ? viewModel.sortOption.company : viewModel.sortOption.member
    }

    private func configureSegmentView() {
        ClubTabs.allCases.forEach {
            compMemSegControl.setTitle($0.description, forSegmentAt: $0.rawValue)
        }
    }
}
