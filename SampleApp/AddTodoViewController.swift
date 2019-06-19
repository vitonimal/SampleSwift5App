//
//  AddTodoViewController.swift
//  SampleApp
//
//  Created by Josh on 6/18/19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {

    @IBOutlet weak var titleContent: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var dbService:DBService = DBService()

    @IBAction func add(_ sender: Any) {
        dbService.add(withTitle: titleContent.text)
        cancel()
    }
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
