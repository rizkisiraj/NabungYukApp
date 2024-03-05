//
//  Helper.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 05/03/24.
//

import Foundation

func formatNumberToRupiah(number: Int) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "id_ID")
    formatter.groupingSeparator = "."
    formatter.numberStyle = .decimal
    let formattedAmount = formatter.string(from: number as NSNumber) ?? ""
    return "Rp\(formattedAmount)"
}

func generatePercentage(target: Int, process: Int) {
    
}

func formatDateToIndonesian(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "id_ID")
    dateFormatter.dateFormat = "dd MMMM yyyy"
    
    let date =  Date()
    
    let formattedDate = dateFormatter.string(from: date)
    
    return formattedDate
}
