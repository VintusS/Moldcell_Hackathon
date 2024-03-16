//
//  StiriMDView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI
import AVFoundation

struct StiriMDView: View {
    let articles = loadStiriMDArticles()
    private let speechSynthesizer = AVSpeechSynthesizer()
    @State private var isSpeaking = true

    var body: some View {
        List(articles, id: \.Article) { article in
            VStack(alignment: .leading) {
                Text(article.Title)
                    .font(.custom("BalooBhai-regular", size: 20))
                
                HStack {
                    Button(isSpeaking ? "Incepe sa citesti" : "Opreste citirea") {
                        if isSpeaking {
                            speakArticle(article)
                        } else {
                            speechSynthesizer.stopSpeaking(at: .immediate)
                        }
                        isSpeaking.toggle()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .font(.custom("BalooBhai-regular", size: 15))
                    .foregroundStyle(.blue)
                    
                    Spacer()
                    
                    Button("Acceseaza site-ul") {
                        if let url = URL(string: article.Article), UIApplication.shared.canOpenURL(url) {
                            DispatchQueue.main.async {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .font(.custom("BalooBhai-regular", size: 15))
                    .foregroundStyle(.blue)
                }
                
                Divider()
                
                Text(article.Subtitle)
                    .font(.custom("BalooBhai-regular", size: 15))
                    .padding(.bottom)
                
                if let imageURL = URL(string: article.Image) {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.bottom)
                }
                
                Text(article.Description)
                    .font(.custom("BalooBhai-regular", size: 15))
            }
        }
        .scrollContentBackground(.hidden)
    }
    
    private func speakArticle(_ article: NewsArticle) {
        let textToSpeak = "\(article.Title). \(article.Subtitle). \(article.Description)"
        let utterance = AVSpeechUtterance(string: textToSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "ro-RO")
        speechSynthesizer.speak(utterance)
    }
}

#Preview {
    StiriMDView()
}
