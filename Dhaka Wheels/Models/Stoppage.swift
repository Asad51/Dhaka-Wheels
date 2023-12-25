//
//  Stopage.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 14/10/23.
//

import Foundation
import SwiftData

@Model
class Stoppage: Hashable, Identifiable {
    @Attribute(.unique)
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double

    init(id: String, name: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
