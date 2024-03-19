//
//  SaveCard.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 28/02/24.
//

import SwiftUI

struct SavingCard: View {
    var content: SavingGoal
    var count: Int
    var action: () -> Void
    
    let helpers = Helpers.shared
    
    var timeToReachTarget: String {
        helpers.timeToReachTarget(target: content.target, savingsPerPeriod: content.targetSavePerPeriod, period: content.period)
    }
    
    var currentAmount: String {
        helpers.formatNumberToRupiah(number: content.gatheredAmount)
    }
    
    var currentTarget: String {
        helpers.formatNumberToRupiah(number: content.target)
    }
    
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
                    Text(timeToReachTarget)
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
                    Text(currentAmount)
                        .font(.system(size: 14))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.primary)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Goal")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                    Text(currentTarget)
                        .font(.system(size: 14))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.green)
                }
            }
            .padding(.horizontal)
            
            ProgressView(value: Double(content.gatheredAmount), total: Double(content.target))
                .padding([.horizontal, .bottom])
                .tint(.green)
        }
        .tint(.primary)
        .background(.cardBg)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .animation(.easeInOut, value: count)
        .contextMenu(ContextMenu(menuItems: {
            Button {
                action()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }))
    }
}

#Preview {
    SavingCard(content: SavingGoal.savingGoals[0], count: 2, action: {print("siu")})
        .preferredColorScheme(.dark)
}
