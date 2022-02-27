//
//  MemoryStorage.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation
import RxSwift

class MemoryStorage: MemoStorageType {
    /// Observable을 통해 외부로 공개
    /// 이 Observable은 배열의 상태가 업데이트되면 새로운 next 이벤트 방출
    private var list = [
        Memo(content: "first memo", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "second memo", insertDate: Date().addingTimeInterval(-20))
    ]

    /// subject는 TableView와 Binding
    private lazy var store = BehaviorSubject<[Memo]>(value: list)

    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        /// 새로운 memo를 생성하고 배열에 추가
        let memo = Memo(content: content)
        list.insert(memo, at: 0)

        /// subject에서 새로운 next 이벤트를 방출
        store.onNext(list)

        /// 새로운 memo를 방출하는 Observable을 return
        return Observable.just(memo)
    }

    /// class 외부에서는 이 메서드를 통해 접근
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }

    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)

        /// 배열에 저장된 원본 인스턴스를 새로운 인스턴스로 교체
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }

        /// subject에서 새로운 next 이벤트를 방출
        store.onNext(list)

        /// 새로운 memo를 방출하는 Observable을 return
        return Observable.just(updated)
    }

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        /// 배열에 저장된 memo 삭제
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
        }

        /// subject에서 새로운 next 이벤트를 방출
        store.onNext(list)

        /// 새로운 memo를 방출하는 Observable을 return
        return Observable.just(memo)
    }
}
