//
//  Speech.swift
//  Speech Synthesizer
//
//  Created by Sergey Dolgikh on 18.10.2021.
//

import SwiftUI
import AVFoundation

struct TextEntryBarView: View {
    @Binding var text: String
    var action: () -> Void
    
    var body: some View {
        
        VStack(spacing: 0) {
            Spacer()
                
                VStack(spacing: 0) {
                    Color(.systemGray5)
                        .frame(height: 1)
                        .ignoresSafeArea(.all, edges: .horizontal)
                    HStack(alignment: .bottom, spacing: 0) {
                        MultilineTextFieldView(text: $text)
                            .padding(EdgeInsets(top: 7,
                                                leading: 16,
                                                bottom: 8,
                                                trailing: 8))
                        
                        Button { action() } label: {
                            Image(systemName: "arrow.up.circle.fill") // waveform.circle.fill
                                .font(.largeTitle)
                                .frame(width: 40, height: 40)
                                .padding(EdgeInsets(top: 7,
                                                    leading: 8,
                                                    bottom: 8,
                                                    trailing: 16))
                        }
                        .disabled(text.isEmpty)
                    }
                }.background(
                    BlurView(style: .regular)
                        .ignoresSafeArea(.all, edges: .bottom)
                        .ignoresSafeArea(.all, edges: .horizontal)
                )
            
        }
    }
}

struct Speech_Previews: PreviewProvider {
    static var previews: some View {
        TextEntryBarView(text: .constant(""), action: {})
            .previewDevice("iPhone SE (2nd generation)")
            .environmentObject(SpeechService.shared)
    }
}
