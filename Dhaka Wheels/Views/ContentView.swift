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
    @State private var displayConnectionAlert = false

    var reachability = Reachability.shared

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    Group {
                        SearchView()
                            .tabItem {
                                Label("Search", systemImage: "magnifyingglass")
                            }
                            .tag(0)

                        AllBusList()
                            .tabItem {
                                Label("Bus list", systemImage: "list.bullet.circle.fill")
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
            .navigationTitle("Dhaka wheels")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            reachability.startMonitoring()
        }
        .onReceive(reachability.isNetworkConnected, perform: { connected in
            if connected {
                Task {
                    await firebaseData.fetchData()
                }
                reachability.stopMonitoring()
            } else {
                displayConnectionAlert = true
            }
        })
        .alert("Connection Required", isPresented: $displayConnectionAlert) {} message: {
            Text("Please connect to internet to download data from the server.")
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
