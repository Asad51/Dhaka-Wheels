//
//  SearchFieldModifier.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/12/23.
//

import SwiftUI

struct SearchFieldModifier: ViewModifier {
    @Binding var suggestionMenuYOffset: Double
    let frame: CGRect

    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.lf6D01)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray)
            }
            .onTapGesture {
                suggestionMenuYOffset = frame.origin.y + frame.height
            }
    }
}
