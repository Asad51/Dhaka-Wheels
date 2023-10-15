//
//  Bus.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import Foundation

struct Bus: Hashable, Decodable {
    let id: String
    let name: String
    let routeNumber: String
    let imageUrl: String
    let startingPoint: String
    let endingPoint: String
    let stoppages: [String]
    let type: String
}
