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
                    Text("\(bus.stoppages.first ?? "") - \(bus.stoppages.last ?? "")")
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

            HStack {
                Text("Routes")
                    .font(.title)
                    .padding(.top)
                    .foregroundStyle(.blue)

                Button {

                } label: {
                    Image(systemName: "map.fill")
                    Text("View in Map")
                }
                .font(.title2)
                .padding(5)
                .foregroundStyle(.white)
                .background(.blue)
                .cornerRadius(10)
                .padding(.top)
            }

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
