//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by 강호성 on 2021/12/10.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    private var articles = [Article]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    // MARK: - Helper
    
    private func populateNews() {
        URLRequest.load(resource: ArticlesList.all)
            .subscribe(onNext: { [weak self] result in
                if let result = result {
                    self?.articles = result.articles
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension NewsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.titleLabel.text = self.articles[indexPath.row].title
        cell.descriptionLabel.text = self.articles[indexPath.row].description
        return cell
    }
}
