//
//  SaveCard.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 28/02/24.
//

import SwiftUI

struct SavingCard: View {
    var content: SavingGoal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundStyle(.green.secondary)
                        .frame(width: 60, height: 60)
                    Image(systemName: content.category.rawValue)
                        .font(.title2)
                        .foregroundStyle(.green)
                }
                .padding(.leading)
                VStack(alignment: .leading, spacing: 2) {
                    Text(content.title)
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.primary)
                    Text("9 bulan lagi")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.top)
            HStack {
                VStack(alignment: .leading) {
                    Text("Current Amount")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                    Text("Rp50.000")
                        .font(.system(size: 14))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.primary)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Goal")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                    Text("Rp120.000.000")
                        .font(.system(size: 14))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.green)
                }
            }
            .padding(.horizontal)
            
            ProgressView(value: 50000, total: 120000000)
                .padding([.horizontal, .bottom])
                .tint(.green)
        }
        .tint(.primary)
        .background(.cardBg)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    SavingCard(content: SavingGoal.savingGoals[0])
        .preferredColorScheme(.dark)
}
