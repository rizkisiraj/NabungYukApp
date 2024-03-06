//
//  FormViewModel.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 04/03/24.
//

import Foundation

@MainActor
class SavingVM: ObservableObject {
    @Published var savings: [SavingGoal] = []
    @Published var savingHistories: [History] = []
    
    func addSavingGoal(savingGoal: SavingGoal) {
        savings.append(savingGoal)
    }
    
    func addSavingHistory(savingId: UUID, total: Int, historyType: HistoryType) {
        let newSavingHistory = History(savingId: savingId, total: total, historyType: historyType)
        
        self.savingHistories.append(newSavingHistory)
    }
    
    func editSavingIncome(savingId: UUID, total: Int, historyType: HistoryType) {
        if let editedSaving = savings.firstIndex(where: { $0.id == savingId }) {
            switch historyType {
            case .insert:
                savings[editedSaving].gatheredAmount += total
            case .withdraw:
                savings[editedSaving].gatheredAmount -= total
            }
            
            addSavingHistory(savingId: savingId, total: total, historyType: historyType)
        }
        
    }
}
