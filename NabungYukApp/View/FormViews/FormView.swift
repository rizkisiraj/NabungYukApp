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
    
    @State private var savingName = ""
    @State private var targetSaving = ""
    @State private var savingPerPeriod = ""
    @State private var period: PeriodSelection = PeriodSelection.daily
    @State private var selectedCategory = Category.travel
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack(alignment: .leading,spacing: 16) {
            HStack {
                Image(systemName: "text.alignleft")
                Spacer(minLength: 20)
                TextField("Nama Tabungan", text: $savingName)
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
    }
}

#Preview {
    FormView()
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
