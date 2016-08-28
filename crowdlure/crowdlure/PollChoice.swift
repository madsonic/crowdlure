//
//  PollChoiceView.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PollChoice {
    
    var choiceText: String
    var nReplies: Int
    var choiceIndex: Int
    var choiceID: Int
    var pollID: Int
    
    let mainView = UIView()
    let choiceLabel = UILabel()
    let answeredLabel = UILabel()
    let voteButton = UIButton()

    init(choiceText: String, nReplies: Int, choiceIndex: Int, choiceID: Int, pollID: Int) {
        self.choiceText = choiceText
        self.nReplies = nReplies
        self.choiceIndex = choiceIndex
        self.choiceID = choiceID
        self.pollID = pollID
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.choiceLabel.text = self.choiceText
        self.choiceLabel.font = UIFont.cairoRegularFont(13)
        self.choiceLabel.textColor = UIColor.faintGrayColor()
        self.choiceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.answeredLabel.text = "\(self.nReplies)"
        self.answeredLabel.font = UIFont.cairoBoldFont(13)
        self.answeredLabel.textColor = UIColor.faintGrayColor()
        self.answeredLabel.translatesAutoresizingMaskIntoConstraints = false
        

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
        self.voteButton.setTitle("VOTE", forState: .Normal)
        self.voteButton.setTitleColor(voteButton.backgroundColor, forState: .Highlighted)
        self.voteButton.setTitleColor(voteButton.backgroundColor, forState: .Disabled)
        self.voteButton.layer.cornerRadius = 15
        self.voteButton.titleLabel?.font = UIFont.cairoBoldFont(12)
        self.voteButton.addTarget(self, action: #selector(vote), forControlEvents: .TouchUpInside)
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

    @objc
    func vote(sender: UIButton) {
        let submitRequest = request(Endpoint.submitChoiceForPoll(pollID: pollID, choiceID: choiceID))
        sender.enabled = false
        submitRequest.responseJSON(successHandler: { rawResp in
            let resp = JSON(rawResp)
            dispatch_async(dispatch_get_main_queue()) {
                self.nReplies = resp["poll"]["choices"][self.choiceIndex]["count"].intValue
                self.answeredLabel.text = String(self.nReplies)
            }
        }, failureHandler: { error in
            print(error)
            sender.enabled = true
        })
    }
    
}