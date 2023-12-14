//
//  AllBusList.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 14/10/23.
//

import SwiftUI

struct AllBusList: View {
    @EnvironmentObject private var firebaseData: FirebaseData

    @FocusState private var focusedOnSearch: Bool
    @State private var searchText: String = ""
    @State private var isSearching = false

    private var filteredBuses: [Bus] {
        if searchText.isEmpty {
            return firebaseData.buses
        }

        return firebaseData.buses.filter { $0.name.caseInsensitiveContains(searchText) }
    }

    private var groupedBuses: Dictionary<String, [Bus]> {
        return Dictionary(grouping: firebaseData.buses, by: { $0.name.first?.isLetter == true ? String($0.name.first!) : "#" })
    }

    var body: some View {
        ZStack {
            Color.lf6D01
                .ignoresSafeArea()

            VStack {
                // MARK: - Bus filter textfield
                HStack {
                    HStack(spacing: 5) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)

                        TextField("Filter bus by name", text: $searchText) { editing in
                            withAnimation {
                                isSearching = editing || searchText.count > 0
                            }
                        }
                        .focused($focusedOnSearch)

                        if searchText.count > 0 {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "multiply")
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.lf6D01)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray)
                    }

                    if isSearching {
                        Button("Cancel") {
                            focusedOnSearch = false
                            searchText = ""
                        }
                    }
                }
                .padding([.top, .horizontal], 20)

                // MARK: - Bus list
                if isSearching {
                    List(filteredBuses.sorted { $0.name < $1.name }) { bus in
                        BusRowNavigationView(bus: bus)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.insetGrouped)
                    .animation(.smooth, value: filteredBuses)
                } else {
                    List {
                        ForEach(groupedBuses.sorted(by: { $0.0 < $1.0 }), id: \.key) { key, buses in
                            Section {
                                ForEach(buses.sorted { $0.name < $1.name }) { bus in
                                    BusRowNavigationView(bus: bus)
                                }
                            } header: {
                                Text(key.uppercased())
                            }

                        }

                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.insetGrouped)
                }
            }
        }
    }
}

#Preview {
    AllBusList()
        .environmentObject(FirebaseData())
}
