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
    @IBOutlet weak var favoriteButton: UIButton!

    /// Local
    var userFavAction: ((ActionType) -> Void)?

    var memberCellModel: MemberCellModel? {
        didSet {
            nameLabel.text = memberCellModel?.name
            agelabel.text = memberCellModel?.age.description
            phoneLabel.text = memberCellModel?.phone
            emailLabel.text = memberCellModel?.email
            setActionButtonImage(.favorite)
        }
    }

    // MARK: - Action
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        userFavAction?(ActionType.favorite)
    }

    // MARK: - Public
    func setActionButtonImage(_ type: ActionType) {

        switch type {
        case .favorite:
            if (memberCellModel?.isFavorite) == true {
                favoriteButton.setImage(UIImage(named: "ic_favorited"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "ic_favorite"), for: .normal)
            }
        case .follow: break
        }
    }
}
