//
//  Memo.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation

struct Memo: Equatable {
    var content: String
    var insertDate: Date
    var identity: String

    init(content: String, insertDate: Date = Date()) {
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }

    /// 업데이트 된 내용으로 새로운 메모 인스턴스를 생성할 때 사용
    init(original: Memo, updatedContent: String) {
        self = original
        self.content = updatedContent
    }
}
