//
//  MemoListViewModel.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel: CommonViewModel {
    /// 메모 목록: TableView와 Binding할 수 있는 속성 추가
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
}
