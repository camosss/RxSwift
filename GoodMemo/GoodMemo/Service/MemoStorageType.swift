//
//  MemoStorageType.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation
import RxSwift

/// CRUD 처리 메서드
protocol MemoStorageType {
    @discardableResult /// 함수의 return값을 사용하지 않아도  warning 메세지 X
    func createMemo(content: String) -> Observable<Memo>

    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]>

    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
