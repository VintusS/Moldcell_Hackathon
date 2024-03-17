//
//  resultView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 17.03.2024.
//

import SwiftUI

struct resultView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @StateObject private var textToSpeechConverter = TextToSpeechConverter()
    @StateObject private var chatGPTService = ChatGPTService()

    var body: some View {
        VStack {
            Text(speechRecognizer.recognizedText)
            Button(action: {
            }, label: {
                Text("Hold to Speak")
            })
            .onLongPressGesture(minimumDuration: 0.1, pressing: { pressing in
                if pressing {
                    try? speechRecognizer.startRecording()
                } else {
                    print(speechRecognizer.recognizedText)
                    speechRecognizer.stopRecording()
                    chatGPTService.getResponse(for: speechRecognizer.recognizedText) { response in
                        textToSpeechConverter.speak(text: response)
                    }
                }
            }, perform: {})
        }
    }
}


#Preview {
    resultView()
}
