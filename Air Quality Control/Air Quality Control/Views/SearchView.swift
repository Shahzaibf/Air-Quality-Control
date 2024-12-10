//
//  SearchView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/8/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var cities = [City]()
    @State private var AirQuality: AQIResponse?
    @State private var navigateToDetails: Bool = false
    @State private var currentCity: City?
    @Environment(FavoriteStore.self) var favorites
    
    private func fetchAllCities() async throws {
        do {
            print("Fetching")
            let result = try await fetchCities(search: searchText)
            print("API recieved: \(result)")
            await MainActor.run {
                self.cities = result
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
    private func fetchAirQuality(city: City) async throws {
        do {
            let result = try await fetchAQI(lat: city.lat, lon: city.lon)
            print("API recieved: \(result)")
            await MainActor.run {
                self.AirQuality = result
                self.AirQuality?.location = city.name
                self.navigateToDetails = true
            }
        } catch APIError.invalidURL {
            print("Invalid URL error")
        } catch APIError.invalidResponse {
            print("Invalid response from server")
        }
    }
    var body: some View {
        NavigationStack {
            VStack {
                if (searchText.count == 0) {
                    Text("")
                } else if (searchText.count < 3) {
                    Text("Please enter at least 3 characters for search.")
                } else {
                    List(cities, id: \.self) { city in
                        Button {
                            currentCity = city
                            Task {
                                try await fetchAirQuality(city: city)
                            }
                        } label : {
                            HStack {
                                let state = city.state != nil ? ", \(city.state!)" : ""
                                Text("\(city.name), \(city.country)\(state)")
                                
                                if favorites.contains(city) {
                                    Spacer()
                                    Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite resort")
                                    .foregroundStyle(.red)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: searchText) { newValue in
                if newValue.count >= 3 {
                    Task {
                        try await fetchAllCities()
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToDetails) {
                if let airQuality = AirQuality, let currCity = currentCity {
                    CityView(airQuality: airQuality, currCity: currCity)
                }
            }
        }
        .searchable(text: $searchText)
        .customBackButton()
        
    }
}

#Preview {
    SearchView()
    
}
