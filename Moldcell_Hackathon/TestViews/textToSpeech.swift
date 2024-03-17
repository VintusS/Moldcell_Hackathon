//
//  textToSpeech.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 17.03.2024.
//

import AVFoundation

class TextToSpeechConverter: ObservableObject {
    private let speechSynthesizer = AVSpeechSynthesizer()

    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ro-RO")
        speechSynthesizer.speak(utterance)
    }
}


