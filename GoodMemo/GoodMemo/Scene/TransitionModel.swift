//
//  TransitionModel.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import Foundation

/// 전환 방식 표현
enum TransitionStyle {
    case root
    case push
    case modal
}

/// 전환 시 발생할 에러 타입
enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
