//
//  SavingView.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 28/02/24.
//

import SwiftUI

struct SavingView: View {
    @StateObject private var savingVM = SavingVM()
    @State private var preferredListTabungan = Tabungan.berlangsung
    @State private var isSheetShowing = false
    enum Tabungan {
        case berlangsung, tercapai
    }
    
    private var filteredSavings: [SavingGoal] {
        switch preferredListTabungan {
        case .berlangsung:
            savingVM.savings.filter { 
                $0.target > $0.gatheredAmount
            }.reversed()
        case .tercapai:
            savingVM.savings.filter {
                $0.target <= $0.gatheredAmount
            }.reversed()
        }
    
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Picker("List Tabungan", selection: $preferredListTabungan) {
                        Text("Berlangsung").tag(Tabungan.berlangsung)
                        Text("Tercapai").tag(Tabungan.tercapai)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                        VStack(spacing: 14) {
                            if filteredSavings.isEmpty {
                                EmptySavingListPlaceholder()
                            } else {
                                ForEach(filteredSavings) { saving in
                                    NavigationLink {
                                        let savingDetailVM = SavingDetailVM(content: saving, savingVM: savingVM)
                                        SavingDetailViews(content: saving, savingVM: savingVM, viewModel: savingDetailVM)
                                    } label: {
                                        SavingCard(content: saving, count: filteredSavings.count, action: {
                                            savingVM.deleteTabungan(savingId: saving.id)
                                        })
                                    }
                                    
                                }
                                Spacer()
                            }
                        }
                        .transition(.slide)
                        .padding(.horizontal)
                    }
                }
                .background(.ultraThinMaterial)
                .navigationTitle("Tabungan")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            isSheetShowing = true
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .sheet(isPresented: $isSheetShowing) {
                    NavigationStack {
                        FormView(savingVM: savingVM, isSheetShowing: $isSheetShowing)
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
                            }
                    }
                    
                }
            }
        }
    }

#Preview {
    SavingView()
}

@ViewBuilder
func EmptySavingListPlaceholder() -> some View {
    Spacer()
    VStack {
        Image("noneImage")
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
        Text("Belum ada tabungan")
    }
}
