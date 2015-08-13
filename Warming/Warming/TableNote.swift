//
//  TableNote.swift
//  Warming
//
//  Created by ZhongGarry on 15/8/10.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//

import SQLite

struct NoteEntity {
    var noteId: Int64?
    let title: String
    let content: String
    let repeatType: WarmingRepeatType
    let isWarmingOn: Bool
    let warmingDate: NSDate?
    let createAt: NSDate
    let updateAt: NSDate
    
    func newWithNoteId(id: Int64) -> NoteEntity {
        var temp = self
        temp.noteId = id
        return temp
    }
}

class TableNote: NSObject {
    private static let shareInstance = TableNote()
    private static let note = DBExecutor.db["note"]
    private static let noteId = Expression<Int64>("noteId")
    private static let title = Expression<String>("title")
    private static let content = Expression<String>("content")
    private static let repeatType = Expression<Int>("repeatType")
    private static let isWarmingOn = Expression<Bool>("isWarmingOn")
    private static let warmingDate = Expression<NSDate?>("warmingDate")
    private static let createAt = Expression<NSDate>("create")
    private static let updateAt = Expression<NSDate>("updateAt")
}

extension TableNote {
    class func createTableAndIndexIfNoeExist() {
        DBExecutor.createTableIfNotExistWithTable(note) { table in
            table.column(self.noteId, primaryKey: true)
            table.column(self.title)
            table.column(self.content)
            table.column(self.repeatType)
            table.column(self.isWarmingOn)
            table.column(self.warmingDate)
            table.column(self.createAt)
            table.column(self.updateAt)
        }
        DBExecutor.createIndexIfNotExistWithTable(note, value: title)
    }
    
    class func insertOrReplaceWithEntity(entity: NoteEntity) -> (DBCode, NoteEntity?) {
        var values = [
            title <- entity.title,
            content <- entity.content,
            repeatType <- entity.repeatType.rawValue,
            isWarmingOn <- entity.isWarmingOn,
            warmingDate <- entity.warmingDate,
            createAt <- entity.createAt,
            updateAt <- entity.updateAt
        ]
        if let id = entity.noteId {
            values.append(noteId <- id)
        }
        switch DBExecutor.insertOrReplaceWithTable(note, values: values) {
        case .OperationFailed:
            return (.OperationFailed, nil)
        case .OperationSuccess(let id):
            return (.OperationSuccess(id), entity.newWithNoteId(id))
        }
    }
}
