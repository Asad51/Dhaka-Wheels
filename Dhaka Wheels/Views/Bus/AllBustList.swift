//
//  AllBustList.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 14/10/23.
//

import SwiftUI

struct AllBustList: View {
    @EnvironmentObject private var firebaseData: FirebaseData

    @State private var searchText: String = ""

    private var filteredBuses: [Bus] {
        if searchText.isEmpty {
            return firebaseData.buses
        }
        
        return firebaseData.buses
            .filter { $0.name.caseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationStack {
            List(filteredBuses) { bus in
                NavigationLink {
                    BusDetailView(bus: bus)
                        .toolbar(.hidden, for: .tabBar)
                } label: {
                    BusRow(bus: bus)
                }
            }
            .listStyle(.inset)
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    AllBustList()
        .environmentObject(FirebaseData())
}
