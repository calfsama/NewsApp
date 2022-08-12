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
    let id, name: String?
    let url: String?
    let category: String?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case url, category, language
    }
}


