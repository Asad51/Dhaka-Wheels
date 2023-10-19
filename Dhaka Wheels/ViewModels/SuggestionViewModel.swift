//
//  SuggestionViewModel.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 19/10/23.
//

import Foundation

class SuggestionViewModel: ObservableObject {
    @Published var suggestions = [Suggestion]()

    init(suggestions: [Suggestion]) {
        self.suggestions = suggestions
    }
}
