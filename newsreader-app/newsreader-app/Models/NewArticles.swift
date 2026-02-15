//
//  NewArticles.swift
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewArticles]
}

struct NewArticles: Codable, Identifiable {
    var id = UUID()
    let source: Source
    let title: String
    let description: String?
    let author: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    init(source: Source, title: String, description: String?, author: String?, url: String, urlToImage: String?, publishedAt: String?, content: String?) {
        self.source = source
        self.title = title
        self.description = description
        self.author = author
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}


struct Source: Codable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

