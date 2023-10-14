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

                        Spacer()

                        TextField("Ending point", text: $endingLocation)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray)
                            }
                    }
                }
                .frame(height: 120)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 2)
                }

                Text("Recent Searches")
                    .font(.title2)

                List(buses, id: \.self) { bus in
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
    }
}

#Preview {
    SearchView(buses: Constants.previewBuses)
}
