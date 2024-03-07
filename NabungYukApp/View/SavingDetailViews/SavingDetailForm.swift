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
    
    @Binding var isPresented: Bool
    @State private var recordType = HistoryType.insert
    @State private var amount = ""
    
    @FocusState private var focusedField: FocusedField?
    var content: SavingGoal
    var savingVM: SavingVM
    
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
                        amount = String(content.targetSavePerPeriod)
                    } label: {
                        Text("\(content.targetSavePerPeriod)")
                            .foregroundStyle(.primary)
                            .padding(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                            }
                    }
                    .transition(.opacity)
                    
                    Button {
                        amount = String(content.target - content.gatheredAmount)
                    } label: {
                        Text("\(content.target - content.gatheredAmount)")
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
                let amountInt = Int(amount) ?? 0
                
                if amountInt != 0 {
                    savingVM.editSavingIncome(savingId: content.id, total: amountInt, historyType: recordType)
                    isPresented = false
                }
                
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .clipShape(Circle())
            }
        }
    }
}

#Preview {
    SavingDetailForm(isPresented: .constant(false), content: SavingGoal.savingGoals[0], savingVM: SavingVM())
}
