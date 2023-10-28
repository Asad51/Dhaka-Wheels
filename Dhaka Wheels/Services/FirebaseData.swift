//
//  FirebaseData.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 15/10/23.
//

import Foundation
import FirebaseFirestore

@MainActor
final class FirebaseData: ObservableObject {
    @Published var buses = [Bus]()
    @Published var stoppages = [String: Stoppage]()

    private let firestore = Firestore.firestore()

    func addStoppage(name: String, latitude: Double, longitude: Double) {
        let stoppageData = ["name": name, "latitude": latitude, "longitude": longitude] as [String : Any]
        let ref = firestore.collection("stoppage").addDocument(data: stoppageData)

        stoppages[ref.documentID] = Stoppage(id: ref.documentID, name: name, latitude: latitude, longitude: longitude)
    }

    func addBus(name: String, routeNumber: String, imageUrl: String = "", coachType: String, serviceType: String, stoppages: [Stoppage]) {
        let stoppagesRef: [DocumentReference] = stoppages.map { stoppage in
            firestore.document("stoppage/\(stoppage.id)")
        }

        let busData = [
            "name": name,
            "routeNumber": routeNumber,
            "imageUrl": imageUrl,
            "coachType": coachType,
            "serviceType": serviceType,
            "stoppages": stoppagesRef
        ] as [String : Any]

        let busRef = firestore.collection("buses").addDocument(data: busData)

        buses.append(Bus(id: busRef.documentID, name: name, routeNumber: routeNumber, imageUrl: imageUrl, coachType: coachType, serviceType: serviceType, stoppages: stoppages))
    }

    func fetchData() async {
        do {
            try await fetchStoppages()

            try await fetchBuses()
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchStoppages() async throws {
        let documents = try await firestore.collection("stoppage").getDocuments().documents

        for document in documents {
            let id = document.documentID
            let name = document["name"] as? String ?? ""
            let latitude = document["latitude"] as? Double ?? 0.0
            let longitude = document["longitude"] as? Double ?? 0.0

            self.stoppages[id] = Stoppage(id: id, name: name, latitude: latitude, longitude: longitude)
        }
    }

    func fetchBuses() async throws {
        let documents = try await firestore.collection("buses").getDocuments().documents

        self.buses = documents.map({ document in
            let name = document["name"] as? String ?? ""
            let routeNumber = document["routeNumber"] as? String ?? "N/A"
            let imageUrl = document["imageUrl"] as? String ?? ""
            let coachType = document["coachType"] as? String ?? ""
            let serviceType = document["serviceType"] as? String ?? ""
            let stoppagesRef = document["stoppages"] as? Array<DocumentReference>
            var busStoppages = [Stoppage]()

            stoppagesRef?.forEach({ ref in
                if let stoppage = self.stoppages[ref.documentID] {
                    busStoppages.append(stoppage)
                }
            })

            return Bus(id: document.documentID, name: name, routeNumber: routeNumber, imageUrl: imageUrl, coachType: coachType, serviceType: serviceType, stoppages: busStoppages)
        })
    }
}
