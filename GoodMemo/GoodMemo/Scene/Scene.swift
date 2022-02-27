//
//  Scene.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import UIKit

/// 앱에서 구현할 Scene
/// Scene과 연관된 ViewModel을 연관 값으로 저장
enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

/// 스토리보드에 있는 Scene을 생성
extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)

        /// 연관값에 저장된 ViewModel을 Binding해서 return
        switch self {
        case .list(let viewModel):
            guard let nav = storyboard.instantiateViewController(
                withIdentifier: "ListNav"
            ) as? UINavigationController else { fatalError() }

            guard var listVC = nav.viewControllers.first as? MemoListViewController
            else { fatalError() }

            /// 실제 Scene과 ViewModel을 Binding하고 NavigationController를 return
            listVC.bind(viewModel: viewModel)
            return nav

        case .detail(let viewModel):
            guard var detailVC = storyboard.instantiateViewController(
                withIdentifier: "DetailVC"
            ) as? MemoDetailViewController else { fatalError() }

            detailVC.bind(viewModel: viewModel)
            return detailVC

        case .compose(let viewModel):
            guard let nav = storyboard.instantiateViewController(
                withIdentifier: "ComposeNav"
            ) as? UINavigationController else { fatalError() }

            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController
            else { fatalError() }

            composeVC.bind(viewModel: viewModel)
            return nav
        }
    }
}
