//
//  SearchTableCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

func getConstraintFromFormat(format:String, views: [String: AnyObject]) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.constraintsWithVisualFormat(format, options: [], metrics: nil, views: views)
}

class SearchTableCell: UITableViewCell {

    let bodyView = UIView(frame: CGRectZero)
    let imgView = UIImageView()
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let priceLabel = UILabel()
    let dateLabel = UILabel()
    let footerView = UIView(frame: CGRectZero)

    init() {
        super.init(style: .Default, reuseIdentifier: "SearchCell")
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.bodyView.translatesAutoresizingMaskIntoConstraints = false

        self.imgView.image = UIImage(named: "restaurants.jpg")
        self.imgView.translatesAutoresizingMaskIntoConstraints = false

        self.titleLabel.text = "Philz Coffee"
        self.titleLabel.font = UIFont.boldSystemFontOfSize(16)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.descLabel.text = "Performance by Beatles"
        self.descLabel.font = UIFont.systemFontOfSize(14)
        self.descLabel.numberOfLines = 0
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false

        self.priceLabel.text = "$4.50"
        self.priceLabel.font = UIFont.systemFontOfSize(13)
        self.priceLabel.textAlignment = .Right
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false

        self.dateLabel.text = "17 AUG TO 20 AUG"
        self.dateLabel.font = UIFont.systemFontOfSize(12)
        self.dateLabel.textColor = UIColor.grayColor()
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false

        self.footerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.footerView.translatesAutoresizingMaskIntoConstraints = false

        self.bodyView.addSubview(self.titleLabel)
        self.bodyView.addSubview(self.descLabel)
        self.bodyView.addSubview(self.dateLabel)
        self.bodyView.addSubview(self.priceLabel)

        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.bodyView)
        self.contentView.addSubview(self.footerView)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "bodyView": self.bodyView,
            "imgView": self.imgView,
            "titleLabel": self.titleLabel,
            "descLabel": self.descLabel,
            "priceLabel": self.priceLabel,
            "dateLabel": self.dateLabel,
            "footerView": self.footerView
        ]

        var allConstraints = [NSLayoutConstraint]()

        allConstraints += getConstraintFromFormat("H:|[footerView]|", views: views)

        allConstraints += getConstraintFromFormat("V:|[imgView(90)][footerView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[imgView(90)]-[bodyView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[bodyView(90)][footerView]|", views: views)

        allConstraints += getConstraintFromFormat("H:|-[titleLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[descLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[dateLabel]-[priceLabel]-|", views: views)

        allConstraints += getConstraintFromFormat("V:|-[titleLabel(14)]-[descLabel(20)]-[dateLabel(14)]-|", views: views)
        allConstraints += getConstraintFromFormat("V:|-[titleLabel(14)]-[descLabel(20)]-[priceLabel(14)]-|", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
}