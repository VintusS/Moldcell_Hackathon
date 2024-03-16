//
//  StiriMDDecoding.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import Foundation

struct NewsArticle: Decodable {
    var Article: String
    var Image: String
    var Title: String
    var Subtitle: String
    var Description: String
}

func loadStiriMDArticles() -> [NewsArticle] {
    guard let url = Bundle.main.url(forResource: "StiriMDArticles", withExtension: "json") else {
        fatalError("JSON file not found")
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let articles = try decoder.decode([NewsArticle].self, from: data)
        return articles
    } catch {
        fatalError("Failed to decode JSON: \(error)")
    }
}
