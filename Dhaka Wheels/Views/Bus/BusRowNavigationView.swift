//
//  BusRowNavigationView.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 5/12/23.
//

import SwiftUI

struct BusRowNavigationView: View {
    @State var bus: Bus

    var body: some View {
        // Using ZStack, EmptyView and opacity 0 to remove left arrow for NavigationLink
        // Ref: https://thinkdiff.net/swiftui-navigationlink-hide-arrow-indicator-on-list-b842bcb78c79
        ZStack {
            NavigationLink {
                BusDetailView(bus: bus)
                    .toolbar(.hidden, for: .tabBar)
            } label: {
                EmptyView()
            }
            .opacity(0)
            .alignmentGuide(.listRowSeparatorLeading) { dimension in
                // To adjust separator position
                dimension[.leading]
            }

            BusRow(bus: bus)
        }
        .listRowBackground(Color.lffD1E)
        .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}

#Preview {
    BusRowNavigationView(bus: Constants.previewBuses[0])
}
