//
//  Dhaka_WheelsApp.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
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
struct Dhaka_WheelsApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var firebaseData = FirebaseData()

    init() {
        DWLogger.initialize()

        changeNavigationBarAppearence()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firebaseData)
                .task {
                    await firebaseData.fetchData()
                }
        }
    }

    private func changeNavigationBarAppearence() {
        // Change NavigationStack appearence on start up
        // Ref: https://www.hackingwithswift.com/forums/swiftui/custom-font-in-navigation-title-and-back-button/22989/23006
        let appearence = UINavigationBarAppearance()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24)
        ]

        appearence.titleTextAttributes = attributes
        appearence.largeTitleTextAttributes = attributes
        appearence.backgroundColor = .secondarySystemBackground

        UINavigationBar.appearance().standardAppearance = appearence
        UINavigationBar.appearance().compactAppearance = appearence
        UINavigationBar.appearance().scrollEdgeAppearance = appearence
    }
}
