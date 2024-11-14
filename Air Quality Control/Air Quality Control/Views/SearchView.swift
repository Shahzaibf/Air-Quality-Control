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
    var body: some View {
        NavigationStack {
            VStack {
                if (searchText.count == 0) {
                    Text("")
                } else if (searchText.count < 4) {
                    Text("Please enter at least 4 characters for search.")
                } else {
                    List(cities, id: \.name) { city in
                        Text(city.name)
                    }
                }
            }
            .navigationTitle("Search for a city!")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: searchText) { newValue in
                if newValue.count >= 4 {
                    Task {
                        try await fetchAllCities()
                    }
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
