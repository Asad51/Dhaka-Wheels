//
//  BusDetailView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import SwiftUI

struct BusDetailView: View {
    let bus: Bus

    var body: some View {
        VStack {
            Text(bus.name)
                .font(.largeTitle)

            HStack {
                Image(systemName: "bus.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .padding()

                VStack {
                    Text("\(bus.startingPoint) - \(bus.endingPoint)")
                    Text("Route No: \(bus.routeNumber)")
                }
                .font(.title2)
                .padding()
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 2)
            }

            Text("Routes")
                .font(.title)
                .padding(.top)
                .foregroundStyle(.blue)

            List(bus.stops, id: \.self) { stop in
                HStack {
                    Image(systemName: "arrow.up.arrow.down")

                    Text(stop)
                }
            }
            .padding()
            .listStyle(.plain)
        }
    }
}

#Preview {
    BusDetailView(bus: Constants.previewBuses[0])
}
