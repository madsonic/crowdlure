//
//  PurchaseDetailViewController.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import SwiftyJSON

class PurchaseDetailViewController: UIViewController, ACTabScrollViewDelegate, ACTabScrollViewDataSource, DataProviderDelegate {

    let purchaseDetailHeaderView = UIView()
    let headerBgView = UIImageView()
    let headerOverlayBgView = UIView()
    let bizProfileView = UIView()
    let bizImageView = UIImageView()
    let bizNameLabel = UILabel()
    let productLabel = UILabel()
    let incentiveLabel = UILabel()
    
    let purchaseDetailTabScrollView = ACTabScrollView()
    
    let ticketView = UIView()
    let qrCodeImageView = UIImageView()
    var qrCodeImage: CIImage?
    
    var detailVC: LureTableViewController
    
    var dataProvider: LureDataProvider

    init(lure: JSON) {
        self.detailVC = LureTableViewController(lure: lure)
        self.dataProvider = LureDataProvider(lure: lure)
        super.init(nibName: nil, bundle: nil)
        self.dataProvider.delegate = self
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor.whiteColor()
        setupUI()
    }
    
    func dataUpdated() {
        if let bizLogoData = self.dataProvider.bizLogoData {
            self.bizImageView.image = UIImage(data: bizLogoData)
        }
        
        if let imgData = self.dataProvider.imgData {
            self.headerBgView.image = UIImage(data: imgData)
        }
    }
    
    func setupUI() {
        
        // Header
        self.purchaseDetailHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerBgView.image = UIImage()
        self.headerBgView.translatesAutoresizingMaskIntoConstraints = false
        self.headerBgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.headerBgView.clipsToBounds = true
        
        self.headerOverlayBgView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.headerOverlayBgView.translatesAutoresizingMaskIntoConstraints = false
        
        self.bizProfileView.translatesAutoresizingMaskIntoConstraints = false
        
        self.bizImageView.image = UIImage(named: "placeholder.png")
        self.bizImageView.layer.masksToBounds = false
        self.bizImageView.layer.cornerRadius = 40
        self.bizImageView.clipsToBounds = true
        self.bizImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.bizNameLabel.text = self.dataProvider.getBusinessName()
        self.bizNameLabel.font = UIFont.cairoBoldFont(18)
        self.bizNameLabel.textColor = UIColor.whiteColor()
        self.bizNameLabel.textAlignment = .Center
        self.bizNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.productLabel.text = self.dataProvider.getLureTitle()
        self.productLabel.font = UIFont.cairoBoldFont(20)
        self.productLabel.textColor = UIColor.whiteColor()
        self.productLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if self.dataProvider.lure["targets"].count > 0 {
            self.incentiveLabel.text = self.dataProvider.lure["targets"][0]["description"].string ?? ""
        }
        self.incentiveLabel.font = UIFont.cairoRegularFont(18)
        self.incentiveLabel.numberOfLines = 0
        self.incentiveLabel.textColor = UIColor.whiteColor()
        self.incentiveLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Redeem view
        self.ticketView.backgroundColor = UIColor.whiteColor()
        self.qrCodeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.bizProfileView.addSubview(self.bizImageView)
        self.bizProfileView.addSubview(self.bizNameLabel)
        self.purchaseDetailHeaderView.addSubview(self.headerBgView)
        self.purchaseDetailHeaderView.addSubview(self.headerOverlayBgView)
        self.purchaseDetailHeaderView.addSubview(self.bizProfileView)
        self.purchaseDetailHeaderView.addSubview(self.productLabel)
        self.purchaseDetailHeaderView.addSubview(self.incentiveLabel)
        self.view.addSubview(self.purchaseDetailHeaderView)
        
        self.ticketView.addSubview(self.qrCodeImageView)
        
        generateQRCodeImage()
        if let qr = qrCodeImage {
            self.qrCodeImageView.image = UIImage(CIImage: qr)
        }
        
        setupTabScrollView()
        setupLayoutContraints()
    }
    
