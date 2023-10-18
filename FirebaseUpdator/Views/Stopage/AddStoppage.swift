//
//  AddStoppage.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 15/10/23.
//

import SwiftUI

struct AddStoppage: View {
    @EnvironmentObject private var firebaseData: FirebaseData
    @State private var name: String = ""
    @State private var coordinate: String = ""

    @State private var validationError = ""
    @State private var showValidationError = false
    @State private var stoppage: Stoppage?

    var body: some View {
        VStack {
            HStack {
                Text("Stoppage :")

                TextField("Stoppage name", text: $name)
                    .padding()
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
                    // TODO: add stoppage to firebase
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
        }
        .padding()
    }

    private func validateStoppageData() -> String {
        if name.isEmpty {
            return "Please enter name"
        }

        if coordinate.isEmpty {
            return "Please enter coorninate"
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
