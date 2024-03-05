//
//  FormView.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 29/02/24.
//

import SwiftUI

struct FormView: View {
    enum FocusedField {
        case targetSaving
        case savingPerPeriod
    }
    
    @StateObject var savingVM: SavingVM
    @Binding var isSheetShowing: Bool
    @State private var savingName = ""
    @State private var targetSaving = ""
    @State private var savingPerPeriod = ""
    @State private var period: PeriodSelection = PeriodSelection.daily
    @State private var selectedCategory = Category.travel
    @State private var isModalShowing = false
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
            VStack(alignment: .leading,spacing: 16) {
                HStack {
                    Image(systemName: "text.alignleft")
                    Spacer(minLength: 20)
                    TextField("Nama Tabungan", text: $savingName)
                        .autocorrectionDisabled()
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
                            .focused($focusedField, equals: .targetSaving)
                        .numbersOnly($targetSaving)
                        .padding()
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black.opacity(0.3), lineWidth: 2)
                    }
                }
                
                Text("Kategori")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        ForEach(Category.allCases, id: \.self) { category in
                                CategoryCard(category: category, selected: $selectedCategory)
                        }
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Rencana Pengisian")
                        .font(.headline)
                        .fontWeight(.bold)
                    Picker("Periode Pengisian", selection: $period) {
                            ForEach(PeriodSelection.allCases, id: \.self) {period in
                                Text("\(period.rawValue)").tag(period)
                            }
                        }
                    .pickerStyle(.segmented)
                }
                HStack {
                    TextField("Nominal Pengisian", text: $savingPerPeriod)
                        .focused($focusedField, equals: .savingPerPeriod)
                        .numbersOnly($savingPerPeriod)
                        .padding()
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black.opacity(0.3), lineWidth: 2)
                        }
                    Button {
                        isModalShowing = true
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
            .alert(Text("Estimasi Pengisian"), isPresented: $isModalShowing) {
                Button("Tutup", role: .cancel) {
                    
                }
            } message: {
                let targetSavingInt = Int(targetSaving) ?? 0
                let savingPerPeriodInt = Int(savingPerPeriod) ?? 0
                
                if targetSavingInt != 0 && savingPerPeriodInt != 0 {
                    Text(estimateCompletionDate(savingTarget: Double(targetSaving) ?? 0, savingPerPeriod: Double(savingPerPeriod) ?? 0, period: period))
                } else {
                    Text("Isi terlebih dahulu target tabungan dan nominal pengisian tiap periode")
                }
            }
            .navigationTitle("Tambah Tabungan")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSheetShowing = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .clipShape(Circle())
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        let targetSavingInt = Int(targetSaving) ?? 0
                        let savingPerPeriodInt = Int(savingPerPeriod) ?? 0
                        
                        if targetSavingInt != 0 && savingPerPeriodInt != 0 {
                            let newSavingGoal = SavingGoal(title: savingName, target: targetSavingInt, period: period, targetSavePerPeriod: savingPerPeriodInt, dummyImage: "dummyImage1", category: selectedCategory)
                            savingVM.addSavingGoal(savingGoal: newSavingGoal)
                            isSheetShowing = false
                        } else {
                            print("Ada yang salah teman")
                        }
                    } label: {
                        Text("Tambah")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .clipShape(Capsule())
                }
            }
    }
}

#Preview {
    FormView(savingVM: SavingVM(), isSheetShowing: .constant(false))
}

struct CategoryCard: View {
    var category: Category
    @Binding var selected: Category
    
    
    var body: some View {
        Group {
            if category == selected {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundStyle(.green.secondary)
                        .frame(width: 60, height: 60)
                    Image(systemName: category.rawValue)
                        .font(.title2)
                        .foregroundStyle(.green)
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundStyle(.gray.secondary)
                        .frame(width: 60, height: 60)
                    Image(systemName: category.rawValue)
                        .font(.title2)
                        .foregroundStyle(.gray)
                }
            }
        }
        .onTapGesture {
            withAnimation {
                selected = category
            }
        }
    }
}
