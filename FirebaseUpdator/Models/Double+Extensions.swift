//
//  Double+Extensions.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 24/10/23.
//

import Foundation

extension Double {
    func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
