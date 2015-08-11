//
//  ViewController.swift
//  test
//
//  Created by ZhongGarry on 15/8/9.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Database(NSTemporaryDirectory() + "test.db")
        let tableTest = db["test"]
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        
        db.create(table: tableTest) { table in
            table.column(id, primaryKey: true)
            table.column(name)
        }
        
        var values = [name <- "d"]
        if let rowid = tableTest.insert(values).rowid {
            println("inserted id: \(rowid)")
        }
    }
}

