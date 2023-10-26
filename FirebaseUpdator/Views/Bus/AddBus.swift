//
//  AddBus.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 15/10/23.
//

import SwiftUI

struct AddBus: View {
    @EnvironmentObject private var firebaseData: FirebaseData

    // MARK: Input values container
    @State private var name: String = ""
    @State private var routeNumber: String = "N/A"
    @State private var coachType: String = "Non-AC"
    @State private var serviceType: String = "Sitting"
    @State private var stoppageName: String = ""
    @State private var stoppages: [Stoppage]  = []

    // MARK: Error handling variables
    @State private var validationError = ""
    @State private var showValidationError = false

    // MARK: miValues for showing suggestions
    @State private var busNameEditing = false
    @State private var stoppageNameEditing = false
    @State private var suggestionMenuYOffset = 0.0
    @State private var navbarHeight = 0.0
    @State private var selectedSuggestion: Suggestion?

    // TODO: Static values, to be changed later
    private var coachTypes: [String] = ["Non-AC", "AC"]
    private var serviceTypes: [String] = ["Sitting", "Semi Sitting", "Local"]

    private func showBusSuggestions() -> Bool {
        return busNameEditing && name.trimmingCharacters(in: .whitespaces).count > 2
    }

    private func showStoppageSuggestions() -> Bool {
        return stoppageNameEditing && stoppageName.trimmingCharacters(in: .whitespaces).count > 2
    }

    private func showSuggestions() -> Bool {
        return showBusSuggestions() || showStoppageSuggestions()
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            VStack {
                // MARK: - Bus name input field
                GeometryReader { reader in
                    let frame = reader.frame(in: CoordinateSpace.global)
                    
                    HStack {
                        Text("Name :")

                        TextField("Bus name", text: $name, onEditingChanged: { editing in
                            busNameEditing = editing
                        })
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        }
                        .autocorrectionDisabled()
                        .onTapGesture {
                            suggestionMenuYOffset = frame.origin.y
                        }
                    }
                }
                .frame(height: 30)
                .padding(.vertical, 15)

                // MARK: - Bus info fields
                HStack {
                    Text("Route No: ")
                    
                    TextField("Route number", text: $routeNumber)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        }
                }
                .padding(.vertical, 15)

