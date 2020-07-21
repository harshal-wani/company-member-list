//
//  CompanyInfoCell.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 20/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import UIKit

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

    /// Local
    var userFavFollowAction: ((ActionType) -> Void)?

    var companyCellModel: CompanyCellModel? {
        didSet {
            self.nameLabel.text = companyCellModel?.name
            self.aboutlabel.text = companyCellModel?.about
            self.websiteLabel.text = companyCellModel?.website
            self.setActionButtonImage(.favorite)
            self.setActionButtonImage(.follow)
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
                self.favoriteButton.setImage(UIImage(named: "ic_favorited"), for: .normal)
            } else {
                self.favoriteButton.setImage(UIImage(named: "ic_favorite"), for: .normal)
            }

        case .follow:
            if (companyCellModel?.isfollow) == true {
                self.followButton.setImage(UIImage(named: "ic_following"), for: .normal)
            } else {
                self.followButton.setImage(UIImage(named: "ic_follow"), for: .normal)
            }
        }
    }
}
