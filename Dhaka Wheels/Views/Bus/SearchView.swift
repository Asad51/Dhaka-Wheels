    //
    //  SearchView.swift
    //  Dhaka Wheels
    //
    //  Created by Md. Asadul Islam on 12/10/23.
    //

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var firebaseData: FirebaseData

    @State private var startingLocation: String = ""
    @State private var endingLocation: String = ""
    @State private var filteredBuses = [Bus]()

    @State private var sourceStoppageEditing = false
    @State private var destinationStoppageEditing = false
    @State private var suggestionMenuYOffset = 0.0
    @State private var startingStoppage: Suggestion?
    @State private var destinationStoppage: Suggestion?

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            Image(systemName: "figure.wave")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 40)
                                .padding(.trailing, 5)

                            Spacer()

                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 40)
                                .padding(.trailing, 5)
                        }

                        VStack {
                            // MARK: - Starting location textfield
                            GeometryReader { reader in
                                let frame = reader.frame(in: CoordinateSpace.global)
                                TextField("Starting point", text: $startingLocation, onEditingChanged: { editing in
                                    sourceStoppageEditing = editing
                                })
                                .padding()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray)
                                }
                                .onTapGesture {
                                    suggestionMenuYOffset = frame.origin.y
                                }
                                .onChange(of: startingStoppage) {
                                    startingLocation = startingStoppage?.title ?? startingLocation
                                    filterBuses()
                                }
                            }

                            Spacer()

                            // MARK: - Ending location textfield
                            GeometryReader { reader in
                                let frame = reader.frame(in: CoordinateSpace.global)
                                TextField("Ending point", text: $endingLocation, onEditingChanged: { editing in
                                    destinationStoppageEditing = editing
                                })
                                .padding()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray)
                                }
                                .onTapGesture {
                                    suggestionMenuYOffset = frame.origin.y
                                }
                                .onChange(of: destinationStoppage) {
                                    endingLocation = destinationStoppage?.title ?? endingLocation
                                    filterBuses()
                                }
                            }
                        }
                    }
                    .frame(height: 120)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 2)
                    }

                    if filteredBuses.isEmpty {
                        Text("No buses found.")
                            .font(.title)
                            .foregroundStyle(.teal)
                            .padding(.top, 20)
                    } else {
                        Text("Search results")
                            .font(.title2)

                        // MARK: - Search results
                        List(filteredBuses, id: \.self) { bus in
                            NavigationLink {
                                BusDetailView(bus: bus)
                                    .toolbar(.hidden, for: .tabBar)
                            } label: {
                                BusRow(bus: bus)
                            }
                        }
                        .listStyle(.inset)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray, lineWidth: 2)
                        }
                    }

                    Spacer()
                }
                .padding()
            }

            // MARK: - Suggestion menu
            if showSuggestions() {
                let suggestions = Binding<[Suggestion]>  {
                    createSuggestions()
                } set: { _, _ in
                }

                if !suggestions.isEmpty {
                    VStack {
                        SuggestionMenuView(suggestions: suggestions, selected: sourceStoppageEditing ? $startingStoppage : $destinationStoppage)
                            .offset(y: suggestionMenuYOffset)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                                    .offset(y: suggestionMenuYOffset)
                            )
                            .shadow(color: .gray, radius: 20)
                            .padding(.horizontal, 30)
                    }
                }
            }
        }
    }

    private func showSuggestions() -> Bool {
        return sourceStoppageEditing || destinationStoppageEditing
    }

    private func createSuggestions() -> [Suggestion] {
        let filterText = sourceStoppageEditing ? startingLocation : endingLocation

        return firebaseData.stoppages
            .filter { $0.value.name.caseInsensitiveContains(filterText) }
            .map {
                Suggestion(
                    id: $0.key,
                    title: $0.value.name,
                    subTitle: ""
                )
            }
    }

    private func filterBuses() {
        filteredBuses = firebaseData.buses.filter { contains(stoppages: $0.stoppages) }
    }

    private func contains(stoppages: [Stoppage]) -> Bool {
        return stoppages.contains(where: { $0.name.caseInsensitiveEqual(startingLocation) }) && stoppages.contains(where: { $0.name.caseInsensitiveContains(endingLocation) })
    }
}

#Preview {
    SearchView()
        .environmentObject(FirebaseData())
}
