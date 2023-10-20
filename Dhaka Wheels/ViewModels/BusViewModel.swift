//
//  BusViewModel.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 18/10/23.
//

import Foundation
import FirebaseFirestore

class BusViewModel: ObservableObject {
    @Published var buses = [Bus]()

    private let firestore = Firestore.firestore()

    func addBus(name: String, routeNumber: String, imageUrl: String = "", coachType: String, serviceType: String, stoppages: [Stoppage]) {
        firestore
            .collection("buses")
            .addDocument(data: [
                "name": name,
                "routeNumber": routeNumber,
                "imageUrl": imageUrl,
                "coachType": coachType,
                "serviceType": serviceType,
                "stoppages": stoppages.map({ stoppage in
                    stoppage.id
                })
            ]) { error in
                if error == nil {
                    self.fetchData()
                }
            }
    }

    func fetchData() {
        firestore.collection("buses").addSnapshotListener { snapshot, error in
            if let documents = snapshot?.documents {
                print(documents.count)
                self.buses = documents.map({ document in
                    let id = document["id"] as? String ?? ""
                    let name = document["name"] as? String ?? ""
                    let routeNumber = document["routeNumber"] as? String ?? "N/A"
                    let imageUrl = document["imageUrl"] as? String ?? ""
                    let coachType = document["coachType"] as? String ?? ""
                    let serviceType = document["serviceType"] as? String ?? ""
                    return Bus(id: id, name: name, routeNumber: routeNumber, imageUrl: imageUrl, coachType: coachType, serviceType: serviceType, stoppages: [])
                })
            }
        }
    }
}
