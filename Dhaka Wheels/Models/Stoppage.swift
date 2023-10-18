//
//  Stopage.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 14/10/23.
//

import Foundation

struct Stoppage: Hashable, Decodable, Identifiable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
}
