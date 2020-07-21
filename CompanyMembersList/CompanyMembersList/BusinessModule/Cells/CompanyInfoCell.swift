//
//  CompanyInfoCell.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 20/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

final class CompanyInfoCell: UITableViewCell, ReusableView, NibLoadableView {

    /// Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutlabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
}
