//
//  TodosViewController.swift
//  SampleApp
//
//  Created by Josh on 6/18/19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import UIKit
import SQLite3

protocol Todo {
    var title:String { get set }
    var completed:Bool { get set }
    var id:Int { get set } // set for the sake of debugging
}

class TodosViewController: UITableViewController {
    
    static let NUMBER_OF_SECTIONS = 1
    var testTodos: [String] = []
    var todos:[Todo] = []
    var db: OpaquePointer?
    var dbService:DBService = DBService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = dbService.get()
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TodosViewController.NUMBER_OF_SECTIONS
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DB count \(dbService.getCount())")
        return dbService.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  todos[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            print("lol")
        }
    }

}
