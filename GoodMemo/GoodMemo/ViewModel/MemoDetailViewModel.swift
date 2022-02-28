//
//  MemoDetailViewModel.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel: CommonViewModel {
    /// 이전 Scene에서 전달된 memo가 저장
    let memo: Memo

    private var formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "Ko_Kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()

    /// 첫번째 Cell에는 메모 내용, 두번째 Cell에는 날짜 -- [String] 방출
    /// TableView에 데이터를 표시하기 위해 Observable과 Binding

    /// Observable이 아닌 BehaviorSubject 이유
    /// 메모를 편집한 다음 보기 화면으로 오면 편집한 내용이 반영되어야 한다.
    /// 이러기 위해서는 새로운 문자열 배열을 방출해야 한다.
    var contents: BehaviorSubject<[String]>

    init(
        memo: Memo,
        title: String,
        sceneCoordinator: SceneCoordinatorType,
        storage: MemoStorageType
    ) {
        self.memo = memo

        contents = BehaviorSubject<[String]>(value: [
            memo.content,
            formatter.string(from: memo.insertDate)
        ])

        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }

    /// navigationController의 back Button은 SceneCoordinator와 아무런 관련이 없기 때문에 close() 메서드를 실행해야 함
    /// navigationController의 back Button과 Binding할 Action 추가
    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
    }
}
