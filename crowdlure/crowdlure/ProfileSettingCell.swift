//
//  ProfileSettingCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

enum TableCellType {
    case Alert,
    Default
}

class ProfileSettingCell: UITableViewCell {

    var title: String
    var type: TableCellType

    let titleLabel = UILabel()

    init(title: String, type: TableCellType = .Default) {
        self.title = title
        self.type = type
        super.init(style: .Default, reuseIdentifier: "ProfileSettingCell")
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.titleLabel.text = self.title
        if self.type == .Alert {
            self.titleLabel.textColor = UIColor.redColor()
        }
        self.titleLabel.textAlignment = .Center
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.titleLabel)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "titleLabel": self.titleLabel
        ]

        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getConstraintFromFormat("H:|-[titleLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("V:|-[titleLabel]-|", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
}