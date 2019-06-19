//
//  TokenData.swift
//  SampleApp
//
//  Created by Josh on 6/19/19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import Foundation

struct TokenData {
    
    let token : String
    let expiration : Int
    
    init(withToken token : String, andTokenExpiration expiration : Int) {
        self.token = token
        self.expiration = expiration
    }
}
