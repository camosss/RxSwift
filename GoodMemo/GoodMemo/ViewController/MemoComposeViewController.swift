//
//  MemoComposeViewController.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

/// 새로운 메모 추가, 메모 편집
class MemoComposeViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoComposeViewModel!

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentTextView.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)

        /// 쓰기모드에서는 빈 문자열, 편집모드에서는 편집할 문자열 표시
        viewModel.initialText
            .drive(contentTextView.rx.text)
            .disposed(by: rx.disposeBag)

        /// 취소버튼을 Tap하면 cancelAction에 래핑되어있는 코드 실행
        cancelButton.rx.action = viewModel.cancelAction

        /// 저장버튼을 Tap하면 TextView에 저장된 문자열을 저장
        saveButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance) /// 더블 탭 방지
            .withLatestFrom(contentTextView.rx.text.orEmpty) /// TextView에 입력된 Text를 방출
            .bind(to: viewModel.saveAction.inputs) /// 방출된 text를 saveAction과 Binding
            .disposed(by: rx.disposeBag)
    }
}
