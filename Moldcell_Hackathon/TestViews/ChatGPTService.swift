//
//  ChatGPTService.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 17.03.2024.
//

import Foundation

class ChatGPTService: ObservableObject {
    private let apiKey = "token"
    private let session = URLSession.shared
    // Update the endpoint if necessary. For example, if you're using OpenAI's GPT-3.5 Turbo, you might use a different endpoint
    private let endpoint = URL(string: "https://api.openai.com/v1/engines/gpt-3.5-turbo/completions")!

    func getResponse(for text: String, completion: @escaping (String) -> Void) {
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let body = [
            "prompt": text,
            "max_tokens": 500,
            // Add or update parameters as needed for the new model
        ] as [String : Any]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Error setting HTTP body: \(error)")
            return
        }

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request: \(error)")
                return
            }

            guard let data = data else {
                print("No data in response")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = json as? [String: Any], let choices = dictionary["choices"] as? [[String: Any]], let firstChoice = choices.first, let text = firstChoice["text"] as? String {
                    DispatchQueue.main.async {
                        completion(text.trimmingCharacters(in: .whitespacesAndNewlines))
                        print("ChatGPT Response: \(text)")
                    }
                } else {
                    print("Invalid response format: \(String(describing: String(data: data, encoding: .utf8)))")
                }
            } catch {
                print("Error parsing response: \(error)")
            }
        }

        task.resume()
    }
}



