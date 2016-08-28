//
//  CampaignHeaderView.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class CampaignHeaderView: UIView {
    var merchantName: String
    var merchantLocation: String
    var merchantFirstLetter: String {
        if let firstLetter = merchantName.characters.first {
            return String(firstLetter)
        }
        return ""
    }

    var merchantStackView = UIStackView()
    var merchantInfoStackView = UIStackView()
    var merchantInitialsLabel = UILabel()
    var merchantNameLabel = UILabel()
    var merchantLocationLabel = UILabel()

    init(frame: CGRect = CGRectZero, merchantName: String, merchantLocation: String) {
        self.merchantName = merchantName
        self.merchantLocation = merchantLocation
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        backgroundColor = .deepGrayColor()

        merchantStackView.axis = .Horizontal
        merchantStackView.spacing = 10
        merchantStackView.addArrangedSubview(merchantInitialsLabel)
        merchantStackView.addArrangedSubview(merchantInfoStackView)
        merchantStackView.translatesAutoresizingMaskIntoConstraints = false

        merchantInfoStackView.axis = .Vertical
        merchantInfoStackView.distribution = .FillProportionally
        merchantInfoStackView.alignment = .Leading
        merchantInfoStackView.addArrangedSubview(merchantNameLabel)
        merchantInfoStackView.addArrangedSubview(merchantLocationLabel)
        merchantInfoStackView.translatesAutoresizingMaskIntoConstraints = false

        merchantNameLabel.text = merchantName
        merchantNameLabel.font = UIFont.cairoRegularFont(17)
        merchantNameLabel.textColor = .whiteColor()
        merchantNameLabel.translatesAutoresizingMaskIntoConstraints = false

        merchantLocationLabel.text = merchantLocation
        merchantLocationLabel.font = UIFont.cairoRegularFont(10)
        merchantLocationLabel.textColor = .pastelYellowColor()
        merchantLocationLabel.translatesAutoresizingMaskIntoConstraints = false

        merchantInitialsLabel.text = merchantFirstLetter.uppercaseString
        merchantInitialsLabel.textAlignment = .Center
        merchantInitialsLabel.font = UIFont.cairoRegularFont(30)
        merchantInitialsLabel.textColor = .whiteColor()
        merchantInitialsLabel.backgroundColor = .mediumGrayColor()
        merchantInitialsLabel.layer.masksToBounds = true
        merchantInitialsLabel.layer.cornerRadius = 20
        merchantInitialsLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(merchantStackView)

        setupConstraints()
    }

    func setupConstraints() {
        var allConstraints = [NSLayoutConstraint]()
        let views = ["merchantStackView": merchantStackView,
                     "merchantInfoStackView": merchantInfoStackView,
                     "merchantInitialsLabel": merchantInitialsLabel,
                     "merchantNameLabel": merchantNameLabel,
                     "merchantLocationLabel": merchantLocationLabel]

        let merchantStackViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[merchantStackView]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += merchantStackViewXConstraints

        let merchantInitialsLabelWidthConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[merchantInitialsLabel(40)]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += merchantInitialsLabelWidthConstraints

        let merchantInitialsLabelHeightConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[merchantInitialsLabel(40)]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += merchantInitialsLabelHeightConstraints

        NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: merchantStackView, attribute: .CenterY, multiplier: 1, constant: 0).active = true

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
}