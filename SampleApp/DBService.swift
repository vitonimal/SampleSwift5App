//
//  DBService.swift
//  SampleApp
//
//  Created by user on 2019-06-18.
//  Copyright © 2019 AccuV. All rights reserved.
//

import Foundation
import SQLite3

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
        let query = "SELECT COUNT(*) FROM todos;"
        return sqlite3_prepare(db, query, -1, &queryStatement, nil) == SQLITE_OK ? Int(sqlite3_column_int(queryStatement, 0)) : 0
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
            print("error binding query")
            return
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("todo saved successfully")
        }
    }
    
}
