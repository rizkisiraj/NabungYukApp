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
    @Query var shavings: [SavingGoal]
    @StateObject var savingVM: SavingVM
    @State private var isSheetShowing = false
    @Binding var preferredListTabungan: Tabungan
    
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
                            if shavings.isEmpty {
                                EmptySavingListPlaceholder()
                            } else {
                                ForEach(shavings) { saving in
                                    NavigationLink {
                                        SavingDetailViews(contentSuave: saving)
                                    } label: {
                                        SavingCard(content: saving, count: savingVM.savangs.count, action: {
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
    SavingView(savingVM: SavingVM(), preferredListTabungan: .constant(Tabungan.berlangsung))
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
