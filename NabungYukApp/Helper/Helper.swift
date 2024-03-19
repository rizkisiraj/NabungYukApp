//
//  Helper.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 05/03/24.
//

import Foundation

class Helpers {
    static let shared = Helpers()
    
    private init() {
        
    }
    
    func formatNumberToRupiah(number: Int) -> String {
        let amountToConvert = number >= 0 ? number : 0
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        let formattedAmount = formatter.string(from: amountToConvert as NSNumber) ?? ""
        return "Rp\(formattedAmount)"
    }

    func generatePercentage(target: Int, process: Int) -> Double {
        if process <= 0 || target <= 0 {
            return 0
        }
        
        if process > target {
            return 1.0
        }
        
        return Double(process)/Double(target)
    }

    func formatDateToIndonesian(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        let date =  Date()
        
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }

    func timeToReachTarget(target: Int, savingsPerPeriod: Int, period: PeriodSelection) -> String {
        var periodsRequired: Int
        
        if savingsPerPeriod <= 0 {
            periodsRequired = 0
        } else {
            periodsRequired = Int(ceil(Double(target) / Double(savingsPerPeriod)))
        }
        
        let unit: String
        
        switch period {
        case .daily:
            unit = "hari"
        case .weekly:
            unit = "minggu"
        case .monthly:
            unit = "bulan"
        }
        
        return "\(periodsRequired) \(unit) lagi"
    }

    func estimateCompletionDate(savingTarget: Double, savingPerPeriod: Double, period: PeriodSelection) -> String {
        let calendar = Calendar.current
        
        let periodsNeeded = Int(ceil(savingTarget / savingPerPeriod))
        
        var dateComponent = DateComponents()
        switch period {
        case .daily:
            dateComponent.day = periodsNeeded
        case .weekly:
            dateComponent.weekOfYear = periodsNeeded
        case .monthly:
            dateComponent.month = periodsNeeded
        }
        
        guard let completionDate = calendar.date(byAdding: dateComponent, to: Date()) else {
            return "Unable to calculate completion date."
        }
        
        let daysRemaining = calendar.dateComponents([.day], from: Date(), to: completionDate).day!
        
        // Format the completion date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID") // Set locale to Indonesian
        dateFormatter.dateFormat = "d MMMM yyyy" // Set date format
        let formattedDate = dateFormatter.string(from: completionDate)
        
        return "\(formattedDate) (\(daysRemaining) Hari lagi)"
    }
}


