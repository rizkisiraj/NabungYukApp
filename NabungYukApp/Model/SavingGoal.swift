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
    var category: Category
    var createdAt = Date()
    var gatheredAmount = 0
}

enum PeriodSelection: String, CaseIterable {
    case daily = "Harian"
    case weekly = "Mingguan"
    case monthly = "Bulanan"
}

enum Category: String, CaseIterable {
    case travel = "airplane"
    case entertainment = "film.fill"
    case education = "book.fill"
    case health = "heart.fill"
}

extension SavingGoal {
    static let savingGoals = [
        SavingGoal(title: "Liburan ke Anambas", target: 5000000, period: .monthly, targetSavePerPeriod: 100000, dummyImage: "dummyImage1", category: Category.education),
        SavingGoal(title: "Liburan ke Thailand", target: 5000000, period: .monthly, targetSavePerPeriod: 100000, dummyImage: "dummyImage1", category: Category.entertainment),
        SavingGoal(title: "Liburan ke Jepang", target: 5000000, period: .monthly, targetSavePerPeriod: 100000, dummyImage: "dummyImage1", category: Category.health)
    ]
}
