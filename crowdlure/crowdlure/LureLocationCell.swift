//
//  LureLocationCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import MapKit

class LureLocationCell: UITableViewCell {

    let containerView = UIView()
    let mapView = MKMapView()
    let locationTitleLabel = UILabel()
    let locationAddrLabel = UILabel()
    let locationDistLabel = UILabel()

    init() {
        super.init(style: .Default, reuseIdentifier: "LureLocationCell")
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = UIColor.clearColor()

        self.containerView.backgroundColor = UIColor.whiteColor()
        self.containerView.translatesAutoresizingMaskIntoConstraints = false

        self.mapView.translatesAutoresizingMaskIntoConstraints = false

        self.locationTitleLabel.text = "Lake Tahoe"
        self.locationTitleLabel.font = UIFont.boldSystemFontOfSize(16)
        self.locationTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.locationAddrLabel.text = "GOD KNOWS WHERE, CA 93203"
        self.locationAddrLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        self.locationAddrLabel.translatesAutoresizingMaskIntoConstraints = false

        self.locationDistLabel.text = "10 KM"
        self.locationDistLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        self.locationDistLabel.translatesAutoresizingMaskIntoConstraints = false

        self.containerView.addSubview(self.mapView)
        self.containerView.addSubview(self.locationTitleLabel)
        self.containerView.addSubview(self.locationAddrLabel)
        self.containerView.addSubview(self.locationDistLabel)

        self.contentView.addSubview(self.containerView)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "containerView": self.containerView,
            "mapView": self.mapView,
            "locationTitleLabel": self.locationTitleLabel,
            "locationAddrLabel": self.locationAddrLabel,
            "locationDistLabel": self.locationDistLabel
        ]

        var allConstraints = [NSLayoutConstraint]()

        let mapViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[mapView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += mapViewXConstraints

        let locationTitleLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[locationTitleLabel]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += locationTitleLabelXConstraints

        let locationAddrLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[locationAddrLabel]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += locationAddrLabelXConstraints

        let locationDistLabelXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[locationDistLabel]-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += locationDistLabelXConstraints

        let mainYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[mapView(180)]-[locationTitleLabel]-[locationAddrLabel]-[locationDistLabel]-|",
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
            "V:|[containerView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += containerViewYConstraints

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

}