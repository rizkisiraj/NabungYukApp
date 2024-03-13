//
//  SavingDetailVM.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 06/03/24.
//

import Foundation
import SwiftUI

@MainActor
class SavingDetailVM: ObservableObject {
    @Published var content: SavingGoal
    @Published var savingHistories: [History] = []
    @ObservedObject var savingVM: SavingVM
    
    init(content: SavingGoal, savingVM: SavingVM) {
        self.content = content
        self.savingVM = savingVM
    }
    
    var contentId: SavingGoal {
        savingVM.savings.first(where: { $0.id == content.id }) ?? SavingGoal.savingGoals[0]
    }
}
