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
            Color.lf6D01
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    // MARK: Search fields' labels
                    VStack {
                        SearchViewLabelImage(systemName: "figure.wave")

                        Spacer()

                        SearchViewLabelImage(systemName: "arrow.up.arrow.down")

                        Spacer()

                        SearchViewLabelImage(systemName: "mappin.and.ellipse")
                    }

                    VStack {
                        // MARK: - Starting location textfield
                        GeometryReader { reader in
                            let frame = reader.frame(in: CoordinateSpace.global)
                            TextField("Starting point", text: $startingLocation, onEditingChanged: { editing in
                                sourceStoppageEditing = editing
                            })
                            .modifier(SearchFieldModifier(suggestionMenuYOffset: $suggestionMenuYOffset, frame: frame))
                            .onChange(of: startingLocation) {
                                filterBuses()
                            }
                            .onChange(of: startingStoppage) {
                                startingLocation = startingStoppage?.title ?? startingLocation
                            }
                        }

                        Spacer()

                        // MARK: - Ending location textfield
                        GeometryReader { reader in
                            let frame = reader.frame(in: CoordinateSpace.global)
                            TextField("Ending point", text: $endingLocation, onEditingChanged: { editing in
                                destinationStoppageEditing = editing
                            })
                            .modifier(SearchFieldModifier(suggestionMenuYOffset: $suggestionMenuYOffset, frame: frame))
                            .onChange(of: endingLocation) {
                                filterBuses()
                            }
                            .onChange(of: destinationStoppage) {
                                endingLocation = destinationStoppage?.title ?? endingLocation
                            }
                        }
                    }
                }
                .frame(height: 120)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.lffD1E)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray.opacity(0.8), lineWidth: 2)
                }
                .padding()

                if filteredBuses.isEmpty {
                    if startingLocation.isEmpty || endingLocation.isEmpty {
                        Text("Enter starting and ending stoppages to find bus.")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.teal)
                            .padding()
                    } else {
                        ContentUnavailableView("No bus found", systemImage: "bus")
                    }
                } else {
                    // MARK: - Search results
                    Group {
                        Text("Search results")
                            .font(.title2)
                        Divider()
                    }
                    .padding(.horizontal, 10)

                    List(filteredBuses, id: \.self) { bus in
                        BusRowNavigationView(bus: bus)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.insetGrouped)
                }

                Spacer()
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
                            .shadow(color: .l00Dff.opacity(0.5), radius: 10)
                            .padding(.horizontal, 30)
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
}

// MARK: - Methods
extension SearchView {
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
        withAnimation(.smooth(duration: 0.2)) {
            filteredBuses = firebaseData.buses.filter { includes(stoppages: $0.stoppages) }
        }
    }

    private func includes(stoppages: [Stoppage]) -> Bool {
        return stoppages.contains { $0.name.caseInsensitiveEqual(startingLocation) }
        && stoppages.contains { $0.name.caseInsensitiveEqual(endingLocation) }
    }
}

#Preview {
    SearchView()
        .environmentObject(FirebaseData())
}
