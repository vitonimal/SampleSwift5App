//
//  DBViewController.swift
//  SampleApp
//
//  Created by Josh on 6/18/19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import UIKit
import SQLite3

class DBViewController: UIViewController {

    @IBOutlet weak var titleInput: UITextField!
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDB()
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
    
    func setupDB() {
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("todos.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK {
            print("error opening db")
            return
        }
        
        let createTableQuery = "CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, completed BIT)"
        
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            print("error creating table")
            return
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
