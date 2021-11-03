//
//  TabBar.swift
//  Speech Synthesizer
//
//  Created by Sergey Dolgikh on 18.10.2021.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Speech()
                .tabItem {
                    Label("Speech", systemImage: "waveform.circle")
                }
            
            ContentView()
                .tabItem {
                    Label("List", systemImage: "tray.2")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
