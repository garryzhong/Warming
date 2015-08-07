//
//  NoteEntity.swift
//  Warming
//
//  Created by ZhongGarry on 15/8/6.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//

import Foundation

struct NoteEntity {
    let noteId: Int64?
    let title: String
    let content: String
    let repeatType: WarmingRepeatType
    let isWarmingOn: Bool
    let warmingDate: NSDate?
    let createAt: NSDate
    let updateAt: NSDate
}
