//
//  LoginViewController.swift
//  Magnify
//
//  Created by Ben Guo on 4/1/15.
//  Copyright (c) 2015 benzguo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, SPTAuthViewDelegate {
    @IBOutlet weak var connectButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Check if we have a valid session
        let auth = SPTAuth.defaultInstance()
        if (auth.session != nil && auth.session.isValid()) {
            performSegueWithIdentifier("showPlaylists", sender: nil)
        }
    }

    @IBAction func connectButtonAction(sender: AnyObject) {
        let authVC = SPTAuthViewController.authenticationViewController()
        authVC.delegate = self
        authVC.delegate = self
        authVC.modalPresentationStyle = .OverCurrentContext
        authVC.modalTransitionStyle = .CrossDissolve
        modalPresentationStyle = .CurrentContext
        definesPresentationContext = true;
        presentViewController(authVC, animated: true, completion: nil)
    }

    func authenticationViewController(authenticationViewController: SPTAuthViewController!, didFailToLogin error: NSError!) {

    }

    func authenticationViewControllerDidCancelLogin(authenticationViewController: SPTAuthViewController!) {

    }

    func authenticationViewController(authenticationViewController: SPTAuthViewController!, didLoginWithSession session: SPTSession!) {
        self.performSegueWithIdentifier("showPlaylists", sender: self)
    }


}
