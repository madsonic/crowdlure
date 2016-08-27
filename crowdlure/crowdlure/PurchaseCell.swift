//
//  PurchaseCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class PurchaseCell: UITableViewCell {

    private(set) var expired: Bool

    let containerView = UIView(frame: CGRectZero)
    let overlayView = UIView(frame: CGRectZero)
    let bodyView = UIView(frame: CGRectZero)
    let imgView = UIImageView()
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let dateLabel = UILabel()

    init(expired: Bool = false) {
        self.expired = expired
        super.init(style: .Default, reuseIdentifier: "PurchaseCell")
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor()

        self.containerView.backgroundColor = UIColor.whiteColor()
        self.containerView.translatesAutoresizingMaskIntoConstraints = false

        if self.expired {
            self.overlayView.backgroundColor = UIColor.groupTableViewBackgroundColor().colorWithAlphaComponent(0.5)
        } else {
            self.overlayView.backgroundColor = UIColor.clearColor()
        }
        self.overlayView.translatesAutoresizingMaskIntoConstraints = false

        self.bodyView.translatesAutoresizingMaskIntoConstraints = false

        self.imgView.image = UIImage(named: "restaurants.jpg")
        self.imgView.clipsToBounds = true
        self.imgView.translatesAutoresizingMaskIntoConstraints = false

        self.titleLabel.text = "Philz Coffee"
        self.titleLabel.font = UIFont.boldSystemFontOfSize(16)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.descLabel.text = "Performance by Beatles"
        self.descLabel.font = UIFont.systemFontOfSize(14)
        self.descLabel.numberOfLines = 0
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false

        self.dateLabel.text = "17 AUG TO 20 AUG"
        self.dateLabel.font = UIFont.systemFontOfSize(12)
        self.dateLabel.textColor = UIColor.grayColor()
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false

        self.bodyView.addSubview(self.titleLabel)
        self.bodyView.addSubview(self.descLabel)
        self.bodyView.addSubview(self.dateLabel)

        self.containerView.addSubview(self.imgView)
        self.containerView.addSubview(self.bodyView)
        self.containerView.addSubview(self.overlayView)

        self.contentView.addSubview(self.containerView)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "containerView": self.containerView,
            "overlayView": self.overlayView,
            "bodyView": self.bodyView,
            "imgView": self.imgView,
            "titleLabel": self.titleLabel,
            "descLabel": self.descLabel,
            "dateLabel": self.dateLabel
        ]

        var allConstraints = [NSLayoutConstraint]()

        allConstraints += getConstraintFromFormat("H:|-10-[containerView]-10-|", views: views)
        allConstraints += getConstraintFromFormat("V:|[containerView]|", views: views)

        allConstraints += getConstraintFromFormat("H:|[overlayView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[overlayView]|", views: views)

        allConstraints += getConstraintFromFormat("V:|[imgView(90)]", views: views)
        allConstraints += getConstraintFromFormat("H:|[imgView(90)]-[bodyView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[bodyView(90)]", views: views)

        allConstraints += getConstraintFromFormat("H:|-[titleLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[descLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[dateLabel]-|", views: views)

        allConstraints += getConstraintFromFormat("V:|-[titleLabel(14)]-[descLabel(20)]-[dateLabel(14)]-|", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

}
