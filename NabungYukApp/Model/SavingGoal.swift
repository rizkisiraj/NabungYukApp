//
//  SavingGoal.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 28/02/24.
//

import Foundation

struct SavingGoal: Identifiable {
    var id = UUID()
    var title: String
    var target: Int
    var period: PeriodSelection
    var targetSavePerPeriod: Int
    var dummyImage: String
}

enum PeriodSelection: String, CaseIterable {
    case daily = "Harian"
    case weekly = "Mingguan"
    case monthly = "Bulanan"
}

extension SavingGoal {
    static let savingGoals = [
        SavingGoal(title: "Liburan ke Anambas", target: 5000000, period: .monthly, targetSavePerPeriod: 100000, dummyImage: "dummyImage1"),
        SavingGoal(title: "Liburan ke Thailand", target: 5000000, period: .monthly, targetSavePerPeriod: 100000, dummyImage: "dummyImage1"),
        SavingGoal(title: "Liburan ke Jepang", target: 5000000, period: .monthly, targetSavePerPeriod: 100000, dummyImage: "dummyImage1")
    ]
}
