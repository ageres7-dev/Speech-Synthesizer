//
//  BlurView.swift
//  Speech Synthesizer
//
//  Created by Sergey Dolgikh on 18.11.2021.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemThinMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.red)
                    .overlay(Circle().foregroundColor(.green))
                Circle()
                    .foregroundColor(.red)
            }
            VStack {
                BlurView(style: .systemThinMaterial)
                BlurView(style: .regular)
                BlurView(style: .systemUltraThinMaterial)
                BlurView(style: .systemChromeMaterial)
            }
        }
        .preferredColorScheme(.dark)
    }
}
