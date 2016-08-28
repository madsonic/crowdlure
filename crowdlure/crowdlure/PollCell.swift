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
    let bgView = UIImageView()
    let headerView = UIView()
    let bizNameLabel = UILabel()
    let bizLocationLabel = UILabel()
    let questionLabel = UILabel()
    
    var choices: [PollChoice]
    
    let dateLeftLabel = UILabel()

    let choiceData = [
        ["Get laid", 12],
        ["Suffocate", 13],
        ["Sleep", 23]
    ]
    
    init(bizName: String, question: String, choiceCount: Int = 0, answerCount: Int = 0) {
        self.bizName = bizName
        self.question = question
        self.choiceCount = choiceCount
        self.answerCount = answerCount
        
        self.choices = [PollChoice]()
        var i = 0
        for c in self.choiceData {
            self.choices.append(PollChoice(choiceText: c[0] as! String, nReplies: c[1] as! Int, choiceIndex: i))
            i += 1
        }
        
        super.init(style: .Default, reuseIdentifier: "PollCell")
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = UIColor.clearColor()
        
        self.bgView.image = UIImage(named: "club.jpg")
        self.bgView.translatesAutoresizingMaskIntoConstraints = false
        self.bgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.bgView.clipsToBounds = true
        
        self.containerView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.9)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerView.backgroundColor = UIColor.deepGrayColor()
        self.headerView.translatesAutoresizingMaskIntoConstraints = false

        self.bizNameLabel.text = "\(self.bizName) asks"
        self.bizNameLabel.font = UIFont.cairoRegularFont(13)
        self.bizNameLabel.textColor = UIColor.whiteColor()
        self.bizNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.bizLocationLabel.text = "\(self.bizName) asks"
        self.bizLocationLabel.font = UIFont.cairoRegularFont(13)
        self.bizLocationLabel.textColor = UIColor.pastelYellowColor()
        self.bizLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.questionLabel.text = self.question
        self.questionLabel.numberOfLines = 0
        self.questionLabel.textColor = UIColor.faintGrayColor()
        self.questionLabel.font = UIFont.cairoRegularFont(15)
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.dateLeftLabel.text = "1 day left"
        self.dateLeftLabel.font = UIFont.cairoRegularFont(10)
        self.dateLeftLabel.textColor = UIColor.faintGrayColor()
        self.dateLeftLabel.textAlignment = .Right
        self.dateLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        

        self.headerView.addSubview(self.bizNameLabel)
        self.headerView.addSubview(self.bizLocationLabel)
        self.containerView.addSubview(self.headerView)
        self.containerView.addSubview(self.questionLabel)
        self.containerView.addSubview(self.dateLeftLabel)
        self.containerView.addSubview(self.choices[0].mainView)
        self.containerView.addSubview(self.choices[1].mainView)
        self.containerView.addSubview(self.choices[2].mainView)

        self.contentView.addSubview(self.bgView)
        self.contentView.addSubview(self.containerView)
        
        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "containerView": self.containerView,
            "bgView": self.bgView,
            "headerView": self.headerView,
            "bizNameLabel": self.bizNameLabel,
            "bizLocationLabel": self.bizLocationLabel,
            "dateLeftLabel": self.dateLeftLabel,
            "questionLabel": self.questionLabel,
            "choice1": self.choices[0].mainView,
            "choice2": self.choices[1].mainView,
            "choice3": self.choices[2].mainView
        ]

        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getConstraintFromFormat("H:|[containerView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[containerView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[bgView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[bgView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[headerView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[headerView(54)]-12-[questionLabel]-6-[choice1(40)][choice2(40)][choice3(40)]-12-[dateLeftLabel(10)]", views: views)
        allConstraints += getConstraintFromFormat("H:|-30-[questionLabel]-30-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-20-[bizNameLabel]-20-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-20-[bizLocationLabel]-20-|", views: views)
        allConstraints += getConstraintFromFormat("V:|-4-[bizNameLabel(22)]-2-[bizLocationLabel(22)]-4-|", views: views)
        allConstraints += getConstraintFromFormat("H:[dateLeftLabel]-30-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-20-[choice1]-20-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-20-[choice2]-20-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-20-[choice3]-20-|", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

}
