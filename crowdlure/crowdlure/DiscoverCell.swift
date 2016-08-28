//
//  DiscoverCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import SwiftyJSON

class PriceLabel: UILabel {
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}

class DiscoverCell: UITableViewCell, DataProviderDelegate {

    // MARK: UI elements
    let containerView = UIView(frame: CGRectZero)
    let imgView = UIImageView(frame: CGRectZero)
    let titleLabel = UILabel()
    let boostPercentLabel = UILabel()
    let detailView = UIView()
    let boostCountLabel = UILabel()
    let timeLeftLabel = UILabel()
    let countProgressView = UIProgressView()
    let boostView = UIView()
    let priceLabel = PriceLabel()
    let boostButton = UIButton()
    
    var boostTargets: [BoostTargetView]

    var dataProvider: LureDataProvider

    init(lure: JSON) {
        self.dataProvider = LureDataProvider(lure: lure)
        
        self.boostTargets = [BoostTargetView]()
        var i = 0
        for desc in self.dataProvider.getTargetDescriptions() {
            self.boostTargets.append(BoostTargetView(description: desc, index: i))
            i += 1
        }
        
        super.init(style: .Default, reuseIdentifier: "DiscoverCell")
        self.dataProvider.delegate = self
        setupUI()
        self.dataProvider.viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = UIColor.clearColor()

        self.imgView.image = UIImage(named: "club.jpg")
        self.imgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imgView.clipsToBounds = true
        self.imgView.translatesAutoresizingMaskIntoConstraints = false

        //
        self.titleLabel.text = self.dataProvider.getTitle()
        self.titleLabel.font = UIFont.cairoRegularFont(20)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.detailView.translatesAutoresizingMaskIntoConstraints = false

        self.boostCountLabel.text = "\(self.dataProvider.getBoostCount()) Boosts"
        self.boostCountLabel.sizeToFit()
        self.boostCountLabel.font = UIFont.cairoRegularFont(12)
        self.boostCountLabel.textColor = UIColor.mediumGrayColor()
        self.boostCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.timeLeftLabel.text = "\(self.dataProvider.getValidTill())"
        self.timeLeftLabel.sizeToFit()
        self.timeLeftLabel.font = UIFont.cairoRegularFont(12)
        self.timeLeftLabel.textColor = UIColor.mediumGrayColor()
        self.timeLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //
        self.boostPercentLabel.text = "\(String(format: "%.1f", self.dataProvider.getBoostPercent()))% Boosted"
        self.boostPercentLabel.sizeToFit()
        self.boostPercentLabel.font = UIFont.cairoBoldFont(13)
        self.boostPercentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //
        self.countProgressView.progressTintColor = UIColor.skyBlueColor()
        self.countProgressView.trackTintColor = UIColor.faintGrayColor()
        self.countProgressView.setProgress(0.3, animated: true)
        self.countProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        //
        self.boostView.translatesAutoresizingMaskIntoConstraints = false
        
        self.priceLabel.text = "$" + String(format: "%.2f", self.dataProvider.getPrice())
        self.priceLabel.font = UIFont.cairoBoldFont(36)
        self.priceLabel.textAlignment = .Center
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.boostButton.setTitle("BOOST", forState: .Normal)
        self.boostButton.titleLabel?.font = UIFont.cairoBoldFont(13)
        self.boostButton.backgroundColor = UIColor.pastelTealColor()
        self.boostButton.layer.cornerRadius = 20
        self.boostButton.layer.masksToBounds = true
        self.boostButton.translatesAutoresizingMaskIntoConstraints = false

        //
        for boostTarget in self.boostTargets {
            boostTarget.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.containerView.backgroundColor = UIColor.whiteColor()
        self.containerView.translatesAutoresizingMaskIntoConstraints = false

        self.containerView.addSubview(self.imgView)
        self.containerView.addSubview(self.titleLabel)
        
        self.detailView.addSubview(self.boostCountLabel)
        self.detailView.addSubview(self.timeLeftLabel)
        self.containerView.addSubview(self.detailView)
        
        self.containerView.addSubview(self.boostPercentLabel)
        self.containerView.addSubview(self.countProgressView)
        
        self.boostView.addSubview(self.priceLabel)
        self.boostView.addSubview(self.boostButton)
        self.containerView.addSubview(self.boostView)
        
        for boostTarget in self.boostTargets {
            self.containerView.addSubview(boostTarget)
        }
        
        self.contentView.addSubview(self.containerView)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        var views = [
            "containerView": self.containerView,
            "imgView": self.imgView,
            "titleLabel": self.titleLabel,
            "detailView": self.detailView,
            "boostCountLabel": self.boostCountLabel,
            "timeLeftLabel": self.timeLeftLabel,
            "boostPercentLabel": self.boostPercentLabel,
            "countProgressView": self.countProgressView,
            "boostView": self.boostView,
            "priceLabel": self.priceLabel,
            "boostButton": self.boostButton
        ]
        
        var i = 1
        for boostTarget in self.boostTargets {
            views["boostTarget\(i)"] = boostTarget
            i += 1
        }

        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getConstraintFromFormat("H:|[containerView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[containerView]|", views: views)
        
        allConstraints += getConstraintFromFormat("H:|[imgView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|-16-[titleLabel]-16-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-16-[detailView]-16-|", views: views)
        
        allConstraints += getConstraintFromFormat("H:[boostCountLabel]-16-[timeLeftLabel]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[boostCountLabel]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[timeLeftLabel]|", views: views)
        
        allConstraints += getConstraintFromFormat("H:|-16-[boostPercentLabel]-16-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-16-[countProgressView]-16-|", views: views)
        
        for n in 1..<i {
            allConstraints += getConstraintFromFormat("H:|[boostView(140)][boostTarget\(n)]-16-|", views: views)
        }
        
        allConstraints += getConstraintFromFormat("H:|-[priceLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-30-[boostButton(80)]-30-|", views: views)
        allConstraints += getConstraintFromFormat("V:|[priceLabel]-10-[boostButton(40)]", views: views)
        
        allConstraints += getConstraintFromFormat("V:|[imgView(140)]-14-[titleLabel]-5-[detailView]-10-[boostPercentLabel]-5-[countProgressView(10)]-16-[boostView]", views: views)
        
        var boostTargetsFormat = "V:|[imgView(140)]-14-[titleLabel]-5-[detailView]-10-[boostPercentLabel]-5-[countProgressView(10)]"
        for n in 1..<i {
            boostTargetsFormat += "-20-[boostTarget\(n)]"
        }
        
        allConstraints += getConstraintFromFormat(boostTargetsFormat, views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    func dataUpdated() {
        if let imgData = self.dataProvider.imgData {
            self.imgView.image = UIImage(data: imgData)
        }
    }
    
}