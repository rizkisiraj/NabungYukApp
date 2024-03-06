//
//  History.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 06/03/24.
//

import Foundation

struct History {
    var id = UUID()
    var savingId: UUID
    var total: Int
    var historyType: HistoryType
    var createdAt = Date()
}

enum HistoryType: String, CaseIterable {
    case insert = "Tambah"
    case withdraw = "Kurangi"
}
