//
//  SceneCoordinatorType.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation
import RxSwift

/// Completable(Traits) - 구독자를 추가하고, 화면 전환이 완료된 후에 원하는 작업을 구현할 수 있다.
/// 이런 작업이 필요없다면 사용하지 않아도된다.
/// @discardableResult를 선언했기 때문에 경고는 표시되지 않는다.

/// SceneCoordinator가 공통적으로 구현해야 하는 멤버 선언
protocol SceneCoordinatorType {
    /// 새로운 Scene을 표시
    @discardableResult
    func transition(
        to scene: Scene,
        using style: TransitionStyle,
        animated: Bool
    ) -> Completable

    /// 현재 Scene을 닫고 전 Scene으로 돌아가기
    @discardableResult
    func close(animated: Bool) -> Completable
}
