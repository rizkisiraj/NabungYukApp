//
//  OnboardingView.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 27/02/24.
//

import SwiftUI

struct OnboardingView: View {
    private let onboardings = Onboarding.datas
    @State private var selectedTab: Int = 0
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                ForEach(onboardings, id: \.id) { tab in
                    Group {
                        OnboardingSingleView(content: tab)
                    }
                    .tag(tab.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            CustomDotIndicator(count: 3, selectedTab: $selectedTab)
            Spacer(minLength: 60)
            
            Button {
                isOnboarding = false
            } label: {
                Text("Get Started")
                    .font(.system( size: 18))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding([.top, .bottom], 16)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding()
        .background(.white)
    }
}

#Preview {
    OnboardingView()
}
