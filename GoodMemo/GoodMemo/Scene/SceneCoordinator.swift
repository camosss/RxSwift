//
//  SceneCoordinator.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController {
    /// 실제로 화면에 표시되어있는 ViewController를 return 하는 속성
    var sceneViewController: UIViewController {
        /// NavigationController와 같은 ContainerViewController라면 children를 return
        /// 나머지는 self를 그대로 return
        return self.children.first ?? self
    }
}

class SceneCoordinator: SceneCoordinatorType {
    private let disposeBag = DisposeBag()

    /// SceneCoordinator는 화면 전환을 담당하기 때문에 window 인스턴스와
    /// 현재 화면에 표시되어 있는 Scene을 가지고 있어야한다.
    private var window: UIWindow
    private var currentVC: UIViewController

    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }

    @discardableResult
    func transition(
        to scene: Scene,
        using style: TransitionStyle,
        animated: Bool
    ) -> Completable {
        /// 전환 결과를 방출할 subject
        let subject = PublishSubject<Void>()

        /// Scene을 생성해서 상수에 저장
        let target = scene.instantiate()

        /// TransitionStyle에 따라 실제 전환 처리
        switch style {
        case .root:
            /// rootViewController를 바꿔주면 된다.
            currentVC = target.sceneViewController
            window.rootViewController = target

            /// subject로 completed 이벤트 전달
            subject.onCompleted()
        case .push:
            /// navigationController에 임베드되어있을 때만
            /// 아니라면 error이벤트를 전달하고 중지
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }

            /// delegate 메서드가 호출되는 시점마다 next 이벤트를 방출하는 Control event
            /// 여기에 구독자를 추가하고, currentVC 속성을 업데이트
            nav.rx.willShow
                .subscribe(onNext: { [unowned self] event in
                    self.currentVC = event.viewController.sceneViewController
                })
                .disposed(by: disposeBag)

            /// navigationController에 임베드되어있다면
            /// Scene을 push하고 completed 이벤트 전달
            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController

            subject.onCompleted()
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target.sceneViewController
        }

        return subject.ignoreElements().asCompletable()
    }

    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }

            } else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)

            } else {
                completable(.error(TransitionError.unknown))
            }

            return Disposables.create()
        }
    }
}
