//
//  CircleNumberView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/9/24.
//

import SwiftUI

struct CityView: View {
    let airQuality: AQIResponse?
    let currCity: City
    @Environment(FavoriteStore.self) var favorites
    @State private var colors: [Color] = [.white, .white, .white, .white, .white, .white, .white, .white]
    
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
    
    private func colorForComponents(co: Float, no: Float, no2: Float, o3: Float, so2: Float, pm25: Float, pm10: Float, nh3: Float) -> [Color] {
        var colors: [Color] = Array(repeating: .clear, count: 8)
        let coColor: Color = co <= 4.4 ? .green : co <= 9.4 ? .yellow : co <= 12.4 ? .orange : .red
        let noColor: Color = no <= 53 ? .green : no <= 100 ? .yellow : no <= 360 ? .orange : .red
        let no2Color: Color = no2 <= 53 ? .green : co <= 100 ? .yellow : co <= 360 ? .orange : .red
        let o3Color: Color = o3 <= 54 ? .green : o3 <= 70 ? .yellow : o3 <= 85 ? .orange : .red
        let so2Color: Color = so2 <= 35 ? .green : so2 <= 75 ? .yellow : so2 <= 185 ? .orange : .red
        let pm25Color: Color = pm25 <= 12.0 ? .green : pm25 <= 35.4 ? .yellow : pm25 <= 55.4 ? .orange : .red
        let pm10Color: Color = pm10 <= 54 ? .green : pm10 <= 154 ? .yellow : pm10 <= 254 ? .orange : .red
        let nh3Color: Color = nh3 <= 100 ? .green : nh3 <= 200 ? .yellow : nh3 <= 500 ? .orange : .red
        colors[0] = coColor; colors[1] = noColor; colors[2] = no2Color; colors[3] = o3Color; colors[4] = so2Color; colors[5] = pm25Color; colors[6] = pm10Color; colors[7] = nh3Color
        return colors
    }
    
    
    private func update() {
        let co = airQuality?.list.first?.components.co ?? 0.0
        let no = airQuality?.list.first?.components.no ?? 0.0
        let no2 = airQuality?.list.first?.components.no2 ?? 0.0
        let o3 = airQuality?.list.first?.components.o3 ?? 0.0
        let so2 = airQuality?.list.first?.components.so2 ?? 0.0
        let pm25 = airQuality?.list.first?.components.pm25 ?? 0.0
        let pm10 = airQuality?.list.first?.components.pm10 ?? 0.0
        let nh3 = airQuality?.list.first?.components.nh3 ?? 0.0
        colors = colorForComponents(co: co, no: no, no2: no2, o3: o3, so2: so2,pm25: pm25, pm10: pm10, nh3: nh3)
    }
    
    
    @State private var animate = false
    var body: some View {
        ScrollView {
            VStack {
                //let _ = print("CITY VALUE: \(currCity)")
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
                    withAnimation {
                        animate.toggle()
                    }
                }
                Text(tip)
                    .font(
                        .custom("Times New Roman", size: 20)
                    )
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                Button(favorites.contains(currCity) ? "Remove from Favorites" : "Add to Favorites") {
                    if favorites.contains(currCity) {
                        favorites.remove(currCity)
                    } else {
                        favorites.add(currCity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Spacer()
                
                VStack {
                    Text("Air Quality Components")
                        .font(
                            .custom("Times New Roman", size: 24)
                        )
                        .bold()
                        .padding(.bottom, 10)
                    
                    Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 10) {
                        GridRow {
                            Text("Pollutant")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text("Value")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        
                        GridRow {
                            Text("CO")
                            Text("\(airQuality?.list.first?.components.co ?? -1.0, specifier: "%.2f") ppm")
                                .foregroundColor(colors[0])
                        }
                        
                        GridRow {
                            Text("NO")
                            Text("\(airQuality?.list.first?.components.no ?? -1.0, specifier: "%.2f") ppm")
                                .foregroundColor(colors[1])
                        }
                        
                        GridRow {
                            Text("NO2")
                            Text("\(airQuality?.list.first?.components.no2 ?? -1.0, specifier: "%.2f") ppm")
                                .foregroundColor(colors[2])
                        }
                        
                        GridRow {
                            Text("O3")
                            Text("\(airQuality?.list.first?.components.o3 ?? -1.0, specifier: "%.2f") ppm")
                                .foregroundColor(colors[3])
                        }
                        
                        GridRow {
                            Text("SO2")
                            Text("\(airQuality?.list.first?.components.so2 ?? -1.0, specifier: "%.2f") ppm")
                                .foregroundColor(colors[4])
                        }
                        
                        GridRow {
                            Text("PM2.5")
                            Text("\(airQuality?.list.first?.components.pm25 ?? -1.0, specifier: "%.2f") µg/m³")
                                .foregroundColor(colors[5])
                        }
                        
                        GridRow {
                            Text("PM10")
                            Text("\(airQuality?.list.first?.components.pm10 ?? -1.0, specifier: "%.2f") µg/m³")
                                .foregroundColor(colors[6])
                        }
                        
                        GridRow {
                            Text("NH3")
                            Text("\(airQuality?.list.first?.components.nh3 ?? -1.0, specifier: "%.2f") ppm")
                                .foregroundColor(colors[7])
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .padding()
            }
        }
        .onAppear {
            update()
        }
    }
}
