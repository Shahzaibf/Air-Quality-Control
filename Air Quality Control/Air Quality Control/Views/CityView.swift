//
//  CircleNumberView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/9/24.
//

import SwiftUI

struct CityView: View {
    var quality: Int
    @State private var tip: String = ""
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
            .padding(.top)
            .onAppear {
                animate = true
                switch quality {
                case 1:
                    tip = "Hazardous: The air quality is dangerous. Avoid all outdoor activities, close all windows, and consider using an air purifier if possible. Health impacts are likely for everyone."
                case 2:
                    tip = "Very Unhealthy: The air quality poses a serious health risk. Limit time outside, wear a mask if necessary, and avoid physical exertion outdoors. Sensitive groups may experience severe health issues."
                case 3:
                    tip = "Unhealthy: The air quality is concerning. If you have a respiratory condition, stay indoors or wear a protective mask. Outdoor activities should be minimized, especially for children and elderly."
                case 4:
                    tip = "Moderate: Air quality is acceptable, but for some pollutants, there may be a moderate health concern. People who are unusually sensitive should consider limiting prolonged outdoor exertion."
                case 5:
                    tip = "Good: The air quality is ideal for outdoor activities. Feel free to enjoy the fresh air, as there is little or no risk to health."
                default:
                    tip = "No data available for this air quality level. Stay informed and check updates on air quality in your area."
                }
            }
        Text(tip)
            .font(
                .custom("Times New Roman", size: 20)
            )
            .foregroundColor(.primary)
            .multilineTextAlignment(.center)
            .padding([.top, .leading, .trailing])
        Spacer()
    }
}
#Preview {
    CityView(quality: 4)
}
