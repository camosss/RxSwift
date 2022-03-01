//
//  MemoListViewController.swift
//  GoodMemo
//
//  Created by 강호성 on 2022/02/27.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
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

    /// TableView Binding에 사용할 dataSource 속성
    let dataSource: RxTableViewSectionedAnimatedDataSource<MemoSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<MemoSectionModel>(
            configureCell: { (dataSource, tableView, indexPath, memo
            ) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = memo.content
            return cell
        })
        ds.canEditRowAtIndexPath = { _, _ in return true }
        return ds
    }()

    /// ViewModel과 View를 Binding
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)

        /// viewModel의 dataSource와 Binding
        viewModel.memoList
            .bind(to: listTableView.rx.items(dataSource: self.dataSource))
            .disposed(by: rx.disposeBag)

        addButton.rx.action = viewModel.makeCreateAction()

        /// TableView에서 Memo를 선택하면 ViewModel을 통해서 detail Action을 전달하고 (선택할 Memo 필요)
        /// 선택한 Cell은 선택 해제 (indexPath가 필요)
        /// zip - 선택된 Memo와 indexPath가 튜플 형태로 방출
        Observable.zip(
            listTableView.rx.modelSelected(Memo.self),
            listTableView.rx.itemSelected
        )
            .do(onNext: { [unowned self] (_, indexPath) in
                /// do 연산자를 추가해서 next 이벤트가 전달되면 선택 상태 해제
                self.listTableView.deselectRow(at: indexPath, animated: true)
            })
                .map { $0.0 } /// 선택 상태를 처리하고 나서는 indexPath가 필요없기 때문에, map 연산자로 데이터만 방출하도록 변경
                .bind(to: viewModel.detailAction.inputs) /// 전달된 Memo를 detailAction과 Binding
                .disposed(by: rx.disposeBag)

        /// Swipe delete 모드를 활성화하고, 삭제 버튼과 Action을 Binding
        /// ControlEvent를 return -> ControlEvent는 메모를 삭제할 때마다 next 이벤트를 방출
        listTableView.rx.modelDeleted(Memo.self)
            .bind(to: viewModel.deleteAction.inputs) /// ControlEvent를 delete 이벤트와 Binding
            .disposed(by: rx.disposeBag)
    }
}
