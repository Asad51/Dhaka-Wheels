//
//  Constants.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import Foundation

struct Constants {
    static let previewBuses: [Bus] = {
        let decoder = JSONDecoder()

        let data = try! Data(contentsOf: Bundle.main.url(forResource: "BusList", withExtension: "json")!)

        return try! decoder.decode([Bus].self, from: data)
    }()
}
