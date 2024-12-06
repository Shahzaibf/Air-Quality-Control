//
//  AQIFetcher.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/12/24.
//

import Foundation


let apiKey: String = "YOUR_API_KEY"

func fetchAQI(lat: Double, lon: Double) async throws -> AQIResponse {
    let endpoint = "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
    
    guard let url = URL(string: endpoint) else {
        throw APIError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw APIError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(AQIResponse.self, from: data)
    } catch {
        print("Decoding error: \(error)")
        throw APIError.invalidData
    }
}

func fetchCities(search: String) async throws -> [City] {
    let endpoint = "https://api.openweathermap.org/geo/1.0/direct?q=\(search)&limit=5&appid=\(apiKey)"
    
    guard let url = URL(string: endpoint) else {
        throw APIError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        print(response)
        throw APIError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([City].self, from: data)
    } catch {
        print("Decoding error: \(error)")
        throw APIError.invalidResponse
    }
}
