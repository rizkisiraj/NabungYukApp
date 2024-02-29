//
//  CustomDotIndicator.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 27/02/24.
//

import SwiftUI

struct CustomDotIndicator: View {
    let count: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { tab in
                Circle()
                    .fill(tab == selectedTab ? .blue : .gray)
                    .scaleEffect(tab == selectedTab ? 1.8 : 1.0)
                    .frame(width: 6, height: 6)
                    .padding(.horizontal, 4)
                    .onTapGesture {
                        selectedTab = tab
                    }
            }
        }
        .animation(.easeOut, value: selectedTab)
    }
}

#Preview {
    @State var selectedTab = 0
    return CustomDotIndicator(count: 3, selectedTab: $selectedTab)
}
