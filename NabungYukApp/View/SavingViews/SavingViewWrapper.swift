//
//  SwiftUIWrapper.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 14/03/24.
//

import SwiftUI

struct SwiftUIWrapper: View {
    @State private var preferredListTabungan = Tabungan.berlangsung
    
    var body: some View {
        SavingView()
    }
}

#Preview {
    SwiftUIWrapper()
}
