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
}
