//
//  FirebaseUpdatorApp.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 15/10/23.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

@main
struct FirebaseUpdatorApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject private var firebaseData = FirebaseData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firebaseData)
                .task {
                    await firebaseData.fetchData()
                }
        }
    }
}
