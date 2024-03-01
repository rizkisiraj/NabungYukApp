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
    @State private var savingPerPeriod = ""
    @State private var period: PeriodSelection = PeriodSelection.daily
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "text.alignleft")
                Spacer(minLength: 20)
                TextField("Nama Tabungan", text: $savingName)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.3), lineWidth: 2)
                }
            }
            HStack {
                Image(systemName: "number")
                Spacer(minLength: 20)
                TextField("Target Tabungan", text: $targetSaving)
                        .focused($focusedField, equals: .target)
                    .numbersOnly($targetSaving)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.3), lineWidth: 2)
                }
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Rencana Pengisian")
                Picker("Periode Pengisian", selection: $period) {
                        ForEach(PeriodSelection.allCases, id: \.self) {period in
                            Text("\(period.rawValue)").tag(period)
                        }
                    }
                .pickerStyle(.segmented)
            }
            HStack {
                TextField("Nominal Pengisian", text: $targetSaving)
                    .focused($focusedField, equals: .target)
                    .numbersOnly($targetSaving)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.3), lineWidth: 2)
                    }
                Button {
                    
                } label: {
                    Image(systemName: "calendar.badge.checkmark")
                        .font(.title3)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Circle())
                .tint(.green)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    FormView()
}
