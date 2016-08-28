//
//  PollChoiceView.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class PollChoice {
    
    var choiceText: String
    var nReplies: Int
    var choiceIndex: Int
    
    let mainView = UIView()
    let choiceLabel = UILabel()
    let answeredLabel = UILabel()
    let voteButton = UIButton()
    
    init(choiceText: String, nReplies: Int, choiceIndex: Int) {
        self.choiceText = choiceText
        self.nReplies = nReplies
        self.choiceIndex = choiceIndex
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.choiceLabel.text = self.choiceText
        self.choiceLabel.font = UIFont.systemFontOfSize(13)
        self.choiceLabel.textColor = UIColor.faintGrayColor()
        self.choiceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.answeredLabel.text = "\(self.nReplies)"
        self.answeredLabel.font = UIFont.systemFontOfSize(13)
        self.answeredLabel.textColor = UIColor.faintGrayColor()
        self.answeredLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.voteButton.setTitle("VOTE", forState: .Normal)
        self.voteButton.layer.cornerRadius = 15
        self.voteButton.titleLabel?.font = UIFont.boldSystemFontOfSize(12)
        switch (self.choiceIndex % 3) {
        case 0:
            self.voteButton.backgroundColor = UIColor.pastelPurpleColor()
        case 1:
            self.voteButton.backgroundColor = UIColor.pastelRedColor()
        case 2:
            self.voteButton.backgroundColor = UIColor.pastelYellowColor()
        default:
            break
        }
        self.voteButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainView.addSubview(self.choiceLabel)
        self.mainView.addSubview(self.answeredLabel)
        self.mainView.addSubview(self.voteButton)
        
        setupLayoutConstraints()
    }
    
    func setupLayoutConstraints() {
        let views = [
            "choiceLabel": self.choiceLabel,
            "answeredLabel": self.answeredLabel,
            "voteButton": self.voteButton
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getConstraintFromFormat("H:|-[choiceLabel]-[voteButton(60)]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[answeredLabel]-[voteButton(60)]-|", views: views)
        allConstraints += getConstraintFromFormat("V:|-5-[voteButton(30)]", views: views)
        allConstraints += getConstraintFromFormat("V:|-5-[choiceLabel(15)][answeredLabel(15)]-5-|", views: views)
        
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
}