    func setupLayoutContraints() {
        let views = [
            "purchaseDetailTabScrollView": self.purchaseDetailTabScrollView,
            "purchaseDetailHeaderView": self.purchaseDetailHeaderView,
            "headerBgView": self.headerBgView,
            "headerOverlayBgView": self.headerOverlayBgView,
            "bizProfileView": self.bizProfileView,
            "bizImageView": self.bizImageView,
            "bizNameLabel": self.bizNameLabel,
            "productLabel": self.productLabel,
            "incentiveLabel": self.incentiveLabel,
            "ticketView": self.ticketView,
            "qrCodeImageView": self.qrCodeImageView
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        
        allConstraints += getConstraintFromFormat("H:|[headerBgView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[headerBgView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[headerOverlayBgView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|[headerOverlayBgView]|", views: views)
        
        let qrCodeImageViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[ticketView]-(<=1)-[qrCodeImageView]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: views)
        allConstraints += qrCodeImageViewXConstraints
        allConstraints += getConstraintFromFormat("V:|-60-[qrCodeImageView(160)]", views: views)
        
        allConstraints += getConstraintFromFormat("V:|-40-[bizImageView(80)]-10-[bizNameLabel]", views: views)
        allConstraints += getConstraintFromFormat("H:|-40-[bizImageView(80)]-40-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[bizNameLabel]-|", views: views)
        
        allConstraints += getConstraintFromFormat("H:|[bizProfileView(160)][productLabel]-10-|", views: views)
        allConstraints += getConstraintFromFormat("H:|[bizProfileView(160)][incentiveLabel]-10-|", views: views)
        allConstraints += getConstraintFromFormat("V:|[bizProfileView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|-50-[productLabel][incentiveLabel]", views: views)
        
        allConstraints += getConstraintFromFormat("V:|[purchaseDetailHeaderView(200)][purchaseDetailTabScrollView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[purchaseDetailHeaderView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[purchaseDetailTabScrollView]|", views: views)
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    func setupTabScrollView() {
        self.purchaseDetailTabScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.purchaseDetailTabScrollView.defaultPage = 0
        self.purchaseDetailTabScrollView.tabSectionHeight = 40
        self.purchaseDetailTabScrollView.pagingEnabled = true
        self.purchaseDetailTabScrollView.cachedPageLimit = 3
        self.purchaseDetailTabScrollView.delegate = self
        self.purchaseDetailTabScrollView.dataSource = self
        self.view.addSubview(self.purchaseDetailTabScrollView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func clearChildControllers(){
        for child in childViewControllers {
            child.willMoveToParentViewController(nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
    }

    func generateQRCodeImage() {
        let data = "Lure".dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("Q", forKey: "inputCorrectionLevel")
            if let qr = filter.outputImage {
                let scaleX = 160.0 / qr.extent.size.width
                let scaleY = 160.0 / qr.extent.size.height
                self.qrCodeImage = qr.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider.viewDidLoad()
    }
    
    // MARK: ACTabScrollViewDelegate
    func tabScrollView(tabScrollView: ACTabScrollView, didChangePageTo index: Int) {
        
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {
        
    }
    
    // MARK: ACTabScrollViewDataSource
    func numberOfPagesInTabScrollView(tabScrollView: ACTabScrollView) -> Int {
        return 2
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        let label = UILabel()
        if index == 0 {
            label.text = "DETAILS"
        } else {
            label.text = "REDEEM"
        }
        label.font = UIFont.cairoRegularFont(16)
        label.textColor = .wordColor()
        label.textAlignment = .Center
        
        // if the size of your tab is not fixed, you can adjust the size by the following way.
        label.sizeToFit() // resize the label to the size of content
        label.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 13) // add some paddings
        return label
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        if index == 0 {
            return self.detailVC.view
        } else {
            return self.ticketView
        }
    }

}