//
//  MapView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 14/10/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var stoppages = [Stoppage]()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var selectedStoopage: MKMapItem?

    var body: some View {
        Map(position: $position, selection: $selectedStoopage) {
            ForEach(stoppages) { stoppage in
                Marker(stoppage.name, image: "bus_station", coordinate: CLLocationCoordinate2D(latitude: stoppage.latitude, longitude: stoppage.longitude))
                    .tint(.blue)
            }
        }
        .mapStyle(.hybrid(elevation: .flat))
        .mapControls {
            MapCompass()
            MapScaleView()
        }
    }

}

#Preview {
    MapView(stoppages: Constants.previewBuses[0].stoppages)
}
