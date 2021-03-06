//
//  ProfileHeaderView.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    let profileImageView = UIImageView(frame: CGRectZero)
    let profileName = UILabel()
    let purchaseCountLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        if let url = NSUserDefaults.standardUserDefaults().stringForKey(userImage) {
            getDataFromUrl(NSURL(string: url)!) { (data, response, error)  in
                guard let data = data where error == nil else { return }
                dispatch_async(dispatch_get_main_queue(), {
                    self.profileImageView.image = UIImage(data: data)
                })
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = UIColor.groupTableViewBackgroundColor()

        self.profileImageView.image = UIImage(named: "placeholder.png")
        self.profileImageView.layer.borderWidth = 1.0
        self.profileImageView.layer.masksToBounds = false
        self.profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileImageView.layer.cornerRadius = 60
        self.profileImageView.clipsToBounds = true
        self.profileImageView.translatesAutoresizingMaskIntoConstraints = false

        self.profileName.text = NSUserDefaults.standardUserDefaults().stringForKey(userName)
        self.profileName.font = UIFont.quattroBoldFont(24)
        self.profileName.textAlignment = .Center
        self.profileName.translatesAutoresizingMaskIntoConstraints = false

        self.purchaseCountLabel.text = "132 PURCHASES"
        self.purchaseCountLabel.font = UIFont.cairoBoldFont(15)
        self.purchaseCountLabel.textColor = UIColor.pastelTealColor()
        self.purchaseCountLabel.textAlignment = .Center
        self.purchaseCountLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.profileImageView)
        self.addSubview(self.profileName)
        self.addSubview(self.purchaseCountLabel)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "superview": self,
            "profileImageView": self.profileImageView,
            "profileName": self.profileName,
            "purchaseCountLabel": self.purchaseCountLabel
        ]

        var allConstraints = [NSLayoutConstraint]()
        let profileImageViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[profileImageView]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: views)
        allConstraints += profileImageViewXConstraints
        allConstraints += getConstraintFromFormat("H:[profileImageView(120)]", views: views)
        allConstraints += getConstraintFromFormat("V:|-30-[profileImageView(120)]-30-[profileName]-[purchaseCountLabel]", views: views)
        allConstraints += getConstraintFromFormat("H:|-[profileName]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[purchaseCountLabel]-|", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

}
