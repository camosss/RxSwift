//
//  Article.swift
//  GoodNews
//
//  Created by 강호성 on 2021/12/10.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}

extension ArticlesList {
    static var all: Resource<ArticlesList> = {
       let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=58b182a8b7b84af4a1ae6d8dd6c7358c")!
        return Resource(url: url)
    }()
}
