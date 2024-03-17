//
//  AssistantView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 17.03.2024.
//

import SwiftUI
import AVFoundation

struct AssistantView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @StateObject private var textToSpeechConverter = TextToSpeechConverter()
    @State private var isListening = false
    @State private var isSpeaking = false
    @State private var pulse = false
    let faqs: [FAQ] = loadFAQs()

    var body: some View {
        VStack {
            Text("Iti introducem asistentul SilverLink")
                .font(.custom("BalooBhai-regular", size: 35))
                .multilineTextAlignment(.center)
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 200, height: 200)
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 10)
                            .scaleEffect(pulse ? 1.1 : 1)
                            .opacity(pulse ? 0 : 1)
                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: pulse)
                    )
                    .onAppear { pulse.toggle() }
                    .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                        if pressing {
                            isListening = true
                            pulse = true
                            configureAudioSession()
                            try? speechRecognizer.startRecording()
                        } else {
                            isListening = false
                            pulse = false
                            speechRecognizer.stopRecording()
                            processText(speechRecognizer.recognizedText)
                        }
                    }, perform: {})
                
                Text(isListening ? "Ascult..." : "Tine apasat pentru a vorbi")
                    .multilineTextAlignment(.center)
                    .frame(width: 170)
                    .lineLimit(4)
                    .foregroundColor(.white)
                    .animation(.easeInOut, value: isListening)
                    .font(.custom("BalooBhai-regular", size: 20))
            }
            Spacer()
        }
    }
    
    private func configureAudioSession() {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .mixWithOthers])
                try audioSession.setActive(true)
            } catch {
                print("Failed to configure audio session: \(error)")
            }
        }

    private func processText(_ text: String) {
        let response = faqs.first(where: { faq in
            text.localizedCaseInsensitiveContains(faq.question)
        })?.answer ?? (text.isEmpty ? "Nu înțeleg exact ce vrei să spui." : "Poți repeta, te rog?")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.textToSpeechConverter.speak(text: response)
        }
    }

}

#Preview {
    AssistantView()
}
