//
//  NavbarAccessor.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 25/10/23.
//

import Foundation
import UIKit
import SwiftUI

    // Reference: https://stackoverflow.com/questions/60241552/swiftui-navigationbar-height

struct NavbarAccessor: UIViewControllerRepresentable {
    var callback: (UINavigationBar) -> Void
    private let proxyController = ViewController()

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavbarAccessor>) ->
    UIViewController {
        proxyController.callback = callback
        return proxyController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavbarAccessor>) {
    }

    typealias UIViewControllerType = UIViewController

    private class ViewController: UIViewController {
        var callback: (UINavigationBar) -> Void = { _ in }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let navBar = self.navigationController {
                self.callback(navBar.navigationBar)
            }
        }
    }
}
