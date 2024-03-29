//
//  FormView.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 29/02/24.
//

import SwiftUI

class InputValidation: ObservableObject {
    @Published var savingNameIsValid = true
    @Published var targetSavingIsValid = true
    @Published var savingPerPeriodIsValid = true
    
    @Published var savingNameErrorText = ""
    @Published var targetSavingErrorText = ""
    @Published var savingPerPeriodErrorText = ""
}

enum FocusedField {
    case targetSaving
    case savingPerPeriod
    case savingName
}

struct FormView: View {
    @Environment(\.modelContext) var modelContext
    let helper = Helpers.shared
    @State var savingNameIsValid = true
    @State var targetSavingIsValid = true
    @State var savingPerPeriodIsValid = true
    
    @State var savingNameErrorText = ""
    @State var targetSavingErrorText = ""
    @State var savingPerPeriodErrorText = ""
    
    @State private var forceUpdate = false
    @State private var inputValidation = InputValidation()
    @Binding var isSheetShowing: Bool
    @State private var savingName = ""
    @State private var targetSaving = ""
    @State private var savingPerPeriod = ""
    @State private var period: PeriodSelection = PeriodSelection.daily
    @State private var selectedCategory = Category.travel
    @State private var isModalShowing = false
    var savingGoal: SavingGoal?
    @FocusState private var focusedField: FocusedField?
    
    var targetSavingInt: Int {
        Int(targetSaving) ?? 0
    }
    var savingPerPeriodInt: Int {
        Int(savingPerPeriod) ?? 0
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading,spacing: 16) {
                
                CustomTextfield(text: $savingName, icon: "text.alignleft", title: "Nama Tabungan", type: .text, isValid: $savingNameIsValid, errorMessage: $savingNameErrorText)
                    .focused($focusedField, equals: .savingName)
                
                CustomTextfield(text: $targetSaving, icon: "number", title: "Target Tabungan", type: .number, isValid: $targetSavingIsValid, errorMessage: $targetSavingErrorText)
                    .focused($focusedField, equals: .targetSaving)
                
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
                    CustomTextfield(text: $savingPerPeriod, title: "Nominal Pengisian", type: .number, isValid: $savingPerPeriodIsValid, errorMessage: $savingPerPeriodErrorText)
                        .focused($focusedField, equals: .savingPerPeriod)
                    Button {
                        isModalShowing = true
                    } label: {
                        Image(systemName: "calendar.badge.checkmark")
                            .font(.title3)
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(Circle())
                    .padding(.bottom, 16)
                    .tint(.green)
                }
                Spacer()
                
                Button {
                    ResetValidation()
                    
                    if savingName.isEmpty {
                        savingNameIsValid = false
                        savingNameErrorText = "Nama tidak boleh kosong"
                    }
                    
                    if targetSavingInt == 0 || savingPerPeriodInt > targetSavingInt {
                        targetSavingIsValid = false
                        targetSavingErrorText = "Target tidak boleh lebih kecil dari nominal pengisian"
                        focusedField = .targetSaving
                    }
                    
                    if savingPerPeriodInt == 0 {
                        savingPerPeriodIsValid = false
                        savingPerPeriodErrorText = "Nominal pengisian tidak boleh kosong"
                        focusedField = .savingPerPeriod
                    }
                    
                    if savingNameIsValid && targetSavingIsValid && savingPerPeriodIsValid {
                        if let goal = savingGoal {
                            editSavingGoal(savingGoal: goal)
                        } else {
                            let newSavingGoal = SavingGoal(title: savingName, target: targetSavingInt, period: period, targetSavePerPeriod: savingPerPeriodInt, dummyImage: "dummyImage1", category: selectedCategory)
                            addSavingGoal(savingGoal: newSavingGoal)
                            
                        }
                        isSheetShowing = false
                        return
                    }
                } label: {
                    Text(savingGoal != nil ? "Simpan" : "Tambah" )
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .clipShape(Capsule())
                .padding(.bottom,8)
            }
            .padding()
            .alert(Text("Estimasi Pengisian"), isPresented: $isModalShowing) {
                Button("Tutup", role: .cancel) {
                    
                }
            } message: {
                let targetSavingInt = Int(targetSaving) ?? 0
                let savingPerPeriodInt = Int(savingPerPeriod) ?? 0
                
                if targetSavingInt != 0 && savingPerPeriodInt != 0 {
                    Text(helper.estimateCompletionDate(savingTarget: Double(targetSaving) ?? 0, savingPerPeriod: Double(savingPerPeriod) ?? 0, period: period))
                } else {
                    Text("Isi terlebih dahulu target tabungan dan nominal pengisian tiap periode")
                }
            }
            .navigationTitle(savingGoal != nil ? "Edit Tabungan" : "Tambah Tabungan")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                if let goal = savingGoal {
                    self.savingName = goal.title
                    self.targetSaving = String(goal.target)
                    self.savingPerPeriod = String(goal.targetSavePerPeriod)
                    self.period = goal.period
                    self.selectedCategory = goal.category
                }
            }
        }
    }
    
    func ResetValidation() {
        savingNameIsValid = true
        targetSavingIsValid = true
        savingPerPeriodIsValid = true
        
        savingNameErrorText = ""
        targetSavingErrorText = ""
        savingPerPeriodErrorText = ""
    }
}

#Preview {
    FormView(isSheetShowing: .constant(false))
        .modelContainer(DataController.previewContainer)
    
}

extension FormView {
    func addSavingGoal(savingGoal: SavingGoal) {
        withAnimation {
            modelContext.insert(savingGoal)
        }
    }
    
    func editSavingGoal(savingGoal: SavingGoal) {
        savingGoal.title = savingName
        savingGoal.target = targetSavingInt
        savingGoal.targetSavePerPeriod = savingPerPeriodInt
        savingGoal.setPeriod(period: period)
        savingGoal.setCategory(category: selectedCategory)
    }
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
