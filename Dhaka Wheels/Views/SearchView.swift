//
//  SearchView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import SwiftUI

struct SearchView: View {
    @State private var startingLocation: String = ""
    @State private var endingLocation: String = ""
    @State var buses = [Bus]()
    @State private var filteredBuses = [Bus]()

    var body: some View {
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
                        TextField("Starting point", text: $startingLocation)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray)
                            }
                            .onChange(of: startingLocation) {
                                filterBuses()
                            }

                        Spacer()

                        TextField("Ending point", text: $endingLocation)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray)
                            }
                            .onChange(of: endingLocation) {
                                filterBuses()
                            }
                    }
                }
                .frame(height: 120)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 2)
                }

                Text("Search results")
                    .font(.title2)

                List(filteredBuses, id: \.self) { bus in
                    NavigationLink {
                        BusDetailView(bus: bus)
                    } label: {
                        BusRow(bus: bus)
                    }
                }
                .listStyle(.inset)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 2)
                }

                Spacer()
            }
            .padding()
        }
        .onAppear {
            filteredBuses = buses
        }
    }

    private func filterBuses() {
        print(startingLocation, endingLocation)
        filteredBuses = buses.filter { $0.stoppages.contains(startingLocation) && $0.stoppages.contains(endingLocation)}
    }
}

#Preview {
    SearchView(buses: Constants.previewBuses)
}