                HStack {
                    Text("Coach Type : ")
                    
                    Spacer()
                    
                    Picker("Coach Type", selection: $coachType) {
                        ForEach(coachTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                HStack {
                    Text("Service Type: ")
                    
                    Picker("Service Type", selection: $serviceType) {
                        ForEach(serviceTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Spacer()
                }
                .frame(height: 30)
                .padding(.vertical, 15)

                // MARK: Stoppage name field and add button
                GeometryReader { reader in
                    let frame = reader.frame(in: CoordinateSpace.global)
                    HStack {
                        Text("Search Stoppage: ")

                        TextField("Stoppage name", text: $stoppageName, onEditingChanged: { editing in
                            stoppageNameEditing = editing
                        })
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        }
                        .autocorrectionDisabled()
                        .onTapGesture {
                            suggestionMenuYOffset = frame.origin.y
                        }
                        .onChange(of: selectedSuggestion) {
                            if let suggestion = selectedSuggestion, let stop = firebaseData.stoppages[suggestion.id] {
                                stoppageName = stop.name
                            }
                        }

                        Button {
                            if let suggestion = selectedSuggestion, let stop = firebaseData.stoppages[suggestion.id] {
                                if !stoppages.contains(where: { $0.id == stop.id}) {
                                    stoppages.append(stop)
                                } else {
                                    validationError = "Already selected"
                                    showValidationError = true
                                }

                                stoppageName = ""
                            }
                        } label: {
                            Image(systemName: "plus.square")
                                .resizable()
                                .font(.title)
                                .frame(width: 30, height: 30)
                        }
                        .onChange(of: selectedSuggestion) {
                            if let suggestion = selectedSuggestion, stoppageNameEditing {
                                stoppageName = suggestion.title
                            }
                        }
                    }
                }
                .frame(height: 30)
                .padding(.bottom, 30)

                HStack {
                    Text("Selected Stoppages : ")

                    Spacer()
                }
                .padding(.top, 10)

                // MARK: Selected stoppages list for creating new bus
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 60, maximum: 150)), GridItem(.flexible(minimum: 60, maximum: 150)), GridItem(.flexible(minimum: 60, maximum: 150))], content: {
                        ForEach(stoppages) { stoppage in
                            SelectedStoppage(stoppages: $stoppages, stoppage: stoppage)
                                .padding(.top, 10)
                        }
                    })
                    .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 1)
                )

                Spacer()
            }
            .toolbar {
                // MARK: - Save bus, toolbar button
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        validationError = validateBusData()
                        if validationError.isEmpty {
                            firebaseData.addBus(name: name, routeNumber: routeNumber, coachType: coachType, serviceType: serviceType, stoppages: stoppages)

                            name = ""
                            routeNumber = "N/A"
                            stoppages.removeAll()
                        } else {
                            showValidationError = true
                        }
                    } label: {
                        Text("Save")
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
                    .alert(validationError, isPresented: $showValidationError) {
                    }
                }

                // To center the text of previous item
                // https://stackoverflow.com/questions/63441821/right-aligning-a-bottombar-toolbaritem-in-swiftui-for-ios-14
                ToolbarItem(placement: .topBarTrailing) {
                    Spacer()
                }
            }

            // MARK: Show suggestions menu
            if showSuggestions() {
                let suggestions = Binding<[Suggestion]>  {
                    createSuggestions()
                } set: { _, _ in
                }

                if !suggestions.isEmpty {
                    VStack {
                        SuggestionMenuView(suggestions: suggestions, selected: $selectedSuggestion)
                            .offset(y: suggestionMenuYOffset - navbarHeight)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                                    .offset(y: suggestionMenuYOffset - navbarHeight)
                            )
                            .shadow(color: .gray, radius: 20)
                            .padding(.horizontal, 30)
                        Spacer()
                    }
                    .background(NavbarAccessor { navbar in
                        navbarHeight = navbar.bounds.height
                    })
                }
            }
        }
        .navigationTitle("Bus Details")
        .padding()
    }

    ///
    /// Create suggestions based on the textfield editing
    ///
    ///  - Returns: Returns a list filtered items
    ///
    private func createSuggestions() -> [Suggestion] {
        var suggestions = [Suggestion]()
        if showBusSuggestions() {
            suggestions = firebaseData.buses
                .filter { $0.name.caseInsensitiveContains(name) }
                .map {
                    Suggestion(
                        id: $0.id,
                        title: $0.name,
                        subTitle: "\($0.stoppages.first?.name ?? "") <-> \($0.stoppages.last?.name ?? "")".capitalized
                    )
                }
        } else {
            suggestions = firebaseData.stoppages
                .filter { $0.value.name.caseInsensitiveContains(stoppageName) }
                .map { id, stop in
                    Suggestion(
                        id: id,
                        title: stop.name,
                        subTitle: "(\(stop.latitude.rounded(to: 4)), \(stop.longitude.rounded(to: 4)))"
                    )
                }
        }
        return suggestions
    }

    ///
    /// Returns a error or empty string after validating input data
    ///
    private func validateBusData() -> String {
        if name.isEmpty {
            return "Please enter bus name"
        }
        
        if routeNumber.isEmpty {
            return "Please enter bus route number"
        }

        if coachType.isEmpty {
            return "Please select coach type"
        }

        if stoppages.count < 2 {
            return "Plese select at least two stoppages"
        }

        if firebaseData.buses.filter({ $0.name == name && $0.stoppages.first == stoppages.first && $0.stoppages.last == stoppages.last }).count > 0 {
            return "The bus is already exist"
        }

        return ""
    }
}

#Preview {
    AddBus()
        .environmentObject(FirebaseData())
}
