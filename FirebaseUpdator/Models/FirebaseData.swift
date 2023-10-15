//
//  FirebaseData.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 15/10/23.
//

import Foundation

final class FirebaseData: ObservableObject {
    @Published var buses: [Bus] = []
    @Published var stoppages: [Stoppage] = []
}
