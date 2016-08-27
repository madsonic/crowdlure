//
//  PurchaseDetailViewController.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class PurchaseDetailViewController: UIViewController {

    let segControl = UISegmentedControl()
    let ticketView = UIView()

    var detailVC: LureDetailViewController
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let qrCodeImageView = UIImageView()
    var qrCodeImage: CIImage?

    init() {
        self.detailVC = LureDetailViewController()
        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor.whiteColor()
        setupSegControl()
        setupUI()
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

    func setupSegControl() {
        self.segControl.sizeToFit()
        self.segControl.insertSegmentWithTitle("Ticket", atIndex: 0, animated: false)
        self.segControl.insertSegmentWithTitle("Details", atIndex: 1, animated: false)
        self.segControl.selectedSegmentIndex = 0
        self.segControl.addTarget(self, action: #selector(PurchaseDetailViewController.didChangeSegControl), forControlEvents: .ValueChanged)
        self.navigationItem.titleView = self.segControl
    }

    func didChangeSegControl() {
        var v: UIView
        if self.segControl.selectedSegmentIndex == 1 {
            // Details
            clearChildControllers()
            addChildViewController(self.detailVC)
            self.detailVC.didMoveToParentViewController(self)
            v = self.detailVC.view
        } else {
            // Ticket
            v = self.ticketView
        }
        v.frame = self.view.bounds
        v.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(v)
        v.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        v.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        v.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        v.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
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
        didChangeSegControl()

    }

    func setupUI() {
        self.ticketView.backgroundColor = UIColor.groupTableViewBackgroundColor()

        self.titleLabel.text = "Philz Coffee"
        self.titleLabel.font = UIFont.boldSystemFontOfSize(24)
        self.titleLabel.textAlignment = .Center
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.descLabel.text = "Get 20% off your next drink"
        self.descLabel.font = UIFont.systemFontOfSize(20)
        self.descLabel.textAlignment = .Center
        self.descLabel.numberOfLines = 0
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false

        self.qrCodeImageView.translatesAutoresizingMaskIntoConstraints = false

        self.ticketView.addSubview(self.qrCodeImageView)
        self.ticketView.addSubview(self.titleLabel)
        self.ticketView.addSubview(self.descLabel)

        generateQRCodeImage()
        if let qr = qrCodeImage {
            self.qrCodeImageView.image = UIImage(CIImage: qr)
        }

        setupLayoutContraints()
    }

    func setupLayoutContraints() {
        let views = [
            "ticketView": self.ticketView,
            "titleLabel": self.titleLabel,
            "descLabel": self.descLabel,
            "qrCodeImageView": self.qrCodeImageView
        ]

        var allConstraints = [NSLayoutConstraint]()
        let qrCodeImageViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[ticketView]-(<=1)-[qrCodeImageView]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: views)
        allConstraints += qrCodeImageViewXConstraints
        allConstraints += getConstraintFromFormat("H:|-[titleLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("H:|-[descLabel]-|", views: views)
        allConstraints += getConstraintFromFormat("V:|-50-[qrCodeImageView(120)]-50-[titleLabel]-30-[descLabel]", views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
}