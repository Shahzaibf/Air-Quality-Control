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
    @State private var showMyLocView = false
    @State private var location: String = ""
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
                self.AirQuality?.location = "Your Location AQI:"
                self.showMyLocView = true
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
                        locationManager.requestLocation()
                    }
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .tint(.purple)
                    if let AirQuality {
                        NavigationLink(destination: CityView(airQuality: AirQuality), isActive: $showMyLocView) {
                            Text("See my AQI!")
                        }
                        .buttonStyle(PurpleButton())
                    }
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
                NavigationLink(destination: FavoritesListView()) {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                        .padding()
                }
                .buttonStyle(PlainButtonStyle())
            }
            .onChange(of: locationManager.locationUpdated) { updated in
                if updated {
                    Task {
                        try await fetchAirQuality()
                    }
                }
            }
        }
    }
}



#Preview {
    HomePageView()
}
