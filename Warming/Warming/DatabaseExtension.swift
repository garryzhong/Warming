//
//  DatabaseExtension.swift
//  Warming
//
//  Created by ZhongGarry on 15/8/6.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//
import Foundation
import SQLite

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