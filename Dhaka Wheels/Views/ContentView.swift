//
//  ContentView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var firebaseData: FirebaseData

    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environmentObject(firebaseData)

            AllBustList()
                .tabItem {
                    Label("All Bus", systemImage: "list.bullet.circle.fill")
                }
                .environmentObject(firebaseData)
        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FirebaseData())
}
