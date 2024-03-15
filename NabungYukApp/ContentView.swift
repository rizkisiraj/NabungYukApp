//
//  ContentView.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 27/02/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var preferredListTabungan = Tabungan.berlangsung
    
    var body: some View {
            let savingVM = SavingVM(tabunganToShow: preferredListTabungan)
            SavingView(savingVM: savingVM, preferredListTabungan: $preferredListTabungan)
                .tabItem {
                    Label("Tabungan", systemImage: "wallet.pass")
            }
                .tint(.green)
    }
}

#Preview {
    ContentView()
}
