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
        DWLogDebug(buses)
        if searchText.isEmpty {
            return buses
        }

        return buses.filter { $0.name.caseInsensitiveContains(searchText) }
    }

    private var groupedBuses: Dictionary<String, [Bus]> {
        return Dictionary(grouping: buses, by: { $0.name.first?.isLetter == true ? String($0.name.first!) : "*" })
    }

    var body: some View {
        Group {
            if isSearching {
                List(filteredBuses.sorted { $0.name < $1.name }) { bus in
                    // Using ZStack, EmptyView and opacity 0 to remove left arrow for NavigationLink
                    // Ref: https://thinkdiff.net/swiftui-navigationlink-hide-arrow-indicator-on-list-b842bcb78c79
                    ZStack {
                        NavigationLink {
                            BusDetailView(bus: bus)
                                .toolbar(.hidden, for: .tabBar)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0)
                        .alignmentGuide(.listRowSeparatorLeading) { dimension in
                            dimension[.leading]
                        }

                        BusRow(bus: bus)
                    }
                }
                .listRowBackground(Color.lffD1E)
                .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                .listStyle(.insetGrouped)
            } else {
                List {
                    ForEach(groupedBuses.sorted(by: { $0.0 < $1.0 }), id: \.key) { key, buses in
                        Section {
                            ForEach(buses.sorted { $0.name < $1.name }) { bus in
                                ZStack {
                                    NavigationLink {
                                        BusDetailView(bus: bus)
                                            .toolbar(.hidden, for: .tabBar)
                                    } label: {
                                        EmptyView()
                                    }
                                    .opacity(0)
                                    .alignmentGuide(.listRowSeparatorLeading) { dimension in
                                        dimension[.leading]
                                    }

                                    BusRow(bus: bus)
                                }
                            }
                        } header: {
                            Text(key.uppercased())
                        }

                    }
                }
                .listRowBackground(Color.lffD1E)
                .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                .listStyle(.insetGrouped)
            }
        }
        .background(.lf6D01)
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
