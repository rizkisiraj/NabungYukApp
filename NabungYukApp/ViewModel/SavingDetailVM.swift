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
    @Bindable var saving: SavingGoal
    @Published var savingHistories: [History] = []
    
    init(saving: SavingGoal, savingHistories: [History] = []) {
        self.saving = saving
        self.savingHistories = savingHistories
    }
    
    func editSavingIncome(savingId: UUID, total: Int, historyType: HistoryType) {
            switch historyType {
            case .insert:
                saving.gatheredAmount += total
            case .withdraw:
                saving.gatheredAmount -= total
            }
    }
}
