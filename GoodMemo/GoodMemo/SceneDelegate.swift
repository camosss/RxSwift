//
//  SceneDelegate.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        /// 1. 앱이 실행되면 메모리 저장소와 Scene 코디네이터가 생성
        let storage = MemoryStorage()
        let coordinator = SceneCoordinator(window: window!)

        /// 2. Viewmodel은 두 인스턴스를 통해 메모를 저장하고, 화면 전환을 처리
        /// 메모리 저장소와 Scene 코디네이터에 대한 의존성은 ViewModel을 생성할 때, 생성자를 통해서 주입
        let listViewModel = MemoListViewModel(
            title: "나의 메모",
            sceneCoordinator: coordinator,
            storage: storage
        )

        /// 3. 새로운 Scene을 생성하고, 연관값으로 ViewModel을 저장
        /// Scene 열거형의 list Scene
        let listScene = Scene.list(listViewModel)

        coordinator.transition(to: listScene, using: .root, animated: false)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

