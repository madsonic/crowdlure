//
//  LureDetailViewController.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class LureDetailViewController: UIViewController, ACTabScrollViewDelegate, ACTabScrollViewDataSource, SIMChargeCardViewControllerDelegate, DataProviderDelegate {
    
    let purchaseButton = UIButton()

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
    
    func setupUI() {
        
        // Header
        self.purchaseDetailHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerBgView.image = UIImage(named: "placeholder.png")
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
        self.bizNameLabel.font = UIFont.cairoBoldFont(17)
        self.bizNameLabel.textColor = UIColor.whiteColor()
        self.bizNameLabel.textAlignment = .Center
        self.bizNameLabel.numberOfLines = 0
        self.bizNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.productLabel.text = self.dataProvider.getLureTitle()
        self.productLabel.font = UIFont.cairoBoldFont(16)
        self.productLabel.textColor = UIColor.whiteColor()
        self.productLabel.numberOfLines = 0
        self.productLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if self.dataProvider.getTargetDescriptions().count > 0 {
            self.incentiveLabel.text = self.dataProvider.getTargetDescriptions()[0]
        }
        self.incentiveLabel.font = UIFont.cairoRegularFont(16)
        self.incentiveLabel.numberOfLines = 0
        self.incentiveLabel.numberOfLines = 0
        self.incentiveLabel.textColor = UIColor.whiteColor()
        self.incentiveLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Redeem view
        self.ticketView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.qrCodeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Purchase button
        self.purchaseButton.setTitle("Purchase for $" + String(format: "%.2f", self.dataProvider.getPrice()), forState: .Normal)
        self.purchaseButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.purchaseButton.titleLabel?.font = UIFont.cairoBoldFont(22)
        self.purchaseButton.backgroundColor = UIColor.skyBlueColor()
        self.purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        self.purchaseButton.addTarget(self, action: #selector(LureDetailViewController.didPressPurchaseButton), forControlEvents: .TouchUpInside)
        
        self.bizProfileView.addSubview(self.bizImageView)
        self.bizProfileView.addSubview(self.bizNameLabel)
        self.purchaseDetailHeaderView.addSubview(self.headerBgView)
        self.purchaseDetailHeaderView.addSubview(self.headerOverlayBgView)
        self.purchaseDetailHeaderView.addSubview(self.bizProfileView)
        self.purchaseDetailHeaderView.addSubview(self.productLabel)
        self.purchaseDetailHeaderView.addSubview(self.incentiveLabel)
        
        self.ticketView.addSubview(self.qrCodeImageView)
        
        self.view.addSubview(self.purchaseDetailHeaderView)
        self.view.addSubview(self.purchaseButton)
        
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
            "qrCodeImageView": self.qrCodeImageView,
            "purchaseButton": self.purchaseButton
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
        allConstraints += getConstraintFromFormat("V:|-20-[productLabel][incentiveLabel]", views: views)
        
        allConstraints += getConstraintFromFormat("V:|[purchaseDetailHeaderView(200)][purchaseDetailTabScrollView][purchaseButton(50)]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[purchaseDetailHeaderView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[purchaseDetailTabScrollView]|", views: views)
        allConstraints += getConstraintFromFormat("H:|[purchaseButton]|", views: views)
        
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
        self.dataProvider.viewDidLoad()
    }
    
    // MARK: ACTabScrollViewDelegate
    func tabScrollView(tabScrollView: ACTabScrollView, didChangePageTo index: Int) {
        
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {
        
    }
    
    // MARK: ACTabScrollViewDataSource
    func numberOfPagesInTabScrollView(tabScrollView: ACTabScrollView) -> Int {
        return 1
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        let label = UILabel()
        label.text = "DETAILS"
        label.font = UIFont.cairoRegularFont(16)
        label.textColor = .wordColor()
        label.textAlignment = .Center
        
        // if the size of your tab is not fixed, you can adjust the size by the following way.
        label.sizeToFit() // resize the label to the size of content
        label.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 13) // add some paddings
        return label
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        return self.detailVC.view
    }
    
    func dataUpdated() {
        if let bizLogoData = self.dataProvider.bizLogoData {
            self.bizImageView.image = UIImage(data: bizLogoData)
        }
        
        if let imgData = self.dataProvider.imgData {
            self.headerBgView.image = UIImage(data: imgData)
        }
        
        // Lure has already been purchased
        if self.dataProvider.purchased {
            self.purchaseButton.setTitle("Purchased", forState: .Normal)
            self.purchaseButton.backgroundColor = UIColor.pastelTealColor()
        }
    }
    
    func didPressPurchaseButton() {
        if !self.dataProvider.purchased {
            let chargeVC:SIMChargeCardViewController = SIMChargeCardViewController.init(publicKey: "sbpb_MGU4MWQ5Y2ItMGI1Ny00MDhjLWEyMzEtMzhmMTBhMTlkMDZh")
                chargeVC.delegate = self
                self.presentViewController(chargeVC, animated: true, completion: nil)
        }
    }
    
    //MARK: SIMChargeCardViewControllerDelegate
    
    /**
     Token cancel Callback. The User has elected to cancel the token generation workflow.
     */
    func chargeCardCancelled() {
        
    }
    
    /**
     Token failure Callback. If token generation fails, this will be called back and an error will be provided with a localizedDescription and code.
     */
    func creditCardTokenFailedWithError(error: NSError) {
        print(error.description)
    }
    
    /**
     Token success Callback. If token generation succeeds, this will be called back and the fully hydrated credit card token.
     */
    func creditCardTokenProcessed(token: SIMCreditCardToken) {
        
        let url = NSURL(string: "https://ariel-sia.herokuapp.com/charge.php")!
        
        let request = NSMutableURLRequest(
            URL: url,
            cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        
        request.HTTPMethod = "POST"
        var postString = "simplifyToken="
        postString = postString.stringByAppendingString(token.token)
        postString = postString.stringByAppendingString("&amount=1500000")
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            self.dataProvider.updateServerOfPurchase()
        }
        task.resume()
    }

}
