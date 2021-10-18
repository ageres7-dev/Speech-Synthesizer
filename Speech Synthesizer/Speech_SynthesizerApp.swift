//
//  Speech_SynthesizerApp.swift
//  Speech Synthesizer
//
//  Created by Sergey Dolgikh on 18.10.2021.
//

import SwiftUI

@main
struct Speech_SynthesizerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
