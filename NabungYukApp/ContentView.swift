//
//  ContentView.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 27/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SavingView()
                .tabItem {
                    Label("Tabungan", systemImage: "wallet.pass")
            }
                .tint(.green)
        }
        .tint(.green)
        
    }
}

#Preview {
    ContentView()
}
