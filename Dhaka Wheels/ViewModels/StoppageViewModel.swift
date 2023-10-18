//
//  StoppageViewModel.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 18/10/23.
//

import Foundation
import FirebaseFirestore

class StoppageViewModel: ObservableObject {
    @Published var stoppages = [Stoppage]()

    let firestore = Firestore.firestore()

    func fetchData() {
        firestore.collection("stoppages").addSnapshotListener { snapshot, error in
            if let documents = snapshot?.documents {
                self.stoppages = documents.map({ document in
                    let id = document["id"] as? String ?? ""
                    let name = document["name"] as? String ?? ""
                    let latitude = document["latitude"] as? Double ?? 0.0
                    let longitude = document["longitude"] as? Double ?? 0.0

                    return Stoppage(id: id, name: name, latitude: latitude, longitude: longitude)
                })
            }
        }
    }
}
