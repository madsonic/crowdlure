//
//  LureAttributeCell.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class LureAttributeCell: UITableViewCell {
    
    let attributeNameLabel = UILabel()
    let attributeValueLabel = UILabel()
    
    var key: String
    var val: String
    
    init(key: String?, val: String?) {
        self.key = key ?? ""
        self.val = val ?? ""
        super.init(style: .Default, reuseIdentifier: "LureDetailCell")
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        self.attributeNameLabel.text = self.key
        self.attributeNameLabel.font = UIFont.cairoRegularFont(15)
        self.attributeNameLabel.textColor = UIColor.darkGrayColor()
        self.attributeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.attributeValueLabel.text = self.val
        self.attributeValueLabel.font = UIFont.cairoRegularFont(15)
        self.attributeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.attributeNameLabel)
        self.contentView.addSubview(self.attributeValueLabel)
        
        setupLayoutConstraints()
    }
    
    func setupLayoutConstraints() {
        let views = [
            "attributeNameLabel": self.attributeNameLabel,
            "attributeValueLabel": self.attributeValueLabel
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getConstraintFromFormat("V:|[attributeNameLabel]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[attributeValueLabel]|", views: views)
        allConstraints += getConstraintFromFormat("H:|-40-[attributeNameLabel(80)]-20-[attributeValueLabel]-40-|", views: views)
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
}













