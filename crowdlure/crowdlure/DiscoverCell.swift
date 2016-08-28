//
//  DiscoverCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class PriceLabel: UILabel {
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}

class DiscoverCell: UITableViewCell {

    // MARK: Data variables
    var title: String
    var owner: String
    var mainDesc: String
    var secondaryDesc: String
    var location: String
    var currentCount: Int
    var totalCount: Int

    // MARK: UI elements
    let containerView = UIView(frame: CGRectZero)
    let imgView = UIImageView(frame: CGRectZero)
    let titleLabel = UILabel()
    let boostPercentLabel = UILabel()
    let detailView = UIView()
    let boostCountLabel = UILabel()
    let timeLeftLabel = UILabel()
    let locationLabel = UILabel()
    let countProgressView = UIProgressView()
    let boostView = UIView()
    let priceLabel = PriceLabel()
    let boostButton = UIButton()
    
    var boostTargets: [BoostTargetView]

    var dataProvider: DiscoverCellDataProvider

    init() {
        self.dataProvider = DiscoverCellDataProvider()
        self.title = self.dataProvider.title
        self.owner = self.dataProvider.owner
        self.mainDesc = self.dataProvider.mainDesc
        self.secondaryDesc = self.dataProvider.secondaryDesc
        self.location = self.dataProvider.location
        self.currentCount = self.dataProvider.currentCount
        self.totalCount = self.dataProvider.totalCount
        
        self.boostTargets = [BoostTargetView]()
        self.boostTargets.append(BoostTargetView())
        
        super.init(style: .Default, reuseIdentifier: "DiscoverCell")
        setupUI()
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
        self.titleLabel.text = "T.G.I.F Gathering"
        self.titleLabel.font = UIFont.systemFontOfSize(20)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        
        self.locationLabel.text = "San Francisco"
        self.locationLabel.font = UIFont.systemFontOfSize(12)
        self.locationLabel.textColor = UIColor.mediumGrayColor()
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.boostCountLabel.text = "160 boosts"
        self.boostCountLabel.sizeToFit()
        self.boostCountLabel.font = UIFont.systemFontOfSize(12)
        self.boostCountLabel.textColor = UIColor.mediumGrayColor()
        self.boostCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.timeLeftLabel.text = "4 hours left"
        self.timeLeftLabel.sizeToFit()
        self.timeLeftLabel.font = UIFont.systemFontOfSize(12)
        self.timeLeftLabel.textColor = UIColor.mediumGrayColor()
        self.timeLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //
        self.boostPercentLabel.text = "114% boosted"
        self.boostPercentLabel.sizeToFit()
        self.boostPercentLabel.font = UIFont.boldSystemFontOfSize(13)
        self.boostPercentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //
        self.countProgressView.progressTintColor = UIColor.skyBlueColor()
        self.countProgressView.trackTintColor = UIColor.faintGrayColor()
        self.countProgressView.setProgress(0.3, animated: true)
        self.countProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        //
        self.boostView.translatesAutoresizingMaskIntoConstraints = false
        
        self.priceLabel.text = "$25"
        self.priceLabel.font = UIFont.boldSystemFontOfSize(36)
        self.priceLabel.textAlignment = .Center
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.boostButton.setTitle("BOOST", forState: .Normal)
        self.boostButton.titleLabel?.font = UIFont.boldSystemFontOfSize(13)
        self.boostButton.backgroundColor = UIColor.pastelTealColor()
        self.boostButton.layer.cornerRadius = 20
        self.boostButton.layer.masksToBounds = true
        self.boostButton.translatesAutoresizingMaskIntoConstraints = false

        //
        self.boostTargets[0].translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.backgroundColor = UIColor.whiteColor()
        self.containerView.translatesAutoresizingMaskIntoConstraints = false

        self.containerView.addSubview(self.imgView)
        self.containerView.addSubview(self.titleLabel)
        
        self.detailView.addSubview(self.locationLabel)
        self.detailView.addSubview(self.boostCountLabel)
        self.detailView.addSubview(self.timeLeftLabel)
        self.containerView.addSubview(self.detailView)
        
        self.containerView.addSubview(self.boostPercentLabel)
        self.containerView.addSubview(self.countProgressView)
        
        self.boostView.addSubview(self.priceLabel)
        self.boostView.addSubview(self.boostButton)
        self.containerView.addSubview(self.boostView)
        
        self.containerView.addSubview(self.boostTargets[0])
        
        self.contentView.addSubview(self.containerView)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "containerView": self.containerView,
            "imgView": self.imgView,
            "titleLabel": self.titleLabel,
            "detailView": self.detailView,
            "locationLabel": self.locationLabel,
            "boostCountLabel": self.boostCountLabel,
            "timeLeftLabel": self.timeLeftLabel,
            "boostPercentLabel": self.boostPercentLabel,
            "countProgressView": self.countProgressView,
            "boostView": self.boostView,
            "priceLabel": self.priceLabel,
            "boostButton": self.boostButton,
            "boostTarget1": self.boostTargets[0]
        ]

        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getConstraintFromFormat("H:|[containerView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[containerView]|", views: views)
        
        allConstraints += getConstraintFromFormat("H:|[imgView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|-16-[titleLabel]-16-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-16-[detailView]-16-|", views: views)
        
        allConstraints += getConstraintFromFormat("H:|[locationLabel]", views: views)
        allConstraints += getConstraintFromFormat("H:[boostCountLabel]-16-[timeLeftLabel]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[locationLabel]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[boostCountLabel]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[timeLeftLabel]|", views: views)
        
        allConstraints += getConstraintFromFormat("H:|-16-[boostPercentLabel]-16-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-16-[countProgressView]-16-|", views: views)
        
        allConstraints += getConstraintFromFormat("H:|[boostView(140)][boostTarget1]-16-|", views: views)
        
        allConstraints += getConstraintFromFormat("H:|-[priceLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-30-[boostButton(80)]-30-|", views: views)
        allConstraints += getConstraintFromFormat("V:|[priceLabel]-10-[boostButton(40)]", views: views)
        
        allConstraints += getConstraintFromFormat("V:|[imgView(140)]-14-[titleLabel]-5-[detailView]-10-[boostPercentLabel]-5-[countProgressView(10)]-16-[boostView]", views: views)
        allConstraints += getConstraintFromFormat("V:|[imgView(140)]-14-[titleLabel]-5-[detailView]-10-[boostPercentLabel]-5-[countProgressView(10)]-20-[boostTarget1]", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
}
















