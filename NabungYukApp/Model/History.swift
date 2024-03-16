//
//  History.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 06/03/24.
//

import Foundation

class History {
    var id = UUID()
    var total: Int
    private var historyTypeString: String
    var historyType: HistoryType {
        return HistoryType(rawValue: historyTypeString)!
    }
    var createdAt = Date()
    
    init(id: UUID = UUID(), total: Int, historyType: HistoryType, createdAt: Date = Date()) {
        self.id = id
        self.total = total
        self.historyTypeString = historyType.rawValue
        self.createdAt = createdAt
        
    }
}

enum HistoryType: String, CaseIterable {
    case insert = "Tambah"
    case withdraw = "Kurangi"
}
