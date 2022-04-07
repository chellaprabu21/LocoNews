//
//  News.swift
//  LocoNews
//
//  Created by Chellaprabu V on 06/04/22.
//

import Foundation

// MARK: - News
struct News: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String
    let url: String
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
