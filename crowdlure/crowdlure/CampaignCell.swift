//
//  CampaignCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class CampaignCell: UITableViewCell {
    static let identifier = "CampaignCell"
    // data
    var merchantName: String
    var merchantLocation: String?
    var totalParticipants: Int
    var participantsForEachTarget: [Int]
    var price: Double

    // ui
    var containerView = UIView(frame: CGRectZero)

    var merchantContainerView = UIView(frame: CGRectZero)
    var merchantInfoStackView = UIStackView()
    var merchantStackView = UIStackView()

    var merchantInitialsLabel = UILabel()
    var merchantNameLabel = UILabel()
    var merchantLocationLabel = UILabel()

    var merchantImageView = UIImageView(frame: CGRectZero)

    var boostDetailsContainerView = UIView(frame: CGRectZero)

    var boostPercentageLabel = UILabel()

    var participantIcon = UIImageView(frame: CGRectZero)
    var totalParticipantNumberLabel = UILabel()

    var clockIcon = UIImageView(frame: CGRectZero)
    var remainingTimeLabel = UILabel()

//    // to find out how to implement
    var progressBar = UIView(frame: CGRectZero)
    var progressLabels = UILabel()
//
//    var priceLabel = UILabel()
//    var boostButton = UIButton()
//
//    // subclass this
//    var firstTarget = UIView(frame: CGRectZero)
//    var targetLabel = UILabel()
//    var targetDescriptionLabel = UILabel()
//    var targetParticipantsView = UIView() // subclass this decorated label
//
//    var moreButton = UIButton()

    init(merchantName: String, merchantLocation: String? = nil, totalParticipants: Int = 0, participantsForEachTarget: [Int] = [0, 0, 0], price: Double) {

        print("campaign cell init")

        self.merchantName = merchantName
        self.merchantLocation = merchantLocation
        self.totalParticipants = totalParticipants
        self.participantsForEachTarget = participantsForEachTarget
        self.price = price

        super.init(style: .Default, reuseIdentifier: CampaignCell.identifier)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        print("setting up campaign cell ui")
        containerView.backgroundColor = .whiteColor()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        merchantContainerView.backgroundColor = .greenColor()
        merchantContainerView.translatesAutoresizingMaskIntoConstraints = false

        merchantStackView.axis = .Horizontal
        merchantStackView.addArrangedSubview(merchantInitialsLabel)
        merchantStackView.addArrangedSubview(merchantInfoStackView)
        merchantStackView.translatesAutoresizingMaskIntoConstraints = false

        merchantInfoStackView.axis = .Vertical
        merchantInfoStackView.distribution = .FillProportionally
        merchantInfoStackView.alignment = .Leading
        merchantInfoStackView.spacing = 5
        merchantInfoStackView.addArrangedSubview(merchantNameLabel)
        merchantInfoStackView.addArrangedSubview(merchantLocationLabel)
        merchantInfoStackView.translatesAutoresizingMaskIntoConstraints = false

        merchantNameLabel.text = "kajnwdnawd"
        merchantNameLabel.backgroundColor = .redColor()
        merchantNameLabel.translatesAutoresizingMaskIntoConstraints = false

        merchantLocationLabel.text = "akwuhdajwkd"
        merchantLocationLabel.backgroundColor = .cyanColor()
        merchantLocationLabel.translatesAutoresizingMaskIntoConstraints = false

        merchantInitialsLabel.text = "Aalkwjd"
        merchantInitialsLabel.backgroundColor = .blueColor()
        merchantInitialsLabel.translatesAutoresizingMaskIntoConstraints = false

        merchantImageView.image = UIImage(named: "club.jpg")
        merchantImageView.contentMode = .ScaleAspectFit
        merchantImageView.translatesAutoresizingMaskIntoConstraints = false

        boostDetailsContainerView.backgroundColor = .blueColor()
        boostDetailsContainerView.translatesAutoresizingMaskIntoConstraints = false

        boostPercentageLabel.text = "114% boosted"
        boostPercentageLabel.translatesAutoresizingMaskIntoConstraints = false

        totalParticipantNumberLabel.text = "160"
        totalParticipantNumberLabel.translatesAutoresizingMaskIntoConstraints = false

        remainingTimeLabel.text = "3 Hours"
        remainingTimeLabel.translatesAutoresizingMaskIntoConstraints = false

        progressBar.backgroundColor = .redColor()
        progressBar.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(containerView)

        containerView.addSubview(merchantContainerView)
        merchantContainerView.addSubview(merchantStackView)

        containerView.addSubview(merchantImageView)

        containerView.addSubview(boostDetailsContainerView)
        boostDetailsContainerView.addSubview(boostPercentageLabel)
        boostDetailsContainerView.addSubview(totalParticipantNumberLabel)
        boostDetailsContainerView.addSubview(remainingTimeLabel)
        boostDetailsContainerView.addSubview(progressBar)


//        containerView.addSubview(merchantImageView)
//
//        containerView.addSubview(totalParticipantsView)
//        containerView.addSubview(participantIcon)
//        containerView.addSubview(targetDescriptionLabel)
//
//        containerView.addSubview(remainingTimeView)
//        containerView.addSubview(clockIcon)
//        containerView.addSubview(remainingTimeLabel)
//
//        containerView.addSubview(progressBar)
//        containerView.addSubview(progressLabels)
//
//        containerView.addSubview(priceLabel)
//        containerView.addSubview(boostButton)
//
//        containerView.addSubview(firstTarget)
//        containerView.addSubview(targetLabel)
//        containerView.addSubview(targetDescriptionLabel)
//        containerView.addSubview(targetParticipantsView)
//        
//        containerView.addSubview(moreButton)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {

        var allConstraints = [NSLayoutConstraint]()

        let views = [
            "containerView": containerView,
            "merchantContainerView": merchantContainerView,
            "merchantStackView": merchantStackView,
            "merchantInfoStackView": merchantInfoStackView,
            "merchantInitialsLabel": merchantInitialsLabel,
            "merchantNameLabel": merchantNameLabel,
            "merchantLocationLabel": merchantLocationLabel,
            "merchantImageView": merchantImageView,
            "boostDetailsContainerView": boostDetailsContainerView,
            "boostPercentageLabel": boostPercentageLabel,
            "participantIcon": participantIcon,
            "totalParticipantNumberLabel": totalParticipantNumberLabel,
            "clockIcon": clockIcon,
            "remainingTimeLabel": remainingTimeLabel,
            "progressBar": progressBar,
//            "progressLabels": progressLabels,
//            "priceLabel": priceLabel,
//            "boostButton": boostButton,
//            "firstTarget": firstTarget,
//            "targetLabel": targetLabel,
//            "targetDescriptionLabel": targetDescriptionLabel,
//            "targetParticipantsView": targetParticipantsView
        ]

        let containerViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[containerView]|",
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

        let contentYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[merchantContainerView(50)][merchantImageView][boostDetailsContainerView(150)]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: views)
        allConstraints += contentYConstraints

        let merchantContainerXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[merchantContainerView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += merchantContainerXConstraints

        let merchantStackViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[merchantStackView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += merchantStackViewXConstraints

        let merchantStackViewYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[merchantStackView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += merchantStackViewYConstraints

        let merchantInfoStackViewYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[merchantInfoStackView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += merchantInfoStackViewYConstraints

        let boostDetailsContainerViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[boostDetailsContainerView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += boostDetailsContainerViewXConstraints

        let boostDetailsSummaryLabelsXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[boostPercentageLabel]-(>=70)-[totalParticipantNumberLabel]-(5)-[remainingTimeLabel]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += boostDetailsSummaryLabelsXConstraints

        let boostPercentageLabelYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[boostPercentageLabel]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += boostPercentageLabelYConstraints

        let totalParticipantLabelYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[totalParticipantNumberLabel]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += totalParticipantLabelYConstraints

        let timeRemainingLabelYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[remainingTimeLabel]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += timeRemainingLabelYConstraints

        let progressBarYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(30)-[progressBar(10)]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += progressBarYConstraints

        let progressBarXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[progressBar]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += progressBarXConstraints

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

}
