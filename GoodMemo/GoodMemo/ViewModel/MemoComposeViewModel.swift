//
//  MemoComposeViewModel.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoComposeViewModel: CommonViewModel {
    /// Compose Scene에 표시할 메모를 저장할 속성
    /// 새로운 메모는 nil, 편집할 때는 편집할 메모가 저장
    private let content: String?

    /// Driver: View에 Binding할 수 있도록
    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: "")
    }

    /// 저장/취소 두가지 Action을 구현 (Action 저장 속성)
    /// navigationBar에 저장 버튼과 취소 버튼에 두 Action(save, cancel)과 Binding
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction

    /// 저장과 취소 코드를 직접 구현을 하면 ViewModel에서 처리방식이 하나로 고정
    /// 파라미터로 받으면 이전 화면에서 처리 방식을 동적으로 결정할 수 있다는 장점
    init(
        title: String,
        content: String? = nil,
        sceneCoordinator: SceneCoordinatorType,
        storage: MemoStorageType,
        saveAction: Action<String, Void>? = nil,
        cancelAction: CocoaAction? = nil
    ) {
        self.content = content

        /// saveAction을 옵셔널로 선언하고 한번 더 래핑하여
        /// 실제로 Action이 전달되었다면 실행(execute) 후 화면을 닫음(close)
        /// Action이 전달되지 않았다면 화면만 닫음(close)
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }

        /// cancelAction도 동일
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
