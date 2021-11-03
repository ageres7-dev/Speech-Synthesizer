//
//  Speech.swift
//  Speech Synthesizer
//
//  Created by Sergey Dolgikh on 18.10.2021.
//

import SwiftUI
import AVFoundation

struct Speech: View {
    private let synthesizer = AVSpeechSynthesizer()
    
    
    var body: some View {
        Button("speech") {
            let utterance = AVSpeechUtterance(string: "Привет")
            utterance.voice = AVSpeechSynthesisVoice(language: "ru-Ru")
            utterance.rate = 0.5
            
            synthesizer.speak(utterance)
        }
    }
}

struct Speech_Previews: PreviewProvider {
    static var previews: some View {
        Speech()
    }
}
