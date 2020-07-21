//
//  MemberInfoCell.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 21/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

final class MemberInfoCell: UITableViewCell, ReusableView, NibLoadableView {

    /// Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var agelabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    var memberCellModel: MemberCellModel? {
        didSet {
            self.nameLabel.text = memberCellModel?.name
            self.agelabel.text = memberCellModel?.age.description
            self.phoneLabel.text = memberCellModel?.phone
            self.emailLabel.text = memberCellModel?.email
        }
    }

}
