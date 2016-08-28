//
//  AppLoginViewController.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import SwiftyJSON

class AppLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    let loginButton = FBSDKLoginButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        loginButton.readPermissions = ["public_profile"]
        loginButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 125)
        loginButton.delegate = self
        
        let logoView = UIImageView(image: UIImage(named: "Logo"))
        logoView.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        logoView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 50)
        
        self.view.addSubview(loginButton)
        self.view.addSubview(logoView)
    }
    
    // MARK: -- Facebook Login
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error == nil {
            if (FBSDKAccessToken.currentAccessToken() != nil) {
                // Hide login button and show spinner
                let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
                spinner.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                spinner.center = loginButton.center
                loginButton.removeFromSuperview()
                self.view.addSubview(spinner)
                spinner.startAnimating()
                
                let fbToken = FBSDKAccessToken.currentAccessToken().tokenString
                let foo = request(Endpoint.authUser(fbAccessToken: fbToken))
                foo.responseJSON(successHandler: { res in
                        let token = JSON(res)["user"]["hash_token"].string!
                        NSUserDefaults.standardUserDefaults().setValue(token, forKey: hashToken)
                        dispatch_async(dispatch_get_main_queue()) {
                            spinner.stopAnimating()
                            if let window = UIApplication.sharedApplication().keyWindow {
                                window.rootViewController = AppTabBarController()
                            }
                        }
                    }, failureHandler: { (err) in
                        dispatch_async(dispatch_get_main_queue()) {
                            spinner.stopAnimating()
                            spinner.removeFromSuperview()
                            self.view.addSubview(loginButton)
                        }
                    }
                )
            }
        } else {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out...")
    }
}