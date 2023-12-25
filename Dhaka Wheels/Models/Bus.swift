//
//  Bus.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import Foundation
import SwiftData

@Model
final class Bus: Hashable, Identifiable {
    @Attribute(.unique)
    let id: String
    let name: String
    let routeNumber: String
    let imageUrl: String
    let coachType: String
    let serviceType: String
    @Relationship(deleteRule: .noAction)
    let stoppages: [Stoppage]

    init(id: String, name: String, routeNumber: String, imageUrl: String, coachType: String, serviceType: String, stoppages: [Stoppage]) {
        self.id = id
        self.name = name
        self.routeNumber = routeNumber
        self.imageUrl = imageUrl
        self.coachType = coachType
        self.serviceType = serviceType
        self.stoppages = stoppages
    }
}
