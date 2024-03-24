//
//  SavingDetailViews.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 03/03/24.
//

import SwiftUI

struct SavingDetailViews: View {
    @Environment(\.modelContext) var modelContext
    let helpers = Helpers.shared
    @State private var isPresented = false
    @State private var isDeleting = false
    @State private var imageScale: CGFloat = 0.1
    @State private var isEditing = false
    
    @Bindable var content: SavingGoal
    
    var timeToReachTarget: String {
        helpers.timeToReachTarget(target: content.target-content.gatheredAmount, savingsPerPeriod: content.targetSavePerPeriod, period: content.period)
    }
    
    var currentAmount: String {
        helpers.formatNumberToRupiah(number: content.gatheredAmount)
    }
    
    var currentTarget: String {
        helpers.formatNumberToRupiah(number: content.target)
    }
    
    var targetSavePerPeriod: String {
        helpers.formatNumberToRupiah(number: content.targetSavePerPeriod)
    }
    
    var progressPercentage: Double {
        helpers.generatePercentage(target: content.target, process: content.gatheredAmount)
    }
    
    var createdDateIndonesian: String {
        helpers.formatDateToIndonesian(date: content.createdAt)
    }
    
    var differences: String {
        helpers.formatNumberToRupiah(number: content.target - content.gatheredAmount)
    }
    
    var body: some View {
        if isEditing {
            FormView(isSheetShowing: $isEditing, savingGoal: content)
                .background(.ultraThinMaterial)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation {
                                isEditing = false
                            }
                            
                        } label: {
                                Text("Cancel")
                        }
                        .tint(.green)
                    }
                    
            }
        } else {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundStyle(.green.secondary)
                                .frame(width: .infinity, height: 200)
                            Image(systemName: content.category.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundStyle(.green)
                                .scaleEffect(imageScale)
                                .onAppear {
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        imageScale = 1
                                    }
                                }
                        }
                        VStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(currentTarget)
                                        .font(.system(size: 24))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text("\(targetSavePerPeriod) \(content.period.rawValue)")
                                        .font(.headline)
                                }
                                Spacer()
                                ZStack {
                                    CircularProgressView(progress: progressPercentage)
                                    Text("\(progressPercentage * 100, specifier: "%.0f")%")
                                        .font(.system(size: 14))
                                        .bold()
                                }.frame(width: 50, height: 50)
                            }
                            .padding(.vertical)
                            Divider()
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Tanggal Dibuat")
                                        .font(.headline)
                                    Spacer()
                                    Text(createdDateIndonesian)
                                }
                                HStack {
                                    Text("Estimasi Tercapai")
                                        .font(.headline)
                                    Spacer()
                                    Text(timeToReachTarget)
                                }
                            }
                            .padding(.vertical)
                            Divider()
                            HStack {
                                VStack(spacing: 4) {
                                    Text("Terkumpul")
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text(currentAmount)
                                        .font(.title3)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(.green)
                                }
                                .padding(.trailing, 32)
                                VStack(spacing: 4) {
                                    Text("Tersisa")
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text(differences)
                                        .font(.title3)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(.red)
                                }
                            }
                            .padding()
                            
                            Divider()
                            VStack {
                                Text("Riwayat")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 10)
                                ForEach(content.histories, id: \.id) { history in
                                    HistorySingle(history: history)
                                }
                            }
                            .padding()
                            .padding(.bottom, 32)
                        }
                    }
                    .padding(.horizontal)
                    .navigationTitle(content.title)
                    .toolbar(.hidden, for: .tabBar)
                    
                }
                .background(.ultraThinMaterial)
                if content.gatheredAmount < content.target {
                    Button {
                        isPresented = true
                    } label: {
                        HStack {
                            Image(systemName: "pencil.and.list.clipboard")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("Catat Tabungan")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    .padding()
                }
            }
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    SavingDetailForm(saving: content, incomeHandler: editSavingIncome)
                        .navigationBarTitleDisplayMode(.inline)
                }.presentationDetents([.medium])
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            isEditing = true
                        }
                        
                    } label: {
                            Text("Edit")
                    }
                    .tint(.green)
                }
                
        }
        }
        
    }
}

#Preview {
    NavigationStack {
        Text("Siraj")
    }
    .preferredColorScheme(.dark)
}

extension SavingDetailViews {
    func editSavingIncome(amount: Int, historyType: HistoryType) {
        guard amount >= 0 else { return }
        
        if historyType == .withdraw && content.gatheredAmount <= 0 {
            return
        }
        
        switch historyType {
        case .insert:
            content.gatheredAmount += amount
        case .withdraw:
            content.gatheredAmount -= amount
        }
        content.histories.append(History(total: amount, historyType: historyType))
        
        isPresented = false
    }
}
