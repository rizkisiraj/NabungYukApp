//
//  SavingGoal.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 28/02/24.
//

import Foundation
import SwiftData

@Model
class SavingGoal: Identifiable {
    var id = UUID()
    var title: String
    var target: Int
    var targetSavePerPeriod: Int
    var dummyImage: String
    var createdAt: Date
    var gatheredAmount: Int
    var histories: [History]
    
    private var periodString: String
    var period: PeriodSelection {
        return PeriodSelection(rawValue: self.periodString)!
    }
    
    private var categoryString: String
    var category: Category {
        return Category(rawValue: self.categoryString)!
    }
    
    func setCategory(category: Category) {
        categoryString = category.rawValue
    }
    
    func setPeriod(period: PeriodSelection) {
        periodString = period.rawValue
    }
    
    init(id: UUID = UUID(), title: String = "", target: Int = 0, period: PeriodSelection = PeriodSelection.daily, targetSavePerPeriod: Int = 0, dummyImage: String = "", category: Category = Category.education, createdAt: Date = .now, gatheredAmount: Int = 0, histories: [History] = []) {
        self.id = id
        self.title = title
        self.target = target
        self.targetSavePerPeriod = targetSavePerPeriod
        self.dummyImage = dummyImage
        self.categoryString = category.rawValue
        self.createdAt = createdAt
        self.gatheredAmount = gatheredAmount
        self.periodString = period.rawValue
        self.histories = []
    }
}

enum PeriodSelection: String, CaseIterable, Codable {
    case daily = "Harian"
    case weekly = "Mingguan"
    case monthly = "Bulanan"
}

enum Category: String, CaseIterable, Codable {
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
