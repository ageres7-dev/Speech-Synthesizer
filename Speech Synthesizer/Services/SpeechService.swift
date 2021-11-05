//
//  SpeechService.swift
//  Speech Synthesizer
//
//  Created by Sergey Dolgikh on 06.11.2021.
//

import AVFoundation
import UIKit
import Combine

class SpeechService: NSObject, ObservableObject {
    
    static var shared = SpeechService()
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var nowSpeaking = NSMutableAttributedString() {
        willSet { objectWillChange.send() }
    }
    
    var rate: Float = 0.5
    var pitchMultiplier: Float = 1
//    var volume: Float = 0.5
//    var preUtteranceDelay: TimeInterval = 0
//    var postUtteranceDelay: TimeInterval = 0
    
    var selectedVoice: AVSpeechSynthesisVoice?
    
    var availableVoices: [AVSpeechSynthesisVoice] {
        AVSpeechSynthesisVoice.speechVoices()
    }
    
    private let speechSynthesizer = AVSpeechSynthesizer()
//    private var utterance: AVSpeechUtterance?
    
    private override init () {
        super.init()
        speechSynthesizer.delegate = self
    }
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = selectedVoice
        utterance.rate = rate
        utterance.pitchMultiplier = pitchMultiplier
        
        speechSynthesizer.speak(utterance)
    }
    
    func setAudioCategoryToPlayback() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }
    
}

extension SpeechService: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(.foregroundColor,
                                             value: UIColor.red,
                                             range: characterRange)
        
        nowSpeaking = mutableAttributedString
    }
    
}
