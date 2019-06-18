//
//  PhoneViewController.swift
//  SampleApp
//
//  Created by Josh on 6/18/19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController {

    @IBOutlet weak var numberField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func callNumber(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + numberField.text!) else {
            return;
        }

        UIApplication.shared.open(number);
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
