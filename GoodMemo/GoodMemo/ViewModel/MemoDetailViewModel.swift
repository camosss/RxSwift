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

    /// saveAction 처리 메서드
    /// ComposeViewModel로 전달하는 Action
    func performUpdate(memo: Memo) -> Action<String, Void> {
        /// 입력 타입: String -> 입력값으로 Memo를 업데이트
        return Action { input in
            /// update: 편집된 메모를 방출 / Observable이 방출하는 형식은 Void
            /// 방출하는 형식이 다르기 때문에 map 연산자로 해결
            self.storage.update(memo: memo, content: input)
                .subscribe(onNext: { updated in
                    self.contents.onNext([ /// 새로운 내용을 subject로 전달(편집된 내용을 next 이벤트에 담아서 방출)
                        updated.content,
                        self.formatter.string(from: updated.insertDate)
                    ])
                })
                .disposed(by: self.rx.disposeBag)

            /// 빈 Observable return
            return Observable.empty()
        }
    }

    /// 보기 화면의 편집버튼과 Binding할 Action
    func makeEditAction() -> CocoaAction {
        return CocoaAction { _ in
            let composeViewModel = MemoComposeViewModel(
                title: "메모 편집",
                content: self.memo.content,
                sceneCoordinator: self.sceneCoordinator,
                storage: self.storage,
                saveAction: self.performUpdate(memo: self.memo)
            )

            let composeScene = Scene.compose(composeViewModel)
            return self.sceneCoordinator.transition(
                to: composeScene,
                using: .modal,
                animated: true
            ).asObservable().map { _ in }
        }
    }

    /// 삭제 버튼과 Binding할 Action
    func makeDeleteAction() -> CocoaAction {
        return Action { input in
            /// 메모를 삭제한 다음에 이전 화면으로
            self.storage.delete(memo: self.memo)
            return self.sceneCoordinator.close(animated: true)
                .asObservable().map { _ in }
        }
    }
}
