//
//  UIHelper.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 20/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

/// Navigation item position
enum Position {
    case left
    case right
}

class UIHelper: NSObject {

    /// Create navigation bar item
    /// - Parameter viewController: to add navigation button
    /// - Parameter position: set button position left/right
    /// - Parameter image: add image to button
    /// - Parameter title: set button title
    /// - Parameter action: add action on tapped
    class func setNavigationItem(viewController: UIViewController,
                                 position: Position,
                                 image: String?,
                                 title: String? = "",
                                 action: Selector? = nil) {

        let button = UIButton(type: (image != nil) ? .custom : .system)
        button.setTitle(title, for: .normal)

        let barItem: UIBarButtonItem!
        if let iconName = image {
            let icon = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
            button.setImage(icon, for: .normal)
        }

        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        barItem = UIBarButtonItem(customView: button)

        switch position {
        case .left:
            viewController.navigationItem.setLeftBarButton(barItem, animated: true)
        case .right:
            viewController.navigationItem.setRightBarButton(barItem, animated: true)
        }
        if let actionValue = action {
            button.addTarget(viewController, action: actionValue, for: .touchUpInside)
        }
    }
}
