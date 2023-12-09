//
//  BusDetailView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import SwiftUI

struct BusDetailView: View {
    let bus: Bus
    @State private var showMap = false

    var body: some View {
        ZStack {
            Color.lf6D01
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    VStack {
                        AsyncImage(url: URL(string: bus.imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                        } placeholder: {
                            Image(systemName: "bus.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("\(bus.stoppages.first?.name ?? "") - \(bus.stoppages.last?.name ?? "")")
                        Text("Route No: \(bus.routeNumber)")
                    }
                    .font(.title2)
                    .padding()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.lffD1E)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 2)
                }
                
                HStack {
                    Spacer()
                    Text("Routes")
                        .font(.title)
                        .padding(.top)
                        .foregroundStyle(.blue)
                    
                    Spacer()
                    
                    NavigationLink {
                        MapView(stoppages: bus.stoppages)
                            .navigationTitle("Routes")
                    } label: {
                        HStack {
                            Image(systemName: "map.fill")
                            
                            Text("View on Map")
                        }
                        .font(.title2)
                        .padding(5)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .cornerRadius(10)
                        .padding(.top)
                    }
                    
                    Spacer()
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
                                
                                Text(stoppage.name)
                                
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
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        BusDetailView(bus: Constants.previewBuses[0])
    }
}
