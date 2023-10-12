//
//  BusRow.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import SwiftUI

struct BusRow: View {
    var body: some View {
        HStack {
            Image(systemName: "bus.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50)

            VStack {
                Text("Bus Name")
                    .font(.title)

                Text("Source - Destination")
                    .font(.subheadline)
            }
            .padding()

            Text("Type")
                .font(.title3)
        }
    }
}

#Preview {
    BusRow()
}
