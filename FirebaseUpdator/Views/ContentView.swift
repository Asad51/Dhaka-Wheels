//
//  ContentView.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 15/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var firebaseData: FirebaseData

    var body: some View {
        NavigationStack {
            NavigationLink {
                AddBus()
                    .environmentObject(firebaseData)
            } label: {
                Text("Add bus")
            }

            NavigationLink {
                AddStoppage()
                    .environmentObject(firebaseData)
            } label: {
                Text("Add Stoppage")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FirebaseData())
}
