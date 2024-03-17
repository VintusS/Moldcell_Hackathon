//
//  AssistantQADecoder.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 17.03.2024.
//

import Foundation

// Define a struct that conforms to Decodable
struct FAQ: Decodable {
    var question: String
    var answer: String
}

func loadFAQs() -> [FAQ] {
    guard let url = Bundle.main.url(forResource: "AssistantQA", withExtension: "json") else {
        fatalError("FAQs JSON file not found")
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let faqs = try decoder.decode([FAQ].self, from: data)
        return faqs
    } catch {
        fatalError("Failed to decode FAQs JSON: \(error)")
    }
}

