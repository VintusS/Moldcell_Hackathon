//
//  DiezDecoding.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 17.03.2024.
//

import Foundation

struct DiezNewsArticle: Decodable {
    var Article: String
    var Image: String
    var Title: String
    var Subtitle: String
    var Description: String
}

func loadDiezArticles() -> [DiezNewsArticle] {
    guard let url = Bundle.main.url(forResource: "DiezArticles", withExtension: "json") else {
        print("JSON file not found")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let articles = try decoder.decode([DiezNewsArticle].self, from: data)
        return articles
    } catch {
        print("Failed to decode JSON: \(error)")
        return []
    }
}
