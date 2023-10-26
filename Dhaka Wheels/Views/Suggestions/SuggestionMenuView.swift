//
//  SuggestionMenuView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 19/10/23.
//

import SwiftUI

struct SuggestionMenuView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var suggestions: [Suggestion]
    @Binding var selected: Suggestion?
    
    @State private var suggestionRowHeight = 60.0

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(suggestions) { suggestion in
                        SuggestionRow(suggestion: suggestion, suggestionRowHeight: $suggestionRowHeight)
                            .frame(maxWidth: .infinity)
                            .background(.white) // To make whole row tappable
                            .onTapGesture {
                                selected = suggestion
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }

                        Divider()
                    }
                }
            }
            .frame(height: suggestionRowHeight * Double(suggestions.count > 3 ? 3 : suggestions.count))
        }
        .padding(10)
        .background(.white)
    }
}

#Preview {
    SuggestionMenuView(suggestions: .constant(Constants.previewSuggestions), selected: .constant(nil))
}
