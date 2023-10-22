//
//  BusRow.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 12/10/23.
//

import SwiftUI

struct BusRow: View {
    let bus: Bus

    var body: some View {
        HStack {
            Image(systemName: "bus.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50)

            VStack(alignment: .leading) {
                Text(bus.name)
                    .font(.title)
                    .lineLimit(1)
                    

                Text("\(bus.stoppages.first?.name ?? "") - \(bus.stoppages.last?.name ?? "")")
                    .font(.subheadline)
            }
            .padding()

            Spacer()

            Text(bus.serviceType)
                .font(.title3)
        }
    }
}

#Preview {
    BusRow(bus: Constants.previewBuses[0])
}
