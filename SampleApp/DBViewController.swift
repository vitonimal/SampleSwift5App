//
//  DBViewController.swift
//  SampleApp
//
//  Created by Josh on 6/18/19.
//  Copyright © 2019 AccuV. All rights reserved.
//


// TODO Delete and to be replaced with TodoViewController

import UIKit
import SQLite3

class DBViewController: UIViewController {

    @IBOutlet weak var titleInput: UITextField!
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTodo(_ sender: Any) {
        let todoTitle = titleInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if (todoTitle?.isEmpty)! {
            return
        }
        var stmt: OpaquePointer?
        
        let insertQuery = "INSERT INTO todos (title, completed) VALUES (?, ?)";
        if sqlite3_prepare(db, insertQuery, -1, &stmt, nil ) != SQLITE_OK {
            print("Failed to prepare query")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, todoTitle, -1, nil) != SQLITE_OK {
            print("error binding query")
            return
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("todo saved successfully")
        }
        
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
