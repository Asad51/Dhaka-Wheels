//
//  Reachability.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 11/2/24.
//

import Combine
import Foundation
import Network

class Reachability {
    public static let shared = Reachability()

    let isNetworkConnected = PassthroughSubject<Bool, Never>()

    private lazy var networkMonitor = NWPathMonitor()
    private var queue = DispatchQueue.global(qos: .background)

    private init() {}

    func startMonitoring() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                DWLogDebug("Network path status: \(path.status)")
                self?.isNetworkConnected.send(path.status == .satisfied)
            }
        }

        networkMonitor.start(queue: queue)
    }

    func stopMonitoring() {
        isNetworkConnected.send(completion: .finished)
        networkMonitor.cancel()
    }
}
