//
//  News.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 28/07/22.
//

import Foundation


// MARK: - Artcles

struct Articles: Codable {
   // let status: String?
    var totalResults: Int?
    var articles: [Article]?
}

// MARK: - Article

struct Article: Codable {
    let source: Source?
    var title: String?
    let url: String?
    let urlToImage: String?


    enum CodingKeys: String, CodingKey {
        case title, source
        case urlToImage, url
    }
}


