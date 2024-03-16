//
//  SavingDetailForm.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 06/03/24.
//

import SwiftUI

struct SavingDetailForm: View {
    enum FocusedField {
        case amount
    }
    
    @State private var recordType = HistoryType.insert
    @State private var amount = ""
    
    @FocusState private var focusedField: FocusedField?
    var saving: SavingGoal
    var incomeHandler: (Int, HistoryType) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Catat Tabungan")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Picker("Tipe Catatan", selection: $recordType) {
                ForEach(HistoryType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            TextField("Nominal Pengisian", text: $amount)
                        .focused($focusedField, equals: .amount)
                    .numbersOnly($amount)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.3), lineWidth: 2)
            }
            HStack {
                if recordType == HistoryType.insert {
                    Button {
                        amount = String(saving.targetSavePerPeriod)
                    } label: {
                        Text("\(saving.targetSavePerPeriod)")
                            .foregroundStyle(.primary)
                            .padding(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                            }
                    }
                    .transition(.opacity)
                    
                    Button {
                        amount = String(saving.target - saving.gatheredAmount)
                    } label: {
                        Text("\(saving.target - saving.gatheredAmount)")
                            .foregroundStyle(.primary)
                            .padding(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                            }
                    }
                    
                    Spacer()
                }

            }
            .tint(.black)
            .animation(.easeOut, value: recordType)
            
            Button {
                guard let amountInt = Int(amount) else { return }
                incomeHandler(amountInt, recordType)
            } label: {
                Text("Simpan")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
        }
        .padding()
    }
}

#Preview {
    let myFunction: (Int, HistoryType) -> Void = { number, history in
        print(number)
    }
    return SavingDetailForm(saving: SavingGoal.savingGoals[0], incomeHandler: myFunction)
}
