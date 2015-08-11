//
//  TableNote.swift
//  Warming
//
//  Created by ZhongGarry on 15/8/10.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//

import UIKit
import SQLite

let NoNoteId: Int64 = -99
struct NoteEntity {
    var noteId: Int64
    let title: String
    let content: String
    let repeatType: WarmingRepeatType
    let isWarmingOn: Bool
    let warmingDate: NSDate?
    let createAt: NSDate
    let updateAt: NSDate
}

class TableNote: NSObject {
    private static let shareInstance = TableNote()
    private let note: Query
    private let noteId = Expression<Int64>(value: "noteId")
    private let title = Expression<String>(value: "title")
    private let content = Expression<String>(value: "content")
    private let repeatType = Expression<Int>(value: "repeatType")
    private let isWarmingOn = Expression<Bool>(value: "isWarmingOn")
    private let warmingDate = Expression<NSDate?>(value: "warmingDate")
    private let createAt = Expression<NSDate>(value: "create")
    private let updateAt = Expression<NSDate>(value: "updateAt")
    
    class var table: TableNote {
        return shareInstance
    }
    
    private override init() {
        note = DBExecutor.sharedExecutor.db["note"]
        super.init()
        DBExecutor.sharedExecutor.createTableIfNotExistWithTable(note) {[unowned self] table in
            table.column(self.noteId)
            table.column(self.title)
            table.column(self.content)
            table.column(self.repeatType)
            table.column(self.isWarmingOn)
            table.column(self.warmingDate)
            table.column(self.createAt)
            table.column(self.updateAt)
        }
        DBExecutor.sharedExecutor.db.create(index: note, unique: false, ifNotExists: true, on: noteId)
    }
    
    func insertOrReplaceWithEntity(entity: NoteEntity) {
        var values = [
            title <- "title",
            content <- "content",
            repeatType <- 0,
            isWarmingOn <- true,
            warmingDate <- NSDate(),
            createAt <- NSDate(),
            updateAt <- NSDate()
        ]
        if entity.noteId != NoNoteId {
            values.append(noteId <- entity.noteId)
        }
        
        DBExecutor.sharedExecutor.insertOrReplaceWithTable(note, values: values)
    }
    func test() {
        let entity = NoteEntity(noteId: 1, title: "titile", content: "content", repeatType: .Once, isWarmingOn: true, warmingDate: nil, createAt: NSDate(), updateAt: NSDate())
        insertOrReplaceWithEntity(entity)
        
    }
}
