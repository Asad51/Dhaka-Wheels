//
//  SelectedStoppage.swift
//  FirebaseUpdator
//
//  Created by Md. Asadul Islam on 15/10/23.
//

import SwiftUI

struct SelectedStoppage: View {
    @Binding var stoppages: [Stoppage]
    var stoppage: Stoppage
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Text(stoppage.name)
                .padding(10)
                .background(.gray)
                .cornerRadius(20)
                .foregroundStyle(.white)
            Button {
                stoppages.removeAll(where: { stoppage.id == $0.id })
            } label: {
                Image(systemName: "minus.circle.fill")
            }
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(.red)
            .padding(.top, -15)
            .padding(.trailing, -5)
        }
    }
}

#Preview {
    SelectedStoppage(stoppages: .constant([]), stoppage: Stoppage(id: "364bds6ereg6", name: "Kawran Bazar", latitude: 23.751821300199158, longitude: 90.39279311162966))
}
