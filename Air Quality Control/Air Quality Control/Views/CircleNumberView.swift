//
//  CircleNumberView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/9/24.
//

import SwiftUI

struct CircleNumberView: View {
    var quality: Int
    private var circleColor: Color {
        switch quality {
        case 1:
            return .red
        case 2:
            return .orange
        case 3:
            return .yellow
        case 4:
            return Color(red: 0.5, green: 0.8392, blue: 0.5)
        case 5:
            return .green
        default:
            return .gray
        }
    }
    @State private var animate = false
        var body: some View {
            ZStack {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(circleColor)
                    .scaleEffect(animate ? 1.0 : 0.8)
                    .opacity(animate ? 1.0 : 0.7)
                    .shadow(color: circleColor.opacity(0.6), radius: 10, x: 0, y: 5)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: animate)
                Text("\(quality)")
                    .foregroundColor(.white)
                    .font(.system(size: 70, weight: .bold))
        }
            .onAppear {
                animate = true
            }
    }
}
#Preview {
    CircleNumberView(quality: 5)
}
