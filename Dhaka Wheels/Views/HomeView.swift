//
//  HomeView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            SearchView(buses: Constants.previewBuses)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            AllBustList(buses: Constants.previewBuses.sorted { $0.name < $1.name })
                .tabItem {
                    Label("All Bus", systemImage: "list.bullet.circle.fill")
                }
        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
    }
}

#Preview {
    HomeView()
}
