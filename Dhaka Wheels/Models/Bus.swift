//
//  Bus.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import Foundation

struct Bus: Hashable, Decodable, Identifiable {
    let id: String
    let name: String
    let routeNumber: String
    let imageUrl: String
    let coachType: String
    let serviceType: String
    let stoppages: [Stoppage]
}
