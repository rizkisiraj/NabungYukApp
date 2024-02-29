//
//  FormView.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 29/02/24.
//

import SwiftUI

struct FormView: View {
    enum FocusedField {
        case target
    }

    
    @State private var savingName = ""
    @State private var targetSaving = ""
    @State private var period: PeriodSelection = PeriodSelection.daily
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        Form {
            Section("Deskripsi Tabungan") {
                TextField("Nama Tabungan", text: $savingName)
                TextField("Target Tabungan", text: $targetSaving)
                    .focused($focusedField, equals: .target)
                                    .numbersOnly($targetSaving)
            }
            
            Section("Rencana Pengisian") {
                Picker("Periode Pengisian", selection: $period) {
                    ForEach(PeriodSelection.allCases, id: \.self) {period in
                        Text("\(period.rawValue)").tag(period)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .formStyle(.grouped)
    }
}

#Preview {
    FormView()
}
