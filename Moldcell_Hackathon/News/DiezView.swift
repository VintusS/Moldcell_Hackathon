//
//  DiezView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI
import AVFoundation

struct DiezView: View {
    let articles = loadDiezArticles()
    private let speechSynthesizer = AVSpeechSynthesizer()
    @State private var isSpeaking = false
    @State private var selectedArticleIndex = 0

    var body: some View {
        NavigationView {
            TabView(selection: $selectedArticleIndex) {
                ForEach(articles.indices, id: \.self) { index in
                    ScrollView {
                        VStack {
                            articleContent(for: articles[index])

                            GeometryReader { geometry -> Color in
                                DispatchQueue.main.async {
                                    let scrollY = geometry.frame(in: .global).minY
                                    if scrollY < 0 && abs(scrollY) > geometry.size.height * 0.1 {
                                        if selectedArticleIndex < articles.count - 1 {
                                            selectedArticleIndex += 1
                                        }
                                    }
                                }
                                return Color.clear
                            }.frame(height: 1)
                        }
                        .padding(.bottom, 100)
                        .padding([.leading, .trailing], 10)
                        .frame(width: UIScreen.main.bounds.width)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Diez.md")
                        .font(.custom("BalooBhai-regular", size: 25))
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, -50)
        }
    }

    private func articleContent(for article: DiezNewsArticle) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(article.Title)
                .font(.custom("BalooBhai-regular", size: 20))
            
            speakButton(for: article)
            
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

    private func speakButton(for article: DiezNewsArticle) -> some View {
        HStack {
            Button(isSpeaking ? "Opreste citirea" : "Incepe sa citesti") {
                if isSpeaking {
                    speechSynthesizer.stopSpeaking(at: .immediate)
                } else {
                    speakArticle(article)
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
    }

    private func speakArticle(_ article: DiezNewsArticle) {
        let textToSpeak = "\(article.Title). \(article.Subtitle). \(article.Description)"
        let utterance = AVSpeechUtterance(string: textToSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "ro-RO")
        speechSynthesizer.speak(utterance)
    }
}

struct DiezView_Previews: PreviewProvider {
    static var previews: some View {
        DiezView()
    }
}

