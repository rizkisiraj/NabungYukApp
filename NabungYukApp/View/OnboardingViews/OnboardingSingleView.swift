//
//  Onboarding.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 27/02/24.
//

import SwiftUI

struct OnboardingSingleView: View {
    var content: Onboarding
    var body: some View {
        VStack {
            Image(content.image)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding(.bottom)
            
            VStack(spacing: 10) {
                Text(content.title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(content.description)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .lineSpacing(4)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    OnboardingSingleView(content: Onboarding.datas[0])
}
