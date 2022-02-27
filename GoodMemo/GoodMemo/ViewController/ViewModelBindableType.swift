//
//  ViewModelBindableType.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import UIKit

/// MVVM 패턴으로 구현할 때는 ViewModel을 ViewController의 속성으로 추가
/// ViewModel과 View를 Binding
/// 이러한 역할을 수행하기 위한 Protocol
/// ViewModel의 타입은 ViewController마다 달라지기 때문에 Generic Protocol로 선언

protocol ViewModelBindableType {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

/// ViewController에 추가된 ViewModel의 실제 속성을 저장
/// bindViewModel 메서드를 자동으로 추가하는 메서드 구현

/// where Self - 해당 Protocol의 extension을 특정 Protocol을 상속했을 때만 사용될 수 있도록 하는 제약조건 추가 기능
/// 즉, 해당 extension에서 만든 메서드와 프로퍼티는 ViewController를 상속받지 않은 곳에서는 사용할 수가 없다.
extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()

        bindViewModel()
    }
}
