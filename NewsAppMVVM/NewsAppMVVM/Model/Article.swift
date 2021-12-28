//
//  Article.swift
//  NewsAppMVVM
//
//  Created by 강호성 on 2021/12/28.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
