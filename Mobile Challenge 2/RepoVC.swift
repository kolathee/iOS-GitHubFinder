//
//  RepoVC.swift
//  Mobile Challenge 2
//
//  Created by Kolathee Payuhawatthana on 4/7/2560 BE.
//  Copyright © 2560 Kolathee Payuhawattana. All rights reserved.
//

import UIKit

class RepoVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestURL = NSURL(string:url!)
        let request = NSURLRequest(url: requestURL! as URL)
        webView.loadRequest(request as URLRequest)

    }
}
