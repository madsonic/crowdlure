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

    var priceBoostStackView = UIStackView()
    var priceLabel = UILabel()
    var boostButton = UIButton()

    var targetStackView = UIStackView()
    var targetDetailsStackView = UIStackView()
    // subclass this
    var targetLabel = UILabel()
    var targetDescriptionLabel = UILabel()
    var targetParticipantsLabel = UILabel() // subclass this decorated label

    init(merchantName: String, merchantLocation: String? = nil, totalParticipants: Int = 0, participantsForEachTarget: [Int] = [0, 0, 0], price: Double) {

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

        merchantImageView.image = UIImage(named: "placeholder.png")
        merchantImageView.contentMode = .ScaleAspectFit
        merchantImageView.translatesAutoresizingMaskIntoConstraints = false

        boostDetailsContainerView.translatesAutoresizingMaskIntoConstraints = false

        boostPercentageLabel.text = "114% boosted"
        boostPercentageLabel.textColor = .wordColor()
        boostPercentageLabel.translatesAutoresizingMaskIntoConstraints = false

        totalParticipantNumberLabel.text = "160"
        totalParticipantNumberLabel.textColor = .faintGrayColor()
        totalParticipantNumberLabel.translatesAutoresizingMaskIntoConstraints = false

        remainingTimeLabel.text = "3 Hours"
        remainingTimeLabel.textColor = .faintGrayColor()
        remainingTimeLabel.translatesAutoresizingMaskIntoConstraints = false

        progressBar.backgroundColor = .redColor()
        progressBar.translatesAutoresizingMaskIntoConstraints = false

        priceBoostStackView.axis = .Vertical
        priceBoostStackView.distribution = .FillProportionally
        priceBoostStackView.spacing = 10
        priceBoostStackView.addArrangedSubview(priceLabel)
        priceBoostStackView.addArrangedSubview(boostButton)
        priceBoostStackView.translatesAutoresizingMaskIntoConstraints = false

        priceLabel.text = "$25"
        priceLabel.textColor = .wordColor()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        boostButton.setTitle("BOOST", forState: .Normal)
        boostButton.setTitleColor(.blackColor(), forState: .Normal)
        boostButton.translatesAutoresizingMaskIntoConstraints = false

        targetStackView.axis = .Horizontal
        targetStackView.distribution = .FillProportionally
        targetStackView.spacing = 10
        targetStackView.addArrangedSubview(targetLabel)
        targetStackView.addArrangedSubview(targetDetailsStackView)
        targetStackView.translatesAutoresizingMaskIntoConstraints = false

        targetDetailsStackView.axis = .Vertical
        targetDetailsStackView.distribution = .FillProportionally
        targetDetailsStackView.alignment = .Leading
        targetDetailsStackView.addArrangedSubview(targetDescriptionLabel)
        targetDetailsStackView.addArrangedSubview(targetParticipantsLabel)
        targetDetailsStackView.translatesAutoresizingMaskIntoConstraints = false

        targetLabel.text = "1"
        targetLabel.translatesAutoresizingMaskIntoConstraints = false

        targetDescriptionLabel.text = "Get your second chili crab at 20% off"
        targetDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        targetParticipantsLabel.text = "10/100"
        targetParticipantsLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(containerView)

        containerView.addSubview(merchantImageView)

        containerView.addSubview(boostDetailsContainerView)
        boostDetailsContainerView.addSubview(boostPercentageLabel)
        boostDetailsContainerView.addSubview(totalParticipantNumberLabel)
        boostDetailsContainerView.addSubview(remainingTimeLabel)
        boostDetailsContainerView.addSubview(progressBar)
        boostDetailsContainerView.addSubview(priceBoostStackView)
        boostDetailsContainerView.addSubview(targetStackView)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {

        var allConstraints = [NSLayoutConstraint]()

        let views = [
            "containerView": containerView,
            "merchantImageView": merchantImageView,
            "boostDetailsContainerView": boostDetailsContainerView,
            "boostPercentageLabel": boostPercentageLabel,
            "participantIcon": participantIcon,
            "totalParticipantNumberLabel": totalParticipantNumberLabel,
            "clockIcon": clockIcon,
            "remainingTimeLabel": remainingTimeLabel,
            "progressBar": progressBar,
//            "progressLabels": progressLabels,
            "priceBoostStackView": priceBoostStackView,
            "priceLabel": priceLabel,
            "boostButton": boostButton,
            "targetStackView": targetStackView,
            "targetDetailsStackView": targetDetailsStackView,
            "targetLabel": targetLabel,
            "targetDescriptionLabel": targetDescriptionLabel,
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
            "V:|[merchantImageView][boostDetailsContainerView(200)]|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: views)
        allConstraints += contentYConstraints

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

        let boostDetailsYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[boostPercentageLabel]-(10)-[progressBar(10)]-(15)-[priceLabel]-(10)-[boostButton]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += boostDetailsYConstraints

        let priceBoostStackViewConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[progressBar]-10-[priceBoostStackView]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += priceBoostStackViewConstraints

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

        let progressBarXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[progressBar]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += progressBarXConstraints

        let targetStackViewYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[progressBar]-20-[targetStackView]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += targetStackViewYConstraints

        let targetStackViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[targetStackView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += targetStackViewXConstraints

        let boostDetailsContainerXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[priceBoostStackView]-(>=10)-[targetStackView]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += boostDetailsContainerXConstraints

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
}