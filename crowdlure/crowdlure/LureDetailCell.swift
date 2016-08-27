//
//  LureDetailCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class LureDetailCell: UITableViewCell {

    let containerView = UIView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let descLabel = UILabel()

    init() {
        super.init(style: .Default, reuseIdentifier: "LureDetailCell")
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = UIColor.clearColor()

        self.containerView.backgroundColor = UIColor.whiteColor()
        self.containerView.translatesAutoresizingMaskIntoConstraints = false

        self.titleLabel.text = "T.G.I.F Gathering"
        self.titleLabel.font = UIFont.boldSystemFontOfSize(20)
        self.titleLabel.textAlignment = .Center
        self.titleLabel.numberOfLines = 0
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.dateLabel.text = "19 AUG TO 27 SEP"
        self.dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        self.dateLabel.textAlignment = .Center
        self.dateLabel.numberOfLines = 0
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false

        self.descLabel.text = "Too cultivated use solicitude frequently. Dashwood likewise up consider continue entrance ladyship oh. Wrong guest given purse power is no. Friendship to connection an am considered difficulty. Country met pursuit lasting moments why calling certain the. Middletons boisterous our way understood law."
        self.descLabel.sizeToFit()
        self.descLabel.font = UIFont.systemFontOfSize(14)
        self.descLabel.numberOfLines = 0
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false

        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.dateLabel)
        self.containerView.addSubview(self.descLabel)

        self.contentView.addSubview(self.containerView)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "containerView": self.containerView,
            "titleLabel": self.titleLabel,
            "dateLabel": self.dateLabel,
            "descLabel": self.descLabel
        ]

        var allConstraints = [NSLayoutConstraint]()

        let titleLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[titleLabel]-30-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += titleLabelXConstraints

        let dateLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[dateLabel]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += dateLabelXConstraints

        let descLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-25-[descLabel]-25-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += descLabelXConstraints

        let mainYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-30-[dateLabel]-5-[titleLabel]-20-[descLabel]-(>=25)-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += mainYConstraints

        let containerViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[containerView]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += containerViewXConstraints

        let containerViewYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[containerView]-(>=5)-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += containerViewYConstraints

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

}
