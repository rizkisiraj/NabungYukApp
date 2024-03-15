//
//  SavingDetailViews.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 03/03/24.
//

import SwiftUI

struct SavingDetailViews: View {
    @Environment(\.modelContext) var modelContext
    @State private var isPresented = false
    @State private var isDeleting = false
    @State private var imageScale: CGFloat = 0.1
    @State private var isEditing = false
    
    @Bindable var contentSuave: SavingGoal
    
    var body: some View {
        if isEditing {
//            FormView(savingVM: savingVM, isSheetShowing: $isEditing, savingGoal: contentSuave)
//                .background(.ultraThinMaterial)
//                .toolbar {
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Button {
//                            withAnimation {
//                                isEditing = false
//                            }
//                            
//                        } label: {
//                                Text("Cancel")
//                        }
//                        .tint(.green)
//                    }
//                    
//            }
        } else {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundStyle(.green.secondary)
                                .frame(width: .infinity, height: 200)
                            Image(systemName: contentSuave.category.rawValue)
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
                                    Text(formatNumberToRupiah(number: contentSuave.target))
                                        .font(.system(size: 24))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text("\(formatNumberToRupiah(number: contentSuave.targetSavePerPeriod)) \(contentSuave.period.rawValue)")
                                        .font(.headline)
                                }
                                Spacer()
                                ZStack {
                                    CircularProgressView(progress: generatePercentage(target:contentSuave.target, process: contentSuave.gatheredAmount))
                                    Text("\(generatePercentage(target:contentSuave.target, process: contentSuave.gatheredAmount) * 100, specifier: "%.0f")%")
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
                                    Text(formatDateToIndonesian(date: contentSuave.createdAt))
                                }
                                HStack {
                                    Text("Estimasi Tercapai")
                                        .font(.headline)
                                    Spacer()
                                    Text(timeToReachTarget(target: contentSuave.target-contentSuave.gatheredAmount, savingsPerPeriod:contentSuave.targetSavePerPeriod, period:contentSuave.period))
                                }
                            }
                            .padding(.vertical)
                            Divider()
                            HStack {
                                VStack(spacing: 4) {
                                    Text("Terkumpul")
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text(formatNumberToRupiah(number: (contentSuave.gatheredAmount)))
                                        .font(.title3)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(.green)
                                }
                                .padding(.trailing, 32)
                                VStack(spacing: 4) {
                                    Text("Tersisa")
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text(formatNumberToRupiah(number: (contentSuave.target - contentSuave.gatheredAmount)))
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
//                                ForEach(savingHistories, id: \.id) { history in
//                                    
//                                    HStack {
//                                        Text(formatDateToIndonesian(date: history.createdAt))
//                                        Spacer()
//                                        
//                                        switch(history.historyType) {
//                                        case .insert:
//                                            Text("+ \(formatNumberToRupiah(number: history.total))")
//                                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                                                .foregroundStyle(.green)
//                                        case .withdraw:
//                                            Text("- \(formatNumberToRupiah(number: history.total))")
//                                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                                                .foregroundStyle(.red)
//                                        }
//                                    }
//                                    .padding(.bottom)
//                                    
//                                }
                            }
                            .padding()
                            .padding(.bottom, 32)
                        }
                    }
                    .padding(.horizontal)
                    .navigationTitle(contentSuave.title)
                    .toolbar(.hidden, for: .tabBar)
                    
                }
                .background(.ultraThinMaterial)
                if contentSuave.gatheredAmount < contentSuave.target {
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
                    SavingDetailForm(saving: contentSuave, incomeHandler: editSavingIncome)
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
    func editSavingIncome(amount: Int) {
        guard amount >= 0 else { return }
        
        contentSuave.gatheredAmount += amount
        isPresented = false
    }
}
