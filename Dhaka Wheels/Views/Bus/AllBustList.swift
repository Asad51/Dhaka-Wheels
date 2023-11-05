//
//  AllBustList.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 14/10/23.
//

import SwiftUI

struct BusList: View {
    @Environment(\.isSearching) private var isSearching

    @State var buses: [Bus]
    var searchText: String

    private var filteredBuses: [Bus] {
        if searchText.isEmpty {
            return buses
        }

        return buses.filter { $0.name.caseInsensitiveContains(searchText) }
    }

    private var groupedBuses: Dictionary<String, [Bus]> {
        return Dictionary(grouping: buses, by: { $0.name.first?.isLetter == true ? String($0.name.first!) : "*" })
    }

    var body: some View {
        VStack {
            if isSearching {
                List(filteredBuses.sorted { $0.name < $1.name }) { bus in
                    NavigationLink {
                        BusDetailView(bus: bus)
                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        BusRow(bus: bus)
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            } else {
                List {
                    ForEach(groupedBuses.sorted(by: { $0.0 < $1.0 }), id: \.key) { key, buses in
                        Section {
                            ForEach(buses.sorted { $0.name < $1.name }) { bus in
                                NavigationLink {
                                    BusDetailView(bus: bus)
                                        .toolbar(.hidden, for: .tabBar)
                                } label: {
                                    BusRow(bus: bus)
                                }
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }
                        } header: {
                            Text(key.uppercased())
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.inset)
            }
        }
    }
}

struct AllBustList: View {
    @EnvironmentObject private var firebaseData: FirebaseData

    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            BusList(buses: firebaseData.buses, searchText: searchText)
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    AllBustList()
        .environmentObject(FirebaseData())
}
