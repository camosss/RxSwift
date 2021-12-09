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
    let description: String
}
