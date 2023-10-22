//
//  Constants.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import Foundation

struct Constants {
    static let previewBuses: [Bus] = [
        Bus(
            id: "InvalidId",
            name: "Achim Paribahan",
            routeNumber: "a-314",
            imageUrl: "",
            coachType: "Non-AC",
            serviceType: "Sitting",
            stoppages: [
                Stoppage(id: "InvalidId1", name: "Moghbazar", latitude: 23.038323, longitude: 90.353632),
                Stoppage(id: "InvalidId1", name: "Kawran Bazar", latitude: 23.038323, longitude: 90.353632)
            ]
        )
    ]
}
