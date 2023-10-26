//
//  AddStoppage.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 15/10/23.
//

import Foundation
import SwiftUI

struct AddStoppage: View {
    @EnvironmentObject private var firebaseData: FirebaseData

    @State private var name: String = ""
    @State private var coordinate: String = ""

    @State private var validationError = ""
    @State private var showValidationError = false
    @State private var stoppage: Stoppage?

    @State private var editing = false
    @State private var suggestionMenuYOffset = 0.0
    @State private var navbarHeight = 0.0

    private func showSuggestions() -> Bool {
        return editing && name.trimmingCharacters(in: .whitespaces).count > 2
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            VStack {
                // MARK: Stoppage name textfield
                GeometryReader { reader in
                    let frame = reader.frame(in: CoordinateSpace.global)

                    HStack(alignment: .center) {
                        Text("Stoppage :")

                        TextField("Enter stoppage name :", text: $name, onEditingChanged: { editing in
                            self.editing = editing
                        })
                        .padding()
                        .autocorrectionDisabled()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        }
                        .onTapGesture {
                            suggestionMenuYOffset = frame.origin.y
                        }
                    }
                }
                .frame(height: 30)
                .padding(.vertical, 15)

                // MARK: Coordinate textfield
                // Coordinate input is set to the wired format [latitude, longitude]
                // So I can copy coordinat from the map and paste it:)
                HStack {
                    Text("Coordinate :")

                    TextField("latitude, longitude", text: $coordinate)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        }
                }
                .padding(.vertical, 15)

                // MARK: Add stoppage button
                Button {
                    validationError = validateStoppageData()
                    if validationError.isEmpty {
                        if let stoppage {
                            firebaseData.addStoppage(name: stoppage.name, latitude: stoppage.latitude, longitude: stoppage.longitude)
                        }
                        name = ""
                        coordinate = ""
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
                .alert(validationError, isPresented: $showValidationError) {}
                
                Spacer()
            }

            // MARK: Display suggestions menu when typing
            if showSuggestions() {
                let suggestions = Binding<[Suggestion]>  {
                    getSuggestions()
                } set: { _, _ in
                }
                
                if !suggestions.isEmpty {
                    VStack {
                        SuggestionMenuView(suggestions: suggestions, selected: .constant(nil))
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
        .padding()
    }

    /// 
    /// Create list of suggestions from the stoppages
    ///
    /// - Returns: An array of Suggestion
    ///
    private func getSuggestions() -> [Suggestion] {
        let suggestions = firebaseData.stoppages
            .filter { $0.value.name.caseInsensitiveContains(name) }
            .map {
                Suggestion(
                    id: $0.key,
                    title: $0.value.name,
                    subTitle: "(\($0.value.latitude.rounded(to: 4)), \($0.value.longitude.rounded(to: 4)))"
                )
            }

        return suggestions
    }

    ///
    /// Returns error or empty string after validating inputs
    ///
    /// - Returns: Error string
    ///
    private func validateStoppageData() -> String {
        if name.isEmpty {
            return "Please enter name"
        }

        if coordinate.isEmpty {
            return "Please enter coorninate"
        }

        for (_, stopp) in firebaseData.stoppages {
            if stopp.name.caseInsensitiveEqual(name) {
                return "Stoppage already exists."
            }
        }

        let geoPoint = coordinate.split(separator: ", ")
        guard geoPoint.count == 2, let latitude = Double(geoPoint[0]), let longitude = Double(geoPoint[1]) else {
            return "Please enter coordinate in format: [latitude, longitude]"
        }

        stoppage = Stoppage(id: "InvalidID", name: name, latitude: latitude, longitude: longitude)

        return ""
    }
}

#Preview {
    AddStoppage()
        .environmentObject(FirebaseData())
}
