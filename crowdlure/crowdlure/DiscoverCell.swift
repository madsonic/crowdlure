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
    let dateLabel = UILabel()
    let titleLabel = UILabel()
    let locationLabel = UILabel()
    let countProgressView = UIProgressView()
    let countLabel = UILabel()
    let priceLabel = PriceLabel()

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

        self.priceLabel.text = "$70"
        self.priceLabel.font = UIFont.systemFontOfSize(16)
        self.priceLabel.textAlignment = .Center
        self.priceLabel.textColor = UIColor.lightGrayColor()
        self.priceLabel.backgroundColor = UIColor.blackColor()
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false

        self.dateLabel.text = "25 AUG TO 31 AUG"
        self.dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false

        self.countLabel.text = "19 MORE TO GO"
        self.countLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        self.countLabel.textAlignment = .Right
        self.countLabel.textColor = UIColor.grayColor()
        self.countLabel.translatesAutoresizingMaskIntoConstraints = false

        self.titleLabel.text = "T.G.I.F Gathering"
        self.titleLabel.font = UIFont.boldSystemFontOfSize(20)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.locationLabel.text = "SAN FRANCISCO"
        self.locationLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false

        self.countProgressView.progressTintColor = self.tintColor
        self.countProgressView.setProgress(0.3, animated: false)
        self.countProgressView.translatesAutoresizingMaskIntoConstraints = false

        self.containerView.backgroundColor = UIColor.whiteColor()
        self.containerView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.imgView)
        self.containerView.addSubview(self.priceLabel)
        self.containerView.addSubview(self.countProgressView)
        self.containerView.addSubview(self.dateLabel)
        self.containerView.addSubview(self.countLabel)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.locationLabel)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "containerView": self.containerView,
            "imgView": self.imgView,
            "countProgressView": self.countProgressView,
            "dateLabel": self.dateLabel,
            "countLabel": self.countLabel,
            "titleLabel": self.titleLabel,
            "locationLabel": self.locationLabel,
            "priceLabel": self.priceLabel
        ]

        var allConstraints = [NSLayoutConstraint]()

        let priceLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[priceLabel]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += priceLabelXConstraints

        let priceLabelYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[priceLabel]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += priceLabelYConstraints

        let imgViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[imgView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += imgViewXConstraints

        let countProgressViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[countProgressView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += countProgressViewXConstraints

        let dateLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[dateLabel]-[countLabel]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += dateLabelXConstraints

        let titleLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[titleLabel]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += titleLabelXConstraints

        let locationLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[locationLabel]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += locationLabelXConstraints

        let containerViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[containerView]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += containerViewXConstraints

        let containerViewYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[containerView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += containerViewYConstraints

        let countLabelYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-157-[countLabel(14)]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += countLabelYConstraints

        let mainYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[imgView(140)][countProgressView(3)]-14-[dateLabel(14)]-5-[titleLabel(26)]-5-[locationLabel(14)]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += mainYConstraints

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
}
