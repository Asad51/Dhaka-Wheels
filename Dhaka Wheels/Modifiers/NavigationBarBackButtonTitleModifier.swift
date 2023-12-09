//
//  NavigationBarBackButtonTitleModifier.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 10/12/23.
//

import SwiftUI

// Ref: https://stackoverflow.com/a/62854805/7646289
struct NavigationBarBackButtonTitleModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss

    @State var title: String?

    @ViewBuilder @MainActor func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                            .imageScale(.large)

                        if let title {
                            Text(title)
                                .font(.title2)
                        }
                    }
                }
            }

    }
}
