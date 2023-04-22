//
//  HeadlineResponse.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import Foundation

struct HeadlineResponse: Codable {
    let status: String
    let articles: [Article]
}

struct ArticleSource: Codable {
    let id: String
    let name: String
}

class Article: Codable {
    let source: ArticleSource
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    var content: String?
    var isSaved: Bool?
}
