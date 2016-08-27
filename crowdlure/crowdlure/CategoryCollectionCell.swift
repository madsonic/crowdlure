//
//  CategoryCollectionCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {

    let frontView = UIView(frame: CGRectZero)
    let bgImageView = UIImageView()
    let categoryIconView = UIImageView()
    let categoryTitle = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.frontView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.frontView.translatesAutoresizingMaskIntoConstraints = false

        self.categoryIconView.translatesAutoresizingMaskIntoConstraints = false

        self.categoryTitle.numberOfLines = 0
        self.categoryTitle.textColor = UIColor.whiteColor()
        self.categoryTitle.textAlignment = .Center
        self.categoryTitle.translatesAutoresizingMaskIntoConstraints = false

        self.bgImageView.image = UIImage(named: "restaurants.jpg")
        self.bgImageView.translatesAutoresizingMaskIntoConstraints = false

        self.frontView.addSubview(self.categoryIconView)
        self.frontView.addSubview(self.categoryTitle)
        self.contentView.addSubview(self.bgImageView)
        self.contentView.addSubview(self.frontView)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "bgImageView": self.bgImageView,
            "frontView": self.frontView,
            "categoryIconView": self.categoryIconView,
            "categoryTitle": self.categoryTitle
        ]

        var allConstraints = [NSLayoutConstraint]()

        let frontViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[frontView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += frontViewXConstraints

        let frontViewYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[frontView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += frontViewYConstraints

        let frontYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-[categoryTitle]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += frontYConstraints

        let categoryTitleXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[categoryTitle]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += categoryTitleXConstraints

        let bgImageViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[bgImageView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += bgImageViewXConstraints

        let bgImageViewYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[bgImageView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += bgImageViewYConstraints

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

    func updateUI(categoryTitle: String) {
        self.categoryTitle.text = categoryTitle
    }

}
