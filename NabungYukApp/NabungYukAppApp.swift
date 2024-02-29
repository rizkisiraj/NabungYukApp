//
//  NabungYukAppApp.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 27/02/24.
//

import SwiftUI

@main
struct NabungYukAppApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
            } else {
                ContentView()
            }
            
        }
    }
}
