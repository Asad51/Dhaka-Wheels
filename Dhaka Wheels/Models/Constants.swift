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
                Stoppage(id: "InvalidId1", name: "Moghbazar", latitude: 23.74847198433284, longitude: 90.40270312675771),
                Stoppage(id: "InvalidId2", name: "Kawran Bazar", latitude: 23.74993366314999, longitude: 90.39323594127315)
            ]
        )
    ]

    static let previewSuggestions: [Suggestion] = [
        Suggestion(id: "InvalidID1", title: "Suggestion 01", subTitle: "Suggestions sub text"),
        Suggestion(id: "InvalidID2", title: "Suggestion 02", subTitle: "Suggestions sub text")
    ]
}
