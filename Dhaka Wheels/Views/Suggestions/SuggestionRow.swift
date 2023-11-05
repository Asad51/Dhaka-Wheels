//
//  SuggestionRow.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 19/10/23.
//

import SwiftUI

struct SuggestionRow: View {
    @State var suggestion: Suggestion
    @Binding var suggestionRowHeight: Double

    var body: some View {
        VStack {
            Text(suggestion.title)
                .font(.title2)

            if !suggestion.subTitle.isEmpty {
                Text(suggestion.subTitle)
                    .font(.subheadline)
            }

            Spacer()
        }
        .background(
            GeometryReader { proxy in
                Color.clear
                    .task(id: proxy.size) {
                        suggestionRowHeight = proxy.size.height
                    }
            }
        )
    }
}

#Preview {
    SuggestionRow(suggestion: Constants.previewSuggestions[0], suggestionRowHeight: .constant(80.0))
}
