//
//  SavingList.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 15/03/24.
//

import SwiftUI
import SwiftData

struct SavingList: View {
    @Query var savings: [SavingGoal]
    var action: (SavingGoal) -> Void
    
    init(tabunganToShow: Tabungan, action: @escaping (SavingGoal) -> Void) {
        switch tabunganToShow {
        case .berlangsung:
            _savings = Query(filter: #Predicate<SavingGoal> { saving in
                    saving.gatheredAmount < saving.target
            }, sort: \SavingGoal.createdAt, order: .reverse)
        case .tercapai:
            _savings = Query(filter: #Predicate<SavingGoal> { saving in
                    saving.gatheredAmount >= saving.target
            }, sort: \SavingGoal.createdAt, order: .reverse)
        }
        self.action = action
    }
    
    
    var body: some View {
        LazyVStack(spacing: 14) {
            if savings.isEmpty {
                EmptySavingListPlaceholder()
            } else {
                ForEach(savings) { saving in
                    NavigationLink {
                        SavingDetailViews(content: saving)
                    } label: {
                        SavingCard(content: saving, count: savings.count, action: {action(saving)})
                    }
                }
                Spacer()
            }
        }
        .transition(.slide)
        .padding(.horizontal)
    }
}

#Preview {
    let myFunction: (SavingGoal) -> Void = { saving in
        print(saving.title)
    }
    return SavingList(tabunganToShow: .berlangsung, action: myFunction)
}
