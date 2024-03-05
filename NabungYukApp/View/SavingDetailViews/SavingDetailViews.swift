//
//  SavingDetailViews.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 03/03/24.
//

import SwiftUI

struct SavingDetailViews: View {
    var content: SavingGoal
    
    var body: some View {
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
                }
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(formatNumberToRupiah(number: content.target))
                                .font(.system(size: 24))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("\(formatNumberToRupiah(number: content.targetSavePerPeriod)) \(content.period.rawValue)")
                                .font(.headline)
                        }
                        Spacer()
                        ZStack {
                            CircularProgressView(progress: 0.4)
                            Text("\(0.4 * 100, specifier: "%.0f")%")
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
                            Text(formatDateToIndonesian(date: content.createdAt))
                        }
                        HStack {
                            Text("Estimasi Tercapai")
                                .font(.headline)
                            Spacer()
                            Text("6 bulan lagi")
                        }
                    }
                    .padding(.vertical)
                    Divider()
                    HStack {
                        VStack(spacing: 4) {
                            Text("Terkumpul")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("Rp100.000")
                                .font(.title3)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.green)
                        }
                        Spacer()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        VStack(spacing: 4) {
                            Text("Tersisa")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("Rp500.000")
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
                        HStack {
                            Text("22 Agustus 2024")
                            Spacer()
                            Text("+ Rp100.000")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.green)
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal)
            .navigationTitle(content.title)
        }
    }
}

#Preview {
    SavingDetailViews(content: SavingGoal.savingGoals[0])
}
