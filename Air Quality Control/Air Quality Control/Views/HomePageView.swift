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
    @State private var showLocation: Bool = false
    @State private var AirQuality: AQIResponse?
    
    private func fetchAirQuality() async throws {
        guard let location = locationManager.location else {
        print("No location available.")
        return
        }
        do {
            print("Fetching")
            let result = try await fetchAQI(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            print("API recieved: \(result)")
            await MainActor.run {
                self.AirQuality = result
            }
        } catch APIError.invalidURL {
            print("Invalid URL error")
        } catch APIError.invalidResponse {
            print("Invalid response from server")
        } catch APIError.invalidData {
            print("Invalid data received")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                Text("Air Quality Control")
                    .font(
                        .custom("Times New Roman", size: 36)
                    )
                    .padding(.top)
                Text("This app, takes your location or allows you to enter your location, and then displays the air quality index for that location.")
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding([.top, .leading, .trailing])
                    .font(
                        .custom("Times New Roman", size: 20)
                    )
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
                Spacer()
                Text("Find out the air quality index by:")
                    .font(
                        .custom("Times New Roman", size: 20)
                    )
                    .padding(.bottom)
                VStack(alignment: .center) {
                    LocationButton(.currentLocation) {
                        print("Clicked")
                        showLocation = true
                        locationManager.requestLocation()
                        Task {
                            try await fetchAirQuality()
                        }
                    }
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .tint(.purple)
                    
                    Text("OR")
                    .font(
                        .custom("Times New Roman", size: 20)
                    )
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Text("Search")
                        }
                    }
                    .buttonStyle(PurpleButton())
                }
                .padding(.bottom)
                if showLocation, let location = locationManager.location {
                    let _ = print("DONE LOC ! ! ")
                    Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
                        .font(.custom("Times New Roman", size: 16))
                        .padding()
                    
                }
                if AirQuality != nil, let firstEntry = AirQuality?.list.first {
                    let _ = print("DONE ! ! !")
                    Text("Air Quality Index (AQI): \(firstEntry.main.aqi)")
                        .font(.custom("Times New Roman", size: 18))
                        .padding()
                    
                    Text("Pollutant Components:")
                        .font(.custom("Times New Roman", size: 18))
                        .padding(.top)
                    
                    VStack(alignment: .leading) {
                        Text("CO: \(firstEntry.components.co)")
                        Text("NO: \(firstEntry.components.no)")
                        Text("NO2: \(firstEntry.components.no2)")
                        Text("O3: \(firstEntry.components.o3)")
                        Text("SO2: \(firstEntry.components.so2)")
                        Text("PM2.5: \(firstEntry.components.pm25)")
                        Text("PM10: \(firstEntry.components.pm10)")
                        Text("NH3: \(firstEntry.components.nh3)")
                    }
                    .font(.custom("Times New Roman", size: 16))
                    .padding(.leading)
                }
                
                NavigationLink(destination: FavoritesListView()) {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                        .padding()
                }
                .buttonStyle(PlainButtonStyle())
                .onChange(of: locationManager.location) { newLocation in
                    if newLocation != nil {
                        Task {
                            try await fetchAirQuality()
                        }
                    }
                }
            }
        }
    }
    
}



#Preview {
    HomePageView()
}
