//
//  DBService.swift
//  SampleApp
//
//  Created by user on 2019-06-18.
//  Copyright © 2019 AccuV. All rights reserved.
//

import Foundation
import SQLite3


class RetreivedTodo: Todo {
    var id: Int
    var title: String
    var completed: Bool
    
    init(_ id:Int, _ title:String, _ completed:Bool) {
        self.id = id
        self.title = title
        self.completed = completed
    }
}

class DBService {
    
    var db:OpaquePointer?
    
    init() {
        setupDB()
    }
    
    private func setupDB() {
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
    
    func getCount() -> Int {
        var queryStatement: OpaquePointer?
        let query = "SELECT COUNT(*) FROM todos"
        
        var count = 0
        if sqlite3_prepare(self.db, query, -1, &queryStatement, nil) == SQLITE_OK{
            while(sqlite3_step(queryStatement) == SQLITE_ROW) {
                count = Int(sqlite3_column_int(queryStatement, 0))
            }
        }
        
        return count
    }
    
    // BUG Title does not work
    func get() -> [Todo] {
        let query = "SELECT * FROM todos"
        var queryStatement: OpaquePointer?
        var results:[Todo] = []
        if sqlite3_prepare(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let completed = sqlite3_column_int(queryStatement, 2) == 1
                var title = ""
                if let actualTitle = sqlite3_column_text(queryStatement, 1) {
                    title = String(cString: actualTitle)
                }
                else {
                    continue
                }
                results.append(RetreivedTodo(id, title, completed))
            }
        }
        return results
    }
    
    func add(withTitle title:String?) {
        let todoTitle = title?.trimmingCharacters(in: .whitespacesAndNewlines)
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
            print("error binding query todoTitle")
            return
        }
        
        if sqlite3_bind_int(stmt, 2, 0) != SQLITE_OK {
            print("error binding query todoCompleted")
            return
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("todo saved successfully")
        }
    }
    
    func deleteWithId(_ id:Int) {
        let query = "DELETE FROM todos WHERE id=\(id)"
        var deleteStatement:OpaquePointer? = nil
        if sqlite3_prepare(db, query, -1, &deleteStatement, nil) == SQLITE_OK {
            //...
        }
    }
    
}
