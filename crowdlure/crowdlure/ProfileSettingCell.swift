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
    Primary,
    Default
}

class ProfileSettingCell: UITableViewCell {

    var title: String
    var type: TableCellType

    let containerView = UIView()
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
        self.backgroundColor = UIColor.clearColor()
        
        self.titleLabel.text = self.title.uppercaseString
        self.titleLabel.font = UIFont.cairoBoldFont(15)
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.textAlignment = .Center
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if self.type == .Primary {
            self.containerView.backgroundColor = UIColor.skyBlueColor()
        } else if self.type == .Alert {
            self.containerView.backgroundColor = UIColor.pastelRedColor()
        }
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.containerView)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "containerView": self.containerView,
            "titleLabel": self.titleLabel
        ]

        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getConstraintFromFormat("H:|[containerView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|-[containerView]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[titleLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("V:|-[titleLabel]-|", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
}