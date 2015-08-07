//
//  DBExecutor.swift
//  Warming
//
//  Created by ZhongGarry on 15/8/5.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//

import SQLite

class DBExecutor: NSObject {
    private static let db = Database(NSTemporaryDirectory() + "Warming.db")
    struct TableNote {
        static let notes = db["note"]
        static let noteId = Expression<Int64>(value: "noteId")
        static let title = Expression<String>(value: "title")
        static let content = Expression<String>(value: "content")
        static let repeatType = Expression<Int>(value: "repeatType")
        static let isWarmingOn = Expression<Bool>(value: "isWarmingOn")
        static let warmingDate = Expression<NSDate?>(value: "warmingDate")
        static let createAt = Expression<NSDate>(value: "create")
        static let updateAt = Expression<NSDate>(value: "updateAt")
    }
    
    class func createTableNote() {
        db.create(table: TableNote.notes, ifNotExists: true) { table in
            table.column(TableNote.noteId, primaryKey: .Autoincrement)
            table.column(TableNote.title)
            table.column(TableNote.content)
            table.column(TableNote.repeatType)
            table.column(TableNote.isWarmingOn)
            table.column(TableNote.warmingDate)
            table.column(TableNote.createAt)
            table.column(TableNote.updateAt)
        }
        db.create(index: TableNote.notes, ifNotExists: true, on: TableNote.title)
    }
    
    class func insertOrReplaceWithNoteEntity(entity: NoteEntity) {
        var setter = [
            TableNote.title <- entity.title,
            TableNote.content <- entity.content,
            TableNote.repeatType <- entity.repeatType.rawValue,
            TableNote.isWarmingOn <- entity.isWarmingOn,
            TableNote.warmingDate <- entity.warmingDate,
            TableNote.createAt <- entity.createAt,
            TableNote.updateAt <- entity.updateAt
        ]
        
        if entity.noteId
        
        TableNote.notes.insert(or: .Replace, setter)
    }
}
