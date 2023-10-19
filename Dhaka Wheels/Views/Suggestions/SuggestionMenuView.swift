//
//  SuggestionMenuView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 19/10/23.
//

import SwiftUI

struct SuggestionMenuView: View {
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var suggestionViewModel = SuggestionViewModel(suggestions: [])

    @Binding var filterText: String
    @Binding var selected: Suggestion?

    private var filteredSuggestions: Binding<[Suggestion]> {
        Binding {
            return suggestionViewModel.suggestions.filter {
                $0.title.caseInsensitiveContains(filterText)
            }
        } set: { _, _ in
        }
    }

    // FIXME: - Need to fix height and positioning
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(filteredSuggestions) { suggestion in
                    SuggestionRow(suggestion: suggestion.wrappedValue)
                        .background {

                        }
                        .onTapGesture {
                            selected = suggestion.wrappedValue
                            dismiss()
                        }
                }
            }
        }
        .background(Color(.lightGray))
        .frame(height: 500)
    }
}

#Preview {
    SuggestionMenuView(filterText: .constant(""), selected: .constant(nil))
}
