//
//  HistorySingle.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 18/03/24.
//

import SwiftUI

struct HistorySingle: View {
    var history: History
    let helpers: Helpers = Helpers.shared
    
    var createdDateIndonesian: String {
        helpers.formatDateToIndonesian(date: history.createdAt)
    }
    
    var amountRupiah: String {
        helpers.formatNumberToRupiah(number: history.total)
    }
    
    var body: some View {
        HStack {
            Text(createdDateIndonesian)
            Spacer()
            
            switch(history.historyType) {
            case .insert:
                Text("+ \(amountRupiah)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.green)
            case .withdraw:
                Text("- \(amountRupiah)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.red)
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    HistorySingle(history: History(total: 1000, historyType: .insert))
}
