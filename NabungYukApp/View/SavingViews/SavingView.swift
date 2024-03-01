//
//  SavingView.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 28/02/24.
//

import SwiftUI

struct SavingView: View {
    private let savings = SavingGoal.savingGoals
    @State private var preferredListTabungan = Tabungan.berlangsung
    @State private var isSheetShowing = false
    enum Tabungan {
        case berlangsung, tercapai
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
                            ForEach(savings) { saving in
                                SavingCard(content: saving)
                            }
                            
                            Spacer()
                        }
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
                        FormView()
                            .navigationTitle("Tambah Tabungan")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .confirmationAction) {
                                    Button {
                                        
                                    } label: {
                                        Text("Selesai")
                                    }
                                }
                                
                                ToolbarItem(placement: .cancellationAction) {
                                    Button {
                                        
                                    } label: {
                                        Text("Batal")
                                    }.tint(.red)
                                }
                            }
                    }
                    .presentationDetents([.medium, .large])
                    
                }
            }
        }
    }

#Preview {
    SavingView()
}

//HStack {
////                    VStack(alignment: .leading) {
////                        Text("Total Savings")
////                            .font(.caption)
////                            .foregroundStyle(.secondary)
////                        Text("Rp 40.000,00")
////                            .fontWeight(.bold)
////                    }
////
////                    Spacer()
////
////                    Button {
////
////                    } label: {
////                        Text("View Analytics")
////                            .font(.system(size: 14))
////                            .underline()
////                    }
////                }
////                .padding()
