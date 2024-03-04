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
    
    func addSavingGoal(savingGoal: SavingGoal) {
        savings.append(savingGoal)
    }
}
