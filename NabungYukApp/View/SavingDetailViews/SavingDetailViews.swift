//
//  SavingDetailViews.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 03/03/24.
//

import SwiftUI

struct SavingDetailViews: View {
    @State private var isPresented = false
    @State private var imageScale: CGFloat = 0.1
    var content: SavingGoal
    var savingVM: SavingVM
    
    var body: some View {
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
                                Text(formatNumberToRupiah(number: content.target))
                                    .font(.system(size: 24))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text("\(formatNumberToRupiah(number: content.targetSavePerPeriod)) \(content.period.rawValue)")
                                    .font(.headline)
                            }
                            Spacer()
                            ZStack {
                                CircularProgressView(progress: generatePercentage(target:content.target, process: content.gatheredAmount))
                                Text("\(generatePercentage(target:content.target, process: content.gatheredAmount) * 100, specifier: "%.0f")%")
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
                                Text(timeToReachTarget(target: content.target, savingsPerPeriod:content.targetSavePerPeriod, period:content.period))
                            }
                        }
                        .padding(.vertical)
                        Divider()
                        HStack {
                            VStack(spacing: 4) {
                                Text("Terkumpul")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text(formatNumberToRupiah(number: (content.gatheredAmount)))
                                    .font(.title3)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundStyle(.green)
                            }
                            .padding(.trailing, 32)
                            VStack(spacing: 4) {
                                Text("Tersisa")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text(formatNumberToRupiah(number: (content.target - content.gatheredAmount)))
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
                            ForEach(savingVM.savingHistories, id: \.id) { history in
                                
                                HStack {
                                    Text(formatDateToIndonesian(date: history.createdAt))
                                    Spacer()
                                    
                                    switch(history.historyType) {
                                    case .insert:
                                        Text("+ \(formatNumberToRupiah(number: history.total))")
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundStyle(.green)
                                    case .withdraw:
                                        Text("- \(formatNumberToRupiah(number: history.total))")
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundStyle(.red)
                                    }
                                }
                                .padding(.bottom)
                                
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
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                SavingDetailForm(isPresented: $isPresented, content: content, savingVM: savingVM)
                    .navigationBarTitleDisplayMode(.inline)
            }.presentationDetents([.medium])
        }
    }
}

#Preview {
    SavingDetailViews(content: SavingGoal.savingGoals[0], savingVM: SavingVM())
}
