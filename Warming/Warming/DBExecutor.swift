//
//  DBExecutor.swift
//  Warming
//
//  Created by ZhongGarry on 15/8/5.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//

import SQLite

class DBExecutor: NSObject {
    private class let db = Database(NSTemporaryDirectory() + "Warming.db")
    class func createTable() {

    }
}
