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
                VStack {
                    AsyncImage(url: URL(string: bus.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .padding()
                    } placeholder: {
                        ProgressView()
                    }
                }

                VStack(alignment: .leading) {
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

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(Array(bus.stoppages.enumerated()), id: \.element) { i, stoppage in
                        VStack {
                            if i == 0 {
                                Image(systemName: "circle.circle")
                                    .padding(5)
                                    .foregroundStyle(.blue, .gray)
                            } else {
                                Image(systemName: "arrow.up.arrow.down")
                                    .padding(5)
                                    .foregroundStyle(.red, .green)
                            }

                            Text(stoppage)

                            if i == bus.stoppages.count - 1 {
                                Image(systemName: "mappin.and.ellipse")
                                    .padding(5)
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    BusDetailView(bus: Constants.previewBuses[0])
}
