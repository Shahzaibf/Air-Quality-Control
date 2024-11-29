//
//  CircleNumberView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/9/24.
//

import SwiftUI

struct CityView: View {
    let airQuality: AQIResponse?
    @Environment(FavoriteStore.self) var favorites
    
    private var tip: String {
    switch airQuality?.list.first?.main.aqi {
        case 5:
            return "Hazardous: The air quality is dangerous. Avoid all outdoor activities, close all windows, and consider using an air purifier if possible. Health impacts are likely for everyone."
        case 4:
            return "Very Unhealthy: The air quality poses a serious health risk. Limit time outside, wear a mask if necessary, and avoid physical exertion outdoors. Sensitive groups may experience severe health issues."
        case 3:
            return "Unhealthy: The air quality is concerning. If you have a respiratory condition, stay indoors or wear a protective mask. Outdoor activities should be minimized, especially for children and elderly."
        case 2:
            return "Moderate: Air quality is acceptable, but for some pollutants, there may be a moderate health concern. People who are unusually sensitive should consider limiting prolonged outdoor exertion."
        case 1:
            return "Good: The air quality is ideal for outdoor activities. Feel free to enjoy the fresh air, as there is little or no risk to health."
        default:
            return "No data available for this air quality level. Stay informed and check updates on air quality in your area."
        }
    }
    private var circleColor: Color {
        switch airQuality?.list.first?.main.aqi {
        case 5:
            return .red
        case 4:
            return .orange
        case 3:
            return .yellow
        case 2:
            return Color(red: 0.5, green: 0.8392, blue: 0.5)
        case 1:
            return .green
        default:
            return .gray
        }
    }
    @State private var animate = false
    var body: some View {
        VStack {
            Text("\(airQuality?.location ?? "Unknown Location")")
                .font(
                    .custom("Times New Roman", size: 36)
                )
                .multilineTextAlignment(.center)
                .padding(.top)
            ZStack {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(circleColor)
                    .scaleEffect(animate ? 1.0 : 0.8)
                    .opacity(animate ? 1.0 : 0.7)
                    .shadow(color: circleColor.opacity(0.6), radius: 10, x: 0, y: 5)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: animate)
                Text("\(airQuality?.list.first?.main.aqi ?? -1)")
                    .foregroundColor(.white)
                    .font(.system(size: 70, weight: .bold))
            }
            .padding(.top)
            .onAppear {
                animate = true
            }
            Text(tip)
                .font(
                    .custom("Times New Roman", size: 20)
                )
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing])
            Spacer()
            
            HStack {
                Text("\"co\": \(airQuality?.list.first?.components.co ?? -1.0), \"no\": \(airQuality?.list.first?.components.no ?? -1.0), \"no2\": \(airQuality?.list.first?.components.no2 ?? -1.0), \"o3\": \(airQuality?.list.first?.components.o3 ?? -1.0),\"so2\": \(airQuality?.list.first?.components.so2 ?? -1.0), \"pm2_5\": \(airQuality?.list.first?.components.pm25 ?? -1.0), \"pm10\": \(airQuality?.list.first?.components.pm10 ?? -1.0), \"nh3\": \(airQuality?.list.first?.components.nh3 ?? -1.0)")
                    .font(
                        .custom("Times New Roman", size: 16)
                    )
                    .padding(.bottom)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
