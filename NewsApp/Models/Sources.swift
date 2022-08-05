//
//  Sources.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 04/08/22.
//

import Foundation

// MARK: - SourcesArticle
struct Sources: Codable {
    let status: String?
    let sources: [Source]?
}

// MARK: - Source
struct Source: Codable {
    let id, name, sourceDescription: String?
    let url: String?
    let category: String?
    let language, country: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}


//enum Category: String, Codable {
//    case business = "business"
//    case entertainment = "entertainment"
//    case general = "general"
//    case health = "health"
//    case science = "science"
//    case sports = "sports"
//    case technology = "technology"
//}

