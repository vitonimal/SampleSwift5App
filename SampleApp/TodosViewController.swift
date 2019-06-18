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
    var id:Int { get }
}

class TodosViewController: UITableViewController {
    
    static let NUMBER_OF_SECTIONS = 1
    var testTodos: [String] = []
    var todos:[Todo] = []
    var db: OpaquePointer?
    var dbService:DBService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testTodos = ["todo1", "todo2", "todo3"]
        dbService = DBService()
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TodosViewController.NUMBER_OF_SECTIONS
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbService.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  "yo" //todos[indexPath.row].title
        return cell
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
