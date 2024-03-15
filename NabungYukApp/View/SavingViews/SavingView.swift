//
//  SavingView.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 28/02/24.
//

import SwiftUI
import SwiftData

enum Tabungan {
    case berlangsung, tercapai
}

struct SavingView: View {
    @Environment(\.modelContext) var modelContext
    @State private var isSheetShowing = false
    @State private var preferredListTabungan = Tabungan.berlangsung
    
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
                            SavingList(tabunganToShow: preferredListTabungan, action: deleteTabungan)
                        }
                        .transition(.slide)
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
//                        FormView(savingVM: savingVM, isSheetShowing: $isSheetShowing)
//                            .toolbar {
//                                ToolbarItem(placement: .topBarTrailing) {
//                                    Button {
//                                        isSheetShowing = false
//                                    } label: {
//                                        Image(systemName: "xmark")
//                                    }
//                                    .buttonStyle(.borderedProminent)
//                                    .tint(.red)
//                                    .clipShape(Circle())
//                                }
//                            }
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

extension SavingView {
    func deleteTabungan(saving: SavingGoal) {
        modelContext.delete(saving)
    }
}
