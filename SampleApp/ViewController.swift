//
//  ViewController.swift
//  SampleApp
//
//  Created by Josh on 6/17/19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func promptBiometrics(_ sender: Any) {
        let context:LAContext = LAContext()
        context.localizedCancelTitle = "Enter username/password"
        
        var error:NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "login"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: { success, error in
                
                if success {
                    print("success")
                } else {
                    print("failed")
                }
                
            })
        }
    }
    
}

