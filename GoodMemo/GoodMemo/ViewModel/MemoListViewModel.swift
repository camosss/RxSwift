//
//  MemoListViewModel.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import RxDataSources

/// SectionData: Int, rowData: Memo
typealias MemoSectionModel = AnimatableSectionModel<Int, Memo>

class MemoListViewModel: CommonViewModel {

    /// 메모 목록: TableView와 Binding할 수 있는 속성 추가
    var memoList: Observable<[MemoSectionModel]> {
        return storage.memoList()
    }

    /// saveAction 처리 메서드
    /// 생성된 메모 업데이트: createMemo가 실행되면 메모가 새로 생성되고 Observable로 방출되기 때문
    func performUpdate(memo: Memo) -> Action<String, Void> {
        /// 입력 타입: String -> 입력값으로 Memo를 업데이트
        return Action { input in
            /// update: 편집된 메모를 방출 / Observable이 방출하는 형식은 Void
            /// 방출하는 형식이 다르기 때문에 map 연산자로 해결
            return self.storage.update(memo: memo, content: input).map { _ in }
        }
    }

    /// cancelAction 처리 메서드
    /// 생성된 메모 삭제: createMemo가 실행되면 메모가 새로 생성되고 Observable로 방출되기 때문
    func performCancel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.delete(memo: memo).map { _ in }
        }
    }

    /// +버튼과 Binding할 Action 구현
    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            return self.storage.createMemo(content: "")
                .flatMap { memo -> Observable<Void> in
                    /// 화면 전환 처리
                    let composeViewModel = MemoComposeViewModel(
                        title: "새 메모",
                        sceneCoordinator: self.sceneCoordinator,
                        storage: self.storage,
                        saveAction: self.performUpdate(memo: memo),
                        cancelAction: self.performCancel(memo: memo)
                    )

                    /// Compose Scene 생성 후, 연관 값 ViewModel 저장
                    /// transition 메서드는 Completable을 return하기 때문에 map 연산자로 Void 형식을 방출하는 Observable로
                    let composeScene = Scene.compose(composeViewModel)
                    return self.sceneCoordinator.transition(
                        to: composeScene,
                        using: .modal,
                        animated: true
                    ).asObservable().map { _ in }
                }
        }
    }

    /// -> MemoDetailViewController (메서드 형태가 아닌 속성 형태로 구현)
    /// 입력 형식은 Memo, 출력 형식은 Void
    lazy var detailAction: Action<Memo, Void> = {
        return Action { memo in
            let detailViewModel = MemoDetailViewModel(
                memo: memo,
                title: "메모 보기",
                sceneCoordinator: self.sceneCoordinator,
                storage: self.storage
            )

            let detailScene = Scene.detail(detailViewModel)
            return self.sceneCoordinator.transition(
                to: detailScene,
                using: .push,
                animated: true
            ).asObservable().map { _ in }
        }
    }()

    lazy var deleteAction: Action<Memo, Swift.Never> = {
        return Action { memo in
            return self.storage.delete(memo: memo).ignoreElements()
        }
    }()
}
