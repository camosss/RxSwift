//
//  Task.swift
//  GoodList
//
//  Created by 강호성 on 2021/12/08.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
