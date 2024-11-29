//
//  HomePageView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/6/24.
//

import SwiftUI
import CoreLocationUI

struct HomePageView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var location: String = ""
    @State private var AirQuality: AQIResponse?
    @State private var animate = false
    @State private var circleColor: Color = .gray
    @State private var tip: String = ""
    @State private var favorites = FavoriteStore()
    
    
    private func fetchAirQuality() async throws {
            print("FETCHING")
            guard let location = locationManager.location else {
                print("No location available.")
                return
            }
            do {
                print("Fetching AQI for coordinates: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                let result = try await fetchAQI(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                print("API received: \(result)")
                await MainActor.run {
                    self.AirQuality = result
                    self.AirQuality?.location = "Your Location AQI:"
                    update()
                }
            } catch {
                print("Error fetching AQI: \(error)")
            }
        }
    
    private func update() {
            guard let aqi = AirQuality?.list.first?.main.aqi else { return }
            circleColor = colorForAQI(aqi: aqi)
            tip = tipForAQI(aqi: aqi)
        }
    
    private func colorForAQI(aqi: Int) -> Color {
            switch aqi {
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
                return .white
            }
        }
    
    private func tipForAQI(aqi: Int) -> String {
            switch aqi {
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
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Air Quality Control")
                        .font(
                            .custom("Times New Roman", size: 36)
                        )
                        .padding(.top)
                    Text("\(AirQuality?.location ?? "Unknown Location")")
                        .font(
                            .custom("Times New Roman", size: 20)
                        )
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding([.top, .leading, .trailing])
                    ZStack {
                        Circle()
                            .frame(width: 200, height: 200)
                            .foregroundColor(circleColor)
                            .scaleEffect(animate ? 1.0 : 0.8)
                            .opacity(animate ? 1.0 : 0.7)
                            .shadow(color: circleColor.opacity(0.6), radius: 10, x: 0, y: 5)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: animate)
                        Text("\(AirQuality?.list.first?.main.aqi ??  -1)")
                            .foregroundColor(.white)
                            .font(.system(size: 70, weight: .bold))
                    }
                    .padding(.top)
                    .onAppear {
                        animate = true
                    }
                    Text(tip)
                        .font(
                            .custom("Times New Roman", size: 16)
                        )
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding([.top, .leading, .trailing])
                    
                    HStack {
                        Text("\"co\": \(AirQuality?.list.first?.components.co ?? -1.0), \"no\": \(AirQuality?.list.first?.components.no ?? -1.0), \"no2\": \(AirQuality?.list.first?.components.no2 ?? -1.0), \"o3\": \(AirQuality?.list.first?.components.o3 ?? -1.0),\"so2\": \(AirQuality?.list.first?.components.so2 ?? -1.0), \"pm2_5\": \(AirQuality?.list.first?.components.pm25 ?? -1.0), \"pm10\": \(AirQuality?.list.first?.components.pm10 ?? -1.0), \"nh3\": \(AirQuality?.list.first?.components.nh3 ?? -1.0)")
                            .font(
                                .custom("Times New Roman", size: 16)
                            )
                            .padding([.top, .bottom])
                            .multilineTextAlignment(.center)
                    }
                    HStack {
                        Spacer()
                        NavigationLink(destination: InformationView()) {
                            HStack {
                                Text("More Information")
                                Image(systemName: "arrow.right")
                            }
                        }
                        .padding([.top, .trailing])
                        .buttonStyle(PurpleButton())
                    }
                    
                    Text("Search for the aqi of different cities!")
                        .font(
                            .custom("Times New Roman", size: 20)
                        )
                        .padding(.bottom)
                    VStack(alignment: .center) {
                        
                        NavigationLink(destination: SearchView()) {
                            HStack {
                                Text("Search")
                            }
                        }
                        .buttonStyle(PurpleButton())
                    }
                    .padding(.bottom)
                    NavigationLink(destination: FavoritesListView()) {
                        Image(systemName: "star.fill")
                            .font(.largeTitle)
                            .foregroundColor(.yellow)
                            .padding()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: .infinity)
                .padding()
                
            }
        }
        .navigationTitle("Home")
        .onAppear() {
            locationManager.requestLocation()
        }
        .onChange(of: locationManager.locationUpdated) { updated in
            if updated {
                Task {
                    try await fetchAirQuality()
                }
            }
        }
        .environment(favorites)
    }
    
}



#Preview {
    HomePageView()
}
