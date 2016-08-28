//
//  PollCell.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol PollCellDelegate: class {
    func dismissCell(cell: UITableViewCell)
}

class PollCell: UITableViewCell, DataProviderDelegate {

    weak var delegate: PollCellDelegate?
    
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

        super.init(style: .Default, reuseIdentifier: "PollCell")
        self.dataProvider.delegate = self
        
        for i in 0..<self.dataProvider.choices.count {
            let c = PollChoice(pollMaster: self, choiceText: self.dataProvider.choicesTexts[i], nReplies: self.dataProvider.choicesVotes[i], choiceIndex: i, choiceID: self.dataProvider.choiceID[i], pollID: self.dataProvider.pollID)
            self.choices.append(c)
        }
        
        selectionStyle = .None
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = UIColor.clearColor()
        
        self.bgView.image = UIImage(named: "placeholder.png")
        self.bgView.translatesAutoresizingMaskIntoConstraints = false
        self.bgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.bgView.clipsToBounds = true
        
        self.containerView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.questionLabel.text = self.dataProvider.question
        self.questionLabel.numberOfLines = 0
        self.questionLabel.textColor = UIColor.faintGrayColor()
        self.questionLabel.font = UIFont.cairoRegularFont(15)
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.dateLeftLabel.text = "Valid Till \(self.dataProvider.endDate)"
        self.dateLeftLabel.font = UIFont.cairoRegularFont(10)
        self.dateLeftLabel.textColor = UIColor.faintGrayColor()
        self.dateLeftLabel.textAlignment = .Right
        self.dateLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.addSubview(self.questionLabel)
        self.containerView.addSubview(self.dateLeftLabel)
        for i in 0..<self.choices.count {
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
            "questionLabel": self.questionLabel
        ]

        for i in 0..<self.choices.count {
            views["choice\(i)"] = self.choices[i].mainView
        }

        var allConstraints = [NSLayoutConstraint]()
        
        var choicesGrp = ""
        for i in 0..<self.choices.count {
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
        allConstraints += getConstraintFromFormat("V:|-10-[questionLabel]-6-\(choicesGrp)-12-[dateLeftLabel(14)]", views: views)
        allConstraints += getConstraintFromFormat("H:|-30-[questionLabel]-30-|", views: views)
        allConstraints += getConstraintFromFormat("H:[dateLeftLabel]-30-|", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    func dataUpdated() {
        if let data = self.dataProvider.pollImgData {
            self.bgView.image = UIImage(data: data)
        }
    }
    
    func dismissPoll() {
        self.delegate?.dismissCell(self)
    }
}