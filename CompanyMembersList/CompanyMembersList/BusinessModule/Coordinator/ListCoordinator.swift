//
//  ListCoordinator.swift
//  CompanyMembers
//
//  Created by Harshal Wani on 19/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

final class ListCoordinator: Coordinator {

    private var presenter: UINavigationController
    private var listViewController: ListViewController?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let listViewController = ListViewController.instantiate()
        self.listViewController = listViewController
        presenter.pushViewController(listViewController, animated: true)
    }
}
