//
//  MoreViewController.swift
//  DesignCodeApp
//
//  Created by Sergio Gomes on 23/05/18.
//  Copyright © 2018 Sergio Gomes. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    let webViewIdentifier: String = "moreToWeb"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func safariButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: webViewIdentifier, sender: "https://designcode.io")
    }

    @IBAction func communityButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: webViewIdentifier, sender: "https://spectrum.chat/design-code")
    }
    
    @IBAction func twitterHandleTapper(_ sender: Any) {
        performSegue(withIdentifier: webViewIdentifier, sender: "https://twitter.com/mengto")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == webViewIdentifier {
            
            let toNav = segue.destination as! UINavigationController
            let toViewController = toNav.viewControllers.first as! WebViewController
            
            let url = sender as! String
            
            toViewController.urlString = url
        }
    }
}
