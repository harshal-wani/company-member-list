//
//  CompanyInfoCell.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 20/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit
import SDWebImage

enum ActionType {
    case favorite
    case follow
}
final class CompanyInfoCell: UITableViewCell, ReusableView, NibLoadableView {

    /// Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutlabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!

    /// Local
    var userFavFollowAction: ((ActionType) -> Void)?

    var companyCellModel: CompanyCellModel? {
        didSet {
            nameLabel.text = companyCellModel?.name
            aboutlabel.text = companyCellModel?.about
            websiteLabel.text = companyCellModel?.website
            setActionButtonImage(.favorite)
            setActionButtonImage(.follow)
            if let url = companyCellModel?.logo {
                logoImage.sd_setImage(with: URL(string: url))
            }
        }
    }

    // MARK: - Action
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        userFavFollowAction?(ActionType.favorite)
    }

    @IBAction func followButtonTapped(_ sender: UIButton) {
        userFavFollowAction?(ActionType.follow)
    }

    // MARK: - Public
    func setActionButtonImage(_ type: ActionType) {

        switch type {
        case .favorite:
            if (companyCellModel?.isFavorite) == true {
                favoriteButton.setImage(UIImage(named: "ic_favorited"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "ic_favorite"), for: .normal)
            }

        case .follow:
            if (companyCellModel?.isfollow) == true {
                followButton.setImage(UIImage(named: "ic_following"), for: .normal)
            } else {
                followButton.setImage(UIImage(named: "ic_follow"), for: .normal)
            }
        }
    }
}
