//
//  City.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/14/24.
//

import Foundation

struct City : Codable, Hashable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    //default fallback
    static let defaultCity = City(name: "FAIL", lat: 0.00, lon: 0.00, country: "FAIL", state: nil)
}
