//
//  SuggestionRow.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 19/10/23.
//

import SwiftUI

struct SuggestionRow: View {
    @State var suggestion: Suggestion

    var body: some View {
        VStack {
            Text(suggestion.title)
                .font(.title)

            Text(suggestion.subTitle)
                .font(.subheadline)
        }
    }
}

#Preview {
    SuggestionRow(suggestion: Suggestion(id: "InvalidID", title: "Title", subTitle: "Sub title"))
}
