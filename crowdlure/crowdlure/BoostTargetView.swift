//
//  File.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class BoostTargetView: UIView {
    
    let indexLabel = UILabel()
    let descLabel = UILabel()
    
    var desc: String
    var index: Int
    
    init(description: String, index: Int) {
        self.desc = description
        self.index = index
        super.init(frame: CGRectZero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        self.indexLabel.text = "\(self.index + 1)"
        self.indexLabel.backgroundColor = UIColor.pastelTealColor()
        self.indexLabel.textColor = UIColor.whiteColor()
        self.indexLabel.layer.cornerRadius = 10
        self.indexLabel.layer.masksToBounds = true
        self.indexLabel.textAlignment = .Center
        self.indexLabel.translatesAutoresizingMaskIntoConstraints = false

        self.descLabel.text = self.desc
        self.descLabel.font = UIFont.systemFontOfSize(14)
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.indexLabel)
        self.addSubview(self.descLabel)
        
        setupLayoutConstraints()
    }
    
    func setupLayoutConstraints() {
        let views = [
            "indexLabel": self.indexLabel,
            "descLabel": self.descLabel
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getConstraintFromFormat("V:|-5-[indexLabel(20)]-5-|", views: views)
        allConstraints += getConstraintFromFormat("V:|-5-[descLabel]-5-|", views: views)
        allConstraints += getConstraintFromFormat("H:|[indexLabel(20)]-[descLabel]|", views: views)
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
}
