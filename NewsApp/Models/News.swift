//
//  News.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 28/07/22.
//

import Foundation


//struct News: Codable {
//    var totalResults: Int?
//    var articles: [Articles]?
//}
//
//
//struct Articles: Codable {
//    var source: [Source]?
//    var author: String?
//    var title: String?
//    var description: String?
//    var urlToImage: String?
//    var publishedAt: String?
//    var content: String?
//}
//
//struct Source: Codable {
//    var id: Int?
//    var name: String?
//
//}


// MARK: - Artcles
struct Articles: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case title, author, source
        case articleDescription = "description"
        case url, urlToImage, content, publishedAt
    }
}

// MARK: - Source
struct Source: Codable {
    let id: ID?
    let name: String?
}

enum ID: String, Codable {
    case businessInsider = "business-insider"
    case cnn = "cnn"
    case engadget = "engadget"
    case reuters = "reuters"
    case theVerge = "the-verge"
    case time = "time"
    case wired = "wired"
}
