//
//  View+Extensions.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 10/12/23.
//

import SwiftUI

extension View {
    func navigationBarBackButtonTitle(_ title: String? = nil) -> some View {
        modifier(NavigationBarBackButtonTitleModifier(title: title))
    }

    func navigationBarBackButtonTitleHidden() -> some View {
        modifier(NavigationBarBackButtonTitleModifier())
    }
}
