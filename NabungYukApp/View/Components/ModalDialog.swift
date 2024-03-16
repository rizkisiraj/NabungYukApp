//
//  ModalDialog.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 03/03/24.
//

import SwiftUI

struct ModalDialog: View {
    @Binding var isActive: Bool
    
    let title: String
    let message: String
    let buttonTitle: String
    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)

            VStack {
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()

                VStack(alignment: .center, spacing: 10 ) {
                    Text("Target Tabungan")
                        .font(.headline)
                    Text("500.000")
                        .padding(.bottom)
                    
                    Text("Rencana Pengisian")
                        .font(.headline)
                    Text("500.000 Harian")
                        .padding(.bottom)
                    
                    Text("Estimasi Tercapai")
                        .font(.headline)
                    Text("24 Maret 2024 (800 Hari)")
                        .padding(.bottom)
                }

                Button {
                    withAnimation(.spring()) {
                        offset = 1000
                        isActive.toggle()
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.red)

                        Text(buttonTitle)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                    print("siu")
                }
            }
        }
        .ignoresSafeArea()
    }

    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isActive = false
        }
    }
}

struct CustomDialog_Previews: PreviewProvider {
    static var previews: some View {
        ModalDialog(isActive: .constant(true), title: "Estimasi Tabungan", message: "This lets you choose which photos you want to add to this project.", buttonTitle: "Close")
    }
}
