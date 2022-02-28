//
//  CommonViewModel.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/28.
//

import Foundation
import RxSwift
import RxCocoa

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
