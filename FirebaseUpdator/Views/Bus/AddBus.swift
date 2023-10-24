//
//  AddBus.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 15/10/23.
//

import SwiftUI

struct AddBus: View {
    @EnvironmentObject private var firebaseData: FirebaseData

    // Input values container
    @State private var name: String = ""
    @State private var routeNumber: String = "N/A"
    @State private var coachType: String = "Non-AC"
    @State private var serviceType: String = "Sitting"
    @State private var stoppageName: String = ""
    @State private var stoppages: [Stoppage]  = []

    // Error handling variables
    @State private var validationError = ""
    @State private var showValidationError = false

    // Values for showing suggestions
    @State private var busNameEditing = false
    @State private var stoppageNameEditing = false
    @State private var suggestionMenuTopPadding = 0.0
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
                GeometryReader { reader in
                    let frame = reader.frame(in: CoordinateSpace.global)
                    
                    HStack {
                        Text("Name :")

                        TextField("Bus name :", text: $name, onEditingChanged: { editing in
                            busNameEditing = editing
                        })
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        }
                        .autocorrectionDisabled()
                        .onTapGesture {
                            suggestionMenuTopPadding = frame.origin.y
                        }
                    }
                }
                .frame(height: 30)
                .padding(.vertical, 15)

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
                    
                    Spacer()
                    
                    Picker("Service Type", selection: $serviceType) {
                        ForEach(serviceTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Spacer()
                }
                
                HStack {
                    Text("Selected Stoppages : ")
                    
                    Spacer()
                }
                
                LazyVGrid(columns: [GridItem(.flexible(minimum: 60, maximum: 150)), GridItem(.flexible(minimum: 60, maximum: 150)), GridItem(.flexible(minimum: 60, maximum: 150))], content: {
                    ForEach(stoppages) { stoppage in
                        SelectedStoppage(stoppages: $stoppages, stoppage: stoppage)
                            .padding(.top, 10)
                    }
                })
                
                HStack {
                    Text("Select Stoppages: ")
                    
                    TextField("Stoppage name", text: $stoppageName, onEditingChanged: { editing in
                        stoppageNameEditing = editing
                    })
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        }
                        .autocorrectionDisabled()

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
                    Text("Add")
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(30)
                .alert(validationError, isPresented: $showValidationError) {
                }

                Spacer()
            }

            if showSuggestions() {
                let suggestions = createSuggestions()
                if !suggestions.isEmpty {
                    VStack {
                        SuggestionMenuView(suggestions: suggestions, selected: $selectedSuggestion)
                            .offset(y: suggestionMenuTopPadding - navbarHeight)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                                    .offset(y: suggestionMenuTopPadding - navbarHeight)
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
        .padding()
    }

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
            suggestions = firebaseData.stoppages.map({ id, stop in
                Suggestion(id: id, title: stop.name, subTitle: "(\(stop.latitude), \(stop.longitude)")
            })
        }

        return suggestions
    }

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

        if firebaseData.buses.filter({ $0.name == name && $0.routeNumber == routeNumber }).count > 0 {
            return "The bus is already exist"
        }

        return ""
    }
}

#Preview {
    AddBus()
        .environmentObject(FirebaseData())
}
