//
//  CommonViewModel.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/28.
//

import Foundation
import RxSwift
import RxCocoa

/// 의존성을 주입하는 생성자와 Binding에 사용되는 속성과 메서드가 추가
/// 화면 전환과 메모 저장을 처리 (Scene Coordinator와 MemoryStorage 사용)
class CommonViewModel: NSObject {
    let title: Driver<String>
    /// Protocol로 선언함으로써 의존성을 쉽게 수정
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoStorageType

    init(
        title: String,
        sceneCoordinator: SceneCoordinatorType,
        storage: MemoStorageType
    ) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}
