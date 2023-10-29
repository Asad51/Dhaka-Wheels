//
//  MapView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 14/10/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.dismiss) private var dismiss

    @State var stoppages = [Stoppage]()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var selectedStoopage: MKMapItem?

    var body: some View {
        ZStack {

            Map(position: $position, selection: $selectedStoopage) {
                ForEach(stoppages) { stoppage in
                    Marker(stoppage.name, image: "bus_station", coordinate: CLLocationCoordinate2D(latitude: stoppage.latitude, longitude: stoppage.longitude))
                        .tint(.blue)
                }
            }
            .mapStyle(.hybrid(elevation: .flat))
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }

            VStack(alignment: .center) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("< Back")
                            .padding(8)
                            .foregroundStyle(.black)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()

                    Spacer()
                }

                Spacer()
            }
        }
    }
}

#Preview {
    MapView(stoppages: Constants.previewBuses[0].stoppages)
}
