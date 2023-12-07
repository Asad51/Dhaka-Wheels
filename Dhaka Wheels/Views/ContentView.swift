//
//  ContentView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var firebaseData: FirebaseData
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag(0)

                AllBustList()
                    .tabItem {
                        Label("All Bus", systemImage: "list.bullet.circle.fill")
                    }
                    .tag(1)
            }
            .environmentObject(firebaseData)
            .highPriorityGesture(DragGesture().onEnded { handleSwipe(translation: $0.translation.width) })
        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
    }

    private func handleSwipe(translation: CGFloat) {
        let minDragTranslation = 100.0

        if translation > minDragTranslation {
            selectedTab = max(0, selectedTab - 1)
        } else if translation < -minDragTranslation {
            selectedTab = min(selectedTab + 1, 1)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FirebaseData())
}
