//
//  CommonUtility.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 8/12/23.
//

import Foundation
import SwiftUI

class CommonUtility {
    static func getSafeArea(for edge: Edge.Set) -> CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first

        guard let safeArea = keyWindow?.safeAreaInsets else { return 0 }

        switch edge {
            case .leading:
                return safeArea.left
            case .trailing:
                return safeArea.right
            case .top:
                return safeArea.top
            case .bottom: 
                return safeArea.bottom
            default:
                return 0
        }
    }
}
