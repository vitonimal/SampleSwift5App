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
    

    @IBAction func add(_ sender: Any) {
        
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
