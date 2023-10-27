//
//  AllBustList.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 14/10/23.
//

import SwiftUI

struct AllBustList: View {
    @EnvironmentObject private var firebaseData: FirebaseData
    
    var body: some View {
        NavigationStack {
            List(firebaseData.buses, id: \.self) { bus in
                NavigationLink {
                    BusDetailView(bus: bus)
                } label: {
                    BusRow(bus: bus)
                }
            }
            .listStyle(.inset)
        }
    }
}

#Preview {
    AllBustList()
        .environmentObject(FirebaseData())
}
