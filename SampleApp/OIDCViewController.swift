//
//  OIDCViewController.swift
//  SampleApp
//
//  Created by Josh on 6/19/19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import UIKit
import AppAuth

typealias PostRegistrationCallback = (_ configuration: OIDServiceConfiguration?, _ registrationResponse: OIDRegistrationResponse?) -> Void

let kIssuer: String = "https://accuvids4sit.azurewebsites.net";
let kClientID: String? = "js";
let kRedirectURI: String = "http://localhost:3000";
let kAppAuthKey = "code"


class OIDCViewController: UIViewController {
    
    private var authState: OIDAuthState?

    deinit {
        //...
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadState()
        initAuth()

        // Do any additional setup after loading the view.
    }
    
    func loadState() {
        guard let data = UserDefaults.standard.object(forKey: kAppAuthKey) as? Data else {
            return
        }
        
        if let authState = NSKeyedUnarchiver.unarchiveObject(with: data) as? OIDAuthState {
            self.authState = authState
        }
    }
    
    func initAuth() {
        guard let issuer = URL(string: kIssuer) else {
            print("Failed to get issuer")
            return
        }
        print("fetching info from issuer")
        
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer, completion: { configuration, error in
            guard let config = configuration else {
                self.authState = nil
                print("Failed to get config")
                return
            }
            
            self.authenticate(config)
            
        })
    }
    
    func authenticate(_ config: OIDServiceConfiguration) {
        guard let redirectUri = URL(string: kRedirectURI) else {
            print("Failed to create redirect uri")
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Failed to access app delegate")
            return
        }
        let request = OIDAuthorizationRequest(configuration: config,
                                              clientId: "js", // testa
                                              clientSecret: nil,
                                              scopes: [OIDScopeOpenID, OIDScopeProfile, OIDScopeEmail],
                                              redirectURL: redirectUri,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: nil)
        appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self, callback: { authState, error in
            if let authState = authState {
                self.authState = authState
                print("Got authorization tokens. Access token: \(authState.lastTokenResponse?.accessToken ?? "DEFAULT_TOKEN")")
            } else {
                print("Authorization error: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
                self.authState = nil
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
