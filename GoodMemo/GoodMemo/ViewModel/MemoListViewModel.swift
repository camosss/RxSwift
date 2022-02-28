//
//  MemoListViewModel.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation
import RxSwift
import RxCocoa

/// 의존성을 주입하는 생성자와 Binding에 사용되는 속성과 메서드가 추가
/// 화면 전환과 메모 저장을 처리 (Scene Coordinator와 MemoryStorage 사용)
class MemoListViewModel: CommonViewModel {
    /// 메모 목록: TableView와 Binding할 수 있는 속성 추가
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
}
