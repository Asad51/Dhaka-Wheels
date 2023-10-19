//
//  String+Extensions.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 19/10/23.
//

import Foundation

extension String {
    func caseInsensitiveEqual(_ string: String) -> Bool {
        return self.lowercased() == string.lowercased()
    }

    func caseInsensitiveContains(_ subStr: String) -> Bool {
        return self.lowercased().contains(subStr.lowercased())
    }
}
