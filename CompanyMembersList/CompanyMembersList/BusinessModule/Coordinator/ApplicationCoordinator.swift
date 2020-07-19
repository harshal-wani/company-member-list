//
//  ApplicationCoordinator.swift
//  WordGame
//
//  Created by Harshal Wani on 19/07/20.
//  Copyright © 2019 Harshal Wani. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {

    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var listCoordinator: ListCoordinator?

    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        listCoordinator = ListCoordinator(presenter: rootViewController)
    }

    func start() {
        window.rootViewController = rootViewController
        listCoordinator?.start()
        window.makeKeyAndVisible()
    }

}
