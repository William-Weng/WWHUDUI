//
//  ContentView.swift
//  Example
//
//  Created by William.Weng on 2026/6/30.
//

import SwiftUI
import WWHUDUI

struct ContentView: View {

    @State private var hud = WWHUDUI()

    var body: some View {
        
        VStack(spacing: 20) {
            
            Button("Start Loading") {
                hud.display("Loading data...")

                Task {
                    try? await Task.sleep(for: .seconds(1.2))
                    hud.dismiss(minimumVisibleDuration: 0.3)
                }
            }
        }
        .loadingOverlay(hud)
    }
}

#Preview {
    ContentView()
}
