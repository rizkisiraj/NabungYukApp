//
//  CustomTextfield.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 08/03/24.
//

import SwiftUI

struct CustomTextfield: View {
    enum TextFieldType {
        case text, number
    }
    
    @Binding var text: String
    var icon: String?
    var title: String
    var type: TextFieldType
    @Binding var isValid: Bool
    @Binding var errorMessage: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let iconName = icon {
                    Image(systemName: iconName)
                    Spacer(minLength: 20)
                }
                
                Group {
                    switch type {
                    case .text:
                        TextField(title, text: $text)
                            .autocorrectionDisabled()
                    case .number:
                        TextField(title, text: $text)
                            .numbersOnly($text)
                            
                    }
                }
                .padding()
                .background(isValid ? .gray.opacity(0.1) : .red.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke((isValid ? .black.opacity(0.3) : .red.opacity(0.3)), lineWidth: 2)
            }
        }
            HStack {
                if icon != nil {
                    Spacer()
                        .frame(width: 40)
                }
                Text(errorMessage )
                        .font(.caption)
                        .frame(minHeight: 12)
                        .padding(.leading)
                        .foregroundStyle(.red)
                        .transition(.opacity)
                        .animation(.default, value: isValid)
            }
        }
    }
}

#Preview {
    CustomTextfield(text: .constant("Siu"), title: "Nama Tabungan", type: .text, isValid: .constant(false), errorMessage: .constant("Tidak boleh sama"))
}
