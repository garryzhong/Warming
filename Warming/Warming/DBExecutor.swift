//
//  DBExecutor.swift
//  Warming
//
//  Created by ZhongGarry on 15/8/5.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//

enum DBCode {
    case OperationSuccess(Int64)
    case OperationFailed
}

import SQLite

class DBExecutor: NSObject {
    static let db = Database(NSHomeDirectory() + "Warming.db")
    
    class func createTableIfNotExistWithTable(table: Query, block: SchemaBuilder -> Void) {
        db.create(table: table, temporary: false, ifNotExists: true, block)
    }
    
    class func createIndexIfNotExistWithTable(table: Query, value: Expressible) {
        db.create(index: table, unique: false, ifNotExists: true, on: value)
    }

    class func insertOrReplaceWithTable(table: Query, values: [Setter]) -> DBCode {
        if let id = table.insert(or: Query.OnConflict.Replace, values).rowid {
            return .OperationSuccess(id)
        } else {
            println(db.lastError!)
            return .OperationFailed
        }
    }
}

extension NSDate: Value {
    public class var declaredDatatype: String {
        return Int.declaredDatatype
    }
    public class func fromDatatypeValue(intValue: Int) -> Self {
        return self(timeIntervalSince1970: NSTimeInterval(intValue))
    }
    public var datatypeValue: Int {
        return Int(timeIntervalSince1970)
    }
}
