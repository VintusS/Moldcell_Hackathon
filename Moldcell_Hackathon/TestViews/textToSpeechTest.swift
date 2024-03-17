//
//  textToSpeechTest.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI
import AVFoundation

struct textToSpeechTest: View {
    private var speechSynthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack {
            Button("Speak") {
                self.speakText("Salut, cristi pidar!")
            }
        }
    }
    
    func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ro-RO")
        speechSynthesizer.speak(utterance)
    }
}

#Preview {
    textToSpeechTest()
}
