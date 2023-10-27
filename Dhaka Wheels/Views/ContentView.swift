//
//  ContentView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .top) {
            TabView {
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }

                AllBustList()
                    .tabItem {
                        Label("All Bus", systemImage: "list.bullet.circle.fill")
                    }
            }
            .onAppear {
                UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
            }
        }
    }
}

#Preview {
    ContentView()
}
