//
//  SearchViewLabelImage.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/12/23.
//

import SwiftUI

struct SearchViewLabelImage: View {
    let systemName: String

    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 30)
            .padding(.trailing, 5)
    }
}

#Preview {
    SearchViewLabelImage(systemName: "bus")
}
