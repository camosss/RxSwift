//
//  MemoListViewController.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoListViewModel!

    /// Observable과 TableView를 Binding 하기 때문에 DataSource 연결 X
    @IBOutlet weak var listTableView: UITableView!

    /// Action을 연결해 구현하는 것이 아닌
    /// tap속성을 구독하거나, Action 속성에 직접 할당하는 방식
    @IBOutlet weak var addButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    /// ViewModel과 View를 Binding
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)

        viewModel.memoList
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, memo, cell in
                cell.textLabel?.text = memo.content
            }
            .disposed(by: rx.disposeBag)
    }
}
