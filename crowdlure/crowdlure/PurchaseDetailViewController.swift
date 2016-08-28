//
//  PurchaseDetailViewController.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class PurchaseDetailViewController: UIViewController, ACTabScrollViewDelegate, ACTabScrollViewDataSource {

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

    init() {
        self.detailVC = LureTableViewController()
        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor.whiteColor()
        setupUI()
    }
    
    func setupUI() {
        
        // Header
        self.purchaseDetailHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerBgView.image = UIImage(named: "club.jpg")
        self.headerBgView.translatesAutoresizingMaskIntoConstraints = false
        self.headerBgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.headerBgView.clipsToBounds = true
        
        self.headerOverlayBgView.backgroundColor = UIColor.pastelTealColor().colorWithAlphaComponent(0.9)
        self.headerOverlayBgView.translatesAutoresizingMaskIntoConstraints = false
        
        self.bizProfileView.translatesAutoresizingMaskIntoConstraints = false
        
        self.bizImageView.image = UIImage(named: "club.jpg")
        self.bizImageView.layer.masksToBounds = false
        self.bizImageView.layer.cornerRadius = 40
        self.bizImageView.clipsToBounds = true
        self.bizImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.bizNameLabel.text = "Ashtray"
        self.bizNameLabel.font = UIFont.cairoBoldFont(18)
        self.bizNameLabel.textColor = UIColor.whiteColor()
        self.bizNameLabel.textAlignment = .Center
        self.bizNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.productLabel.text = "Philz Coffee"
        self.productLabel.font = UIFont.cairoBoldFont(20)
        self.productLabel.textColor = UIColor.whiteColor()
        self.productLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.incentiveLabel.text = "Get 20% off your next drink"
        self.incentiveLabel.font = UIFont.cairoRegularFont(18)
        self.incentiveLabel.numberOfLines = 0
        self.incentiveLabel.textColor = UIColor.whiteColor()
        self.incentiveLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Redeem view
        self.ticketView.backgroundColor = UIColor.groupTableViewBackgroundColor()
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
        allConstraints += getConstraintFromFormat("V:|-50-[qrCodeImageView(120)]", views: views)
        
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
                let scaleX = 120.0 / qr.extent.size.width
                let scaleY = 120.0 / qr.extent.size.height
                self.qrCodeImage = qr.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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