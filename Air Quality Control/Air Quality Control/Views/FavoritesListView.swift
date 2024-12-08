//
//  FavoritesListView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/8/24.
//

import SwiftUI

struct FavoritesListView: View {
    @Environment(FavoriteStore.self) var favorites
    @State private var cities = [City]()
    @State private var currentCity: City?
    @State private var AirQuality: AQIResponse?
    @State private var navigateToDetails: Bool = false
    
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
    private func deleteCity(at offsets: IndexSet) {
        for index in offsets {
            let city = cities[index]
            favorites.remove(city)
        }
        cities = favorites.allFavorites()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if cities.isEmpty {
                    Text("Search some cities and add them to favorites!")
                        .font(
                            .custom("Times New Roman", size: 18)
                        )
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    Spacer()
                } else {
                    Text("Favorites:")
                        .font(
                            .custom("Times New Roman", size: 18)
                        )
                    List {
                        ForEach(cities, id: \.self) { city in
                            Button {
                                currentCity = city
                                Task {
                                    try await fetchAirQuality(city: city)
                                }
                            } label : {
                                HStack {
                                    let state = city.state != nil ? ", \(city.state!)" : ""
                                    Text("\(city.name), \(city.country)\(state)")
                                    Spacer()
                                    Button {
                                        if favorites.contains(city) {
                                            favorites.remove(city)
                                        } else {
                                            favorites.add(city)
                                        }
                                    } label: {
                                        Image(systemName: favorites.contains(city) ? "heart.fill" : "heart")
                                            .accessibilityLabel(favorites.contains(city) ? "Remove from favorites" : "Add to favorites")
                                            .foregroundStyle(favorites.contains(city) ? .red : .gray)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteCity)
                    }
                }
            }
            .toolbar {
                if !cities.isEmpty {
                    EditButton()
                }
            }
            .navigationBarBackButtonHidden(true) 
            .onAppear() {
                cities = favorites.allFavorites()
            }
            .navigationDestination(isPresented: $navigateToDetails) {
                if let airQuality = AirQuality, let currCity = currentCity {
                    CityView(airQuality: airQuality, currCity: currCity)
                }
            }
        }
        
    }
}

#Preview {
    FavoritesListView()
}
