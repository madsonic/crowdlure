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
    
    let bgView = UIImageView()
    let containerView = UIView(frame: CGRectZero)
    let overlayView = UIView(frame: CGRectZero)
    let bodyView = UIView(frame: CGRectZero)
    let bizNameLabel = UILabel()
    let imgView = UIImageView()
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let dateLabel = UILabel()

    init(expired: Bool = false) {
        self.expired = expired
        super.init(style: .Default, reuseIdentifier: "PurchaseCell")
        self.selectionStyle = .None
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor()

        self.bgView.image = UIImage(named: "club.jpg")
        self.bgView.translatesAutoresizingMaskIntoConstraints = false
        self.bgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.bgView.clipsToBounds = true
        
        self.containerView.backgroundColor = UIColor.pastelTealColor().colorWithAlphaComponent(0.9)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false

        if self.expired {
            self.overlayView.backgroundColor = UIColor.groupTableViewBackgroundColor().colorWithAlphaComponent(0.5)
        } else {
            self.overlayView.backgroundColor = UIColor.clearColor()
        }
        self.overlayView.translatesAutoresizingMaskIntoConstraints = false

        self.bodyView.translatesAutoresizingMaskIntoConstraints = false
        
        self.imgView.image = UIImage(named: "club.jpg")
        self.imgView.layer.masksToBounds = false
        self.imgView.layer.borderColor = UIColor.whiteColor().CGColor
        self.imgView.layer.cornerRadius = 25
        self.imgView.clipsToBounds = true
        self.imgView.translatesAutoresizingMaskIntoConstraints = false

        self.bizNameLabel.text = "Ashtray"
        self.bizNameLabel.font = UIFont.boldSystemFontOfSize(14)
        self.bizNameLabel.textColor = UIColor.whiteColor()
        self.bizNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Validity date
        self.dateLabel.text = "Valid till 20 Aug"
        self.dateLabel.font = UIFont.systemFontOfSize(13)
        self.dateLabel.textColor = UIColor.whiteColor()
        self.dateLabel.textAlignment = .Right
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // For the purchased good
        self.titleLabel.text = "Philz Coffee"
        self.titleLabel.font = UIFont.boldSystemFontOfSize(15)
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // For the incentive
        self.descLabel.text = "Performance by Beatles"
        self.descLabel.font = UIFont.systemFontOfSize(15)
        self.descLabel.textColor = UIColor.whiteColor()
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false

        self.bodyView.addSubview(self.imgView)
        self.bodyView.addSubview(self.bizNameLabel)
        self.bodyView.addSubview(self.dateLabel)

        self.containerView.addSubview(self.bodyView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.descLabel)
        self.containerView.addSubview(self.overlayView)
        
        self.contentView.addSubview(self.bgView)
        self.contentView.addSubview(self.containerView)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "bgView": self.bgView,
            "containerView": self.containerView,
            "overlayView": self.overlayView,
            "bodyView": self.bodyView,
            "imgView": self.imgView,
            "titleLabel": self.titleLabel,
            "descLabel": self.descLabel,
            "dateLabel": self.dateLabel,
            "bizNameLabel": self.bizNameLabel
        ]

        var allConstraints = [NSLayoutConstraint]()

        allConstraints += getConstraintFromFormat("H:|[bgView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[bgView]|", views: views)
        
        allConstraints += getConstraintFromFormat("H:|[containerView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[containerView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[overlayView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[overlayView]|", views: views)
        
        allConstraints += getConstraintFromFormat("H:|[bodyView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|-20-[titleLabel]-20-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-20-[descLabel]-20-|", views: views)
        
        allConstraints += getConstraintFromFormat("V:|[bodyView(70)]-5-[titleLabel]-5-[descLabel]", views: views)
        
        allConstraints += getConstraintFromFormat("V:|-10-[imgView(50)]", views: views)
        allConstraints += getConstraintFromFormat("V:|-[bizNameLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("V:|-[dateLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-20-[imgView(50)]-20-[bizNameLabel]-[dateLabel]-20-|", views: views)
        
//        allConstraints += getConstraintFromFormat("H:|-10-[containerView]-10-|", views: views)
//        allConstraints += getConstraintFromFormat("V:|[containerView]|", views: views)
//
//        allConstraints += getConstraintFromFormat("H:|[overlayView]|", views: views)
//        allConstraints += getConstraintFromFormat("V:|[overlayView]|", views: views)
//
//        allConstraints += getConstraintFromFormat("V:|[imgView(90)]", views: views)
//        allConstraints += getConstraintFromFormat("H:|[imgView(90)]-[bodyView]|", views: views)
//        allConstraints += getConstraintFromFormat("V:|[bodyView(90)]", views: views)
//
//        allConstraints += getConstraintFromFormat("H:|-[titleLabel]-|", views: views)
//        allConstraints += getConstraintFromFormat("H:|-[descLabel]-|", views: views)
//        allConstraints += getConstraintFromFormat("H:|-[dateLabel]-|", views: views)
//
//        allConstraints += getConstraintFromFormat("V:|-[titleLabel(14)]-[descLabel(20)]-[dateLabel(14)]-|", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

}
