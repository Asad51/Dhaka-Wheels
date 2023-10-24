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
    @State private var suggestionMenuTopPadding = 0.0
    @State private var navbarHeight = 0.0

    private func showSuggestions() -> Bool {
        return editing && name.trimmingCharacters(in: .whitespaces).count > 2
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            VStack {
                GeometryReader { reader in
                    let frame = reader.frame(in: CoordinateSpace.global)

                    HStack(alignment: .center) {
                        Text("Stoppage :")

                        TextField("Stoppage name :", text: $name, onEditingChanged: { editing in
                            self.editing = editing
                        })
                        .padding()
                        .autocorrectionDisabled()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        }
                        .onTapGesture {
                            suggestionMenuTopPadding = frame.origin.y
                        }
                    }
                }
                .frame(height: 30)
                .padding(.vertical, 15)

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

                Button {
                    validationError = validateStoppageData()
                    if validationError.isEmpty {
                        if let stop = stoppage {
                            firebaseData.addStoppage(name: stop.name, latitude: stop.latitude, longitude: stop.longitude)
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

            if showSuggestions() {
                let suggestions = getSuggestions()
                if !suggestions.isEmpty {
                    VStack {
                        SuggestionMenuView(suggestions: suggestions, selected: .constant(nil))
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

        let geopoint = coordinate.split(separator: ", ")
        guard geopoint.count == 2, let latitude = Double(geopoint[0]), let longitude = Double(geopoint[1]) else {
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
