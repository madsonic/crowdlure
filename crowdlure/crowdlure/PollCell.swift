//
//  PollCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import SwiftyJSON

class PollCell: UITableViewCell {

    // MARK: Data
    var dataProvider: PollCellDataProvider

    // MARK: UI elements
    let containerView = UIView(frame: CGRectZero)
    let bgView = UIImageView()
    let questionLabel = UILabel()
    
    var choices: [PollChoice]
    
    let dateLeftLabel = UILabel()

    init(poll: JSON) {
        self.dataProvider = PollCellDataProvider(poll: poll)

        self.choices = [PollChoice]()

        for i in 0..<dataProvider.choices.count {
            let choice = PollChoice(choiceText: dataProvider.choicesTexts[i],
                                    nReplies: dataProvider.choicesVotes[i],
                                    choiceIndex: i,
                                    choiceID: dataProvider.choiceID[i],
                                    pollID: dataProvider.pollID)
            self.choices.append(choice)
        }

        super.init(style: .Default, reuseIdentifier: "PollCell")

        selectionStyle = .None
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
        
        self.questionLabel.text = self.dataProvider.question
        self.questionLabel.numberOfLines = 0
        self.questionLabel.textColor = UIColor.faintGrayColor()
        self.questionLabel.font = UIFont.cairoRegularFont(15)
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.dateLeftLabel.text = "1 day left"
        self.dateLeftLabel.font = UIFont.cairoRegularFont(10)
        self.dateLeftLabel.textColor = UIColor.faintGrayColor()
        self.dateLeftLabel.textAlignment = .Right
        self.dateLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.addSubview(self.questionLabel)
        self.containerView.addSubview(self.dateLeftLabel)
        for i in 0..<choices.count {
            self.containerView.addSubview(self.choices[i].mainView)
        }
        self.contentView.addSubview(self.bgView)
        self.contentView.addSubview(self.containerView)
        
        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        var views = [
            "containerView": self.containerView,
            "bgView": self.bgView,
            "dateLeftLabel": self.dateLeftLabel,
            "questionLabel": self.questionLabel,
            "choice1": self.choices[0].mainView,
            "choice2": self.choices[1].mainView,
            "choice3": self.choices[2].mainView
        ]

        for i in 0..<choices.count {
            views["choice\(i)"] = choices[i].mainView
        }

        var allConstraints = [NSLayoutConstraint]()
        
        var choicesGrp = ""
        for i in 0..<choices.count {
            allConstraints += getConstraintFromFormat("H:|-20-[choice\(i)]-20-|", views: views)
            var choiceStr = "[choice"
            choiceStr += String(i)
            choiceStr += "(40)]"
            choicesGrp += choiceStr
        }

        allConstraints += getConstraintFromFormat("H:|[containerView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[containerView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[bgView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[bgView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|-10-[questionLabel]-6-\(choicesGrp)-12-[dateLeftLabel(10)]", views: views)
        allConstraints += getConstraintFromFormat("H:|-30-[questionLabel]-30-|", views: views)
        allConstraints += getConstraintFromFormat("H:[dateLeftLabel]-30-|", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
}