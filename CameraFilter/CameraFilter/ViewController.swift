//
//  ViewController.swift
//  CameraFilter
//
//  Created by 강호성 on 2021/12/05.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
                let photoCVC = navC.viewControllers.first as? PhotoCollectionViewController else { fatalError("Segue destination is not found") }
        
        // subscribe
        photoCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            self?.photoImageView.image = photo
        }).disposed(by: disposeBag)
    }
    

}

