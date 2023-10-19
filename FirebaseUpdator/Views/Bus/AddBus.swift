//
//  AddBus.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 15/10/23.
//

import SwiftUI

struct AddBus: View {
    @ObservedObject private var busViewModel = BusViewModel()
    @ObservedObject private var stoppageViewModel = StoppageViewModel()

    @State private var name: String = ""
    @State private var routeNumber: String = "N/A"
    @State private var coachType: String = "Non-AC"
    @State private var serviceType: String = "Sitting"
    @State private var stoppages: [Stoppage]  = []
    @State private var stoppage: String = ""

    @State private var validationError = ""
    @State private var showValidationError = false

    private var coachTypes: [String] = ["Non-AC", "AC"]
    private var serviceTypes: [String] = ["Sitting", "Semi Sitting", "Local"]

    var body: some View {
        VStack {
            HStack {
                Text("Name : ")

                TextField("Bus name", text: $name)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray)
                    }
            }

            HStack {
                Text("Route No: ")

                TextField("Route number", text: $routeNumber)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray)
                    }
            }

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

                TextField("Stoppage name", text: $stoppage)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray)
                    }

                Button {
                    if let stop = stoppageViewModel.stoppages.first(where: { $0.name == stoppage }) {
                        if !stoppages.contains(where: { $0.id == stop.id}) {
                            stoppages.append(stop)
                        }
                    }
                } label: {
                    Image(systemName: "plus.square")
                        .resizable()
                        .font(.title)
                        .frame(width: 30, height: 30)
                }
            }

            Button {
                validationError = validateBusData()
                if validationError.isEmpty {

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

        if busViewModel.buses.filter({ $0.name == name && $0.routeNumber == routeNumber }).count > 0 {
            return "The bus is already exist"
        }

        return ""
    }
}

#Preview {
    AddBus()
        .environmentObject(FirebaseData())
}
