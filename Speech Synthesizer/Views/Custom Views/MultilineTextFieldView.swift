//
//  MultilineTextFieldView.swift
//  Speech Synthesizer
//
//  Created by Sergey Dolgikh on 10.11.2021.
//

import SwiftUI

struct DynamicHeightTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var height: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.isScrollEnabled = true
        textView.alwaysBounceVertical = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        
//        textView.font = .systemFont(ofSize: 20)
        textView.font = .preferredFont(forTextStyle: .body)
        
        textView.text = text
        textView.backgroundColor = UIColor.clear
        
        context.coordinator.textView = textView
        textView.delegate = context.coordinator
        textView.layoutManager.delegate = context.coordinator

        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    
    func makeCoordinator() -> Coordinator {
        return Coordinator(dynamicSizeTextField: self)
    }
}

class Coordinator: NSObject, UITextViewDelegate, NSLayoutManagerDelegate {
    
    var dynamicHeightTextField: DynamicHeightTextField
    
    weak var textView: UITextView?

    
    init(dynamicSizeTextField: DynamicHeightTextField) {
        self.dynamicHeightTextField = dynamicSizeTextField
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.dynamicHeightTextField.text = textView.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func layoutManager(_ layoutManager: NSLayoutManager, didCompleteLayoutFor textContainer: NSTextContainer?, atEnd layoutFinishedFlag: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            guard let textView = self?.textView else {
                return
            }
            let size = textView.sizeThatFits(textView.bounds.size)
            if self?.dynamicHeightTextField.height != size.height {
                self?.dynamicHeightTextField.height = size.height
            }
        }

    }
}


struct MultilineTextFieldView: View {
    
    @Binding var text: String
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var textHeight: CGFloat = 0
    

    var body: some View {
        ZStack(alignment: .leading) {
            Color(UIColor.systemBackground)
//            Color(UIColor.systemBackground)
//                .opacity(0.9)
            
            if text.isEmpty {
                Text("Enter text to speak")
                    .font(.body)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(10)
            }
            
            DynamicHeightTextField(text: $text, height: $textHeight)
                .padding(.leading, 4)
                .padding(.trailing, 2)

        }
        
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .frame(height: textFieldHeight)
//        .onRotate { newOrientation in
//            print("высота", UIScreen.main.bounds.height)
//            orientation = newOrientation
//        }

    }
}

extension MultilineTextFieldView {
    
    private var textFieldHeight: CGFloat {
        let screenSize = UIScreen.main.bounds
        let isPortrait = screenSize.width < screenSize.height
        
        let minHeight: CGFloat = 40
        let maxHeight: CGFloat = isPortrait
        ? screenSize.height * 0.4
        : screenSize.height * 0.25
        
        if textHeight < minHeight {
            return minHeight
        }
        
        if textHeight > maxHeight {
            return maxHeight
        }
        
        return textHeight
    }
}

struct ContentTextView_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextFieldView(text: .constant(""))
            .preferredColorScheme(.light)
    }
}
