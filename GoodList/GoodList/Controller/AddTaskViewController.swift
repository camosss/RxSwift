//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by 강호성 on 2021/12/08.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Action
    
    @IBAction func save() {
        // 여기서 선택한 우선순위를 TaskListVC의 우선순위 표시를 위한 task 전달을 하기 위해 rxswift 사용
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex), let title = self.taskTitleTextField.text else { return }
    }
}
