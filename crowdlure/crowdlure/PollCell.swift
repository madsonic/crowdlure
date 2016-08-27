//
//  PollCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class PollCell: UITableViewCell {

    // MARK: Data
    var bizName: String
    var question: String
    var choiceCount: Int
    var answerCount: Int

    // MARK: UI elements
    let containerView = UIView(frame: CGRectZero)
    let bizNameLabel = UILabel()
    let questionLabel = UILabel()
    let choiceCountLabel = UILabel()
    let answerCountLabel = UILabel()

    init(bizName: String, question: String, choiceCount: Int = 0, answerCount: Int = 0) {
        self.bizName = bizName
        self.question = question
        self.choiceCount = choiceCount
        self.answerCount = answerCount
        super.init(style: .Default, reuseIdentifier: "PollCell")
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = UIColor.clearColor()

        self.containerView.backgroundColor = UIColor.whiteColor()
        self.containerView.translatesAutoresizingMaskIntoConstraints = false

        self.bizNameLabel.text = "\(self.bizName) asks"
        self.bizNameLabel.font = UIFont.italicSystemFontOfSize(15)
        self.bizNameLabel.translatesAutoresizingMaskIntoConstraints = false

        self.questionLabel.text = self.question
        self.questionLabel.numberOfLines = 0
        self.questionLabel.textColor = UIColor.redColor()
        self.questionLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false

        self.choiceCountLabel.text = "\(self.choiceCount) Choices"
        self.choiceCountLabel.font = UIFont.systemFontOfSize(14)
        self.choiceCountLabel.translatesAutoresizingMaskIntoConstraints = false

        self.answerCountLabel.text = "\(self.answerCount) Answered"
        self.answerCountLabel.font = UIFont.systemFontOfSize(14)
        self.answerCountLabel.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.bizNameLabel)
        self.containerView.addSubview(self.questionLabel)
        self.containerView.addSubview(self.choiceCountLabel)
        self.containerView.addSubview(self.answerCountLabel)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "containerView": self.containerView,
            "bizNameLabel": self.bizNameLabel,
            "questionLabel": self.questionLabel,
            "choiceCountLabel": self.choiceCountLabel,
            "answerCountLabel": self.answerCountLabel
        ]

        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getConstraintFromFormat("H:|-[containerView]-|", views: views)
        allConstraints += getConstraintFromFormat("V:|[containerView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[bizNameLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[questionLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[choiceCountLabel]-[answerCountLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("V:|-[bizNameLabel(14)]-[questionLabel]-[choiceCountLabel(12)]-|", views: views)
        allConstraints += getConstraintFromFormat("V:|-[bizNameLabel(14)]-[questionLabel]-[answerCountLabel(12)]-|", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

}
