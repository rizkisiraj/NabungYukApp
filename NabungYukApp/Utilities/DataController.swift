//
//  DataController.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 25/03/24.
//

import Foundation
import SwiftData

@MainActor
class DataController {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: SavingGoal.self, configurations: config)

            let savingGoal = SavingGoal.savingGoals[0]
            container.mainContext.insert(savingGoal)

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
