//
//  TargetRewardView.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

enum TargetStates: Int {
    case Completed, InProgress, NextUp
}

class TargetRewardView: UIView {
    var targetNumber: Int
    var rewardDescription: String
    var currentParticipants: Int
    var totalParticipants: Int
    var targetState: TargetStates
    let alphaMask: CGFloat = 0.5

    var rewardStackView = UIStackView()
    var rewardInfoStackView = UIStackView()
    var targetNumberLabel = UILabel()
    var rewardDescriptionLabel = UILabel()
    var participantStackView = UIStackView()
    var personIcon = UIImageView()
    var participantsLabel = UILabel()

    init(frame: CGRect = CGRectZero, targetState: TargetStates, targetNumber: Int, rewardDescription: String, currentParticipants: Int, totalParticipants: Int) {
        self.targetNumber = targetNumber
        self.rewardDescription = rewardDescription
        self.currentParticipants = currentParticipants
        self.totalParticipants = totalParticipants
        self.targetState = targetState
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        backgroundColor = .deepGrayColor()

        rewardStackView.axis = .Horizontal
        rewardStackView.spacing = 10
        rewardStackView.addArrangedSubview(targetNumberLabel)
        rewardStackView.addArrangedSubview(rewardInfoStackView)
        rewardStackView.translatesAutoresizingMaskIntoConstraints = false

        targetNumberLabel.text = String(targetNumber)
        targetNumberLabel.font = UIFont.cairoRegularFont(30)
        targetNumberLabel.textColor = .whiteColor()
        targetNumberLabel.translatesAutoresizingMaskIntoConstraints = false

        rewardInfoStackView.axis = .Vertical
        rewardInfoStackView.distribution = .FillProportionally
        rewardInfoStackView.alignment = .Leading
        rewardInfoStackView.addArrangedSubview(rewardDescriptionLabel)
        rewardInfoStackView.addArrangedSubview(participantStackView)
        rewardInfoStackView.translatesAutoresizingMaskIntoConstraints = false

        rewardDescriptionLabel.text = rewardDescription
        rewardDescriptionLabel.textColor = .wordColor()
        rewardDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        participantStackView.axis = .Horizontal
//        participantStackView.addArrangedSubview(participantsLabel) // add icon
        participantStackView.addArrangedSubview(participantsLabel)
        participantStackView.translatesAutoresizingMaskIntoConstraints = false

        participantsLabel.text = "\(currentParticipants)/\(totalParticipants)"
        participantsLabel.font = UIFont.cairoRegularFont(10)
        participantsLabel.textColor = .skyBlueColor()
        participantsLabel.translatesAutoresizingMaskIntoConstraints = false

        var targetBackgroundColor: UIColor

        if targetState == TargetStates.InProgress {
            targetBackgroundColor = .pastelTealColor()
            targetNumberLabel.backgroundColor = targetBackgroundColor
        } else if targetState == TargetStates.NextUp {
            targetBackgroundColor = .mediumGrayColor()
            targetNumberLabel.backgroundColor = targetBackgroundColor
        } else if targetState == TargetStates.Completed {
            targetBackgroundColor = .mediumGrayColor()
            rewardStackView.tintColor = UIColor.clearColor().colorWithAlphaComponent(alphaMask)
        }

        addSubview(rewardStackView)

//        setupConstraints()
    }

    func setupConstraints() {
        var allConstraints = [NSLayoutConstraint]()
        let views = ["rewardStackView": rewardStackView,
                     "rewardInfoStackView": rewardInfoStackView,
                     "targetNumberLabel": targetNumberLabel,
                     "rewardDescription": rewardDescription,
                     "participantStackView": participantStackView]

//        NSLayoutConstraint.activateConstraints(allConstraints)
    }
}