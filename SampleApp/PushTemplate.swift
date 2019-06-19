//
//  PushTemplate.swift
//  SampleApp
//
//  Created by Josh on 6/19/19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import Foundation

class PushTemplate : Codable {
    let body: String
    init(withbody body: String) {
        self.body = body
    }
}
