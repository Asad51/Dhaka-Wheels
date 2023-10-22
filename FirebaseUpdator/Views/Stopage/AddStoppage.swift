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
    //@State private var showSuggestions = false
    @State private var editing = false

    @State private var validationError = ""
    @State private var showValidationError = false
    @State private var stoppage: Stoppage?

    private func showSuggestions() -> Bool {
        return editing && name.trimmingCharacters(in: .whitespaces).count > 2
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            VStack {
                HStack(alignment: .center) {
                    Text("Stoppage :")

                    TextField("Stoppage name", text: $name, onEditingChanged: { editing in
                        self.editing = editing
                    })
                    .padding()
                    .autocorrectionDisabled()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray)
                    }
                }

                HStack {
                    Text("Coordinate :")

                    TextField("latitude, longitude", text: $coordinate)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                        }
                }

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
                .padding(30)
                .alert(validationError, isPresented: $showValidationError) {
                }
                
                Spacer()
            }
            .padding()

            if showSuggestions() {
                SuggestionMenuView(
                    suggestionViewModel: SuggestionViewModel(
                        suggestions: firebaseData.stoppages.map({ id, stoppage in
                            Suggestion(
                                id: id,
                                title: stoppage.name,
                                subTitle: "(\(stoppage.latitude), \(stoppage.longitude))"
                            )
                        })
                    ),
                    filterText: $name,
                    selected: .constant(nil)
                )
            }
        }
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
