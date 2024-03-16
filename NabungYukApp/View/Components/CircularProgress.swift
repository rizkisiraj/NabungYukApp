//
//  CircularProgressView.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 03/03/24.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    @State private var animatedProgress: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.green.opacity(0.5),
                    lineWidth: 7
                )
            Circle()
                .trim(from: 0, to: animatedProgress)
                .stroke(
                    Color.green,
                    style: StrokeStyle(
                        lineWidth: 7,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .onAppear {
                    withAnimation(.easeOut(duration: 1)) {
                        animatedProgress = progress
                    }
                }
                .onChange(of: progress) { newValue in
                    withAnimation(.easeOut(duration: 1)) {
                        animatedProgress = newValue
                    }
                }

        }
    }
}

#Preview {
    CircularProgressView(progress: 60)
}
