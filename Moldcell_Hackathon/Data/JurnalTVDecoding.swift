//
//  JurnalTVDecoding.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 17.03.2024.
//

import Foundation

struct JurnalNewsArticle: Decodable {
    var Article: String
    var Image: String
    var Title: String
    var Subtitle: String
    var Description: String
}

func loadJurnalTVArticles() -> [JurnalNewsArticle] {
    guard let url = Bundle.main.url(forResource: "JurnalTVArticles", withExtension: "json") else {
        print("JSON file not found")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let articles = try decoder.decode([JurnalNewsArticle].self, from: data)
        return articles
    } catch {
        print("Failed to decode JSON: \(error)")
        return []
    }
}


