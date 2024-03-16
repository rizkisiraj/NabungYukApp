//
//  FormViewModel.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 04/03/24.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class SavingVM: ObservableObject { 
    @Query var savangs: [SavingGoal]
    @Published var savings: [SavingGoal] = []
    @Published var savingHistories: [History] = []
    
    init(tabunganToShow: Tabungan = Tabungan.berlangsung) {
//        switch tabunganToShow {
//        case .berlangsung:
//            _savangs = Query(filter: #Predicate<SavingGoal> { saving in
//                    saving.gatheredAmount < saving.target
//            }, sort: \SavingGoal.createdAt)
//        case .tercapai:
//            _savangs = Query(filter: #Predicate<SavingGoal> { saving in
//                    saving.gatheredAmount >= saving.target
//            }, sort: \SavingGoal.createdAt)
//        }
    }
    
//    func addSavingHistory(savingId: UUID, total: Int, historyType: HistoryType) {
//        let newSavingHistory = History(savingId: savingId, total: total, historyType: historyType)
//        
//        self.savingHistories.append(newSavingHistory)
//    }
//    
//    func editSavingIncome(savingId: UUID, total: Int, historyType: HistoryType) {
//        if let editedSaving = savings.firstIndex(where: { $0.id == savingId }) {
//            switch historyType {
//            case .insert:
//                savings[editedSaving].gatheredAmount += total
//            case .withdraw:
//                savings[editedSaving].gatheredAmount -= total
//            }
//            
//            addSavingHistory(savingId: savingId, total: total, historyType: historyType)
//        }
//        
//    }
//    
//    func editSavingGoal(newSaving: SavingGoal) {
//        if let editedSavingIndex = savings.firstIndex(where: { $0.id == newSaving.id }) {
//            savings[editedSavingIndex] = newSaving
//        }
//        
//    }
//    
//    func deleteTabungan(savingId: UUID) {
//        self.savings = savings.filter({ $0.id != savingId })
//        
//        deleteHistory(savingId: savingId)
//    }
//    
//    func deleteHistory(savingId: UUID) {
//        self.savingHistories = savingHistories.filter({ $0.savingId != savingId })
//    }
//    
//    func addSavingGoal(saving: SavingGoal, modelContext: ModelContext) {
//        modelContext.insert(saving)
//    }
}
