//
//  View + Ext.swift
//  Speech Synthesizer
//
//  Created by Sergey Dolgikh on 20.11.2021.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

