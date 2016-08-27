//
//  DiscoverTabView.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class DiscoverTabView: UIView {

    private let titleLabel = UILabel()
    private let highlight = UIView()

    private(set) var title: String

    init(title: String) {
        self.title = title
        super.init(frame: CGRectZero)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.titleLabel.text = self.title
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.highlight.backgroundColor = self.tintColor
        self.highlight.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.titleLabel)
        self.addSubview(self.highlight)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "superview": self,
            "titleLabel": self.titleLabel,
            "highlight": self.highlight
        ]

        var allConstraints = [NSLayoutConstraint]()

        //        let titleLabelXConstraints = [NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)]
        //        allConstraints += titleLabelXConstraints

        let titleLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[titleLabel]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += titleLabelXConstraints


        let titleLabelYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[titleLabel]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += titleLabelYConstraints

        //        let mainYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
        //            "V:|-[titleLabel]-|",
        //            options: [],
        //            metrics: nil,
        //            views: views)
        //        allConstraints += mainYConstraints

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
}
