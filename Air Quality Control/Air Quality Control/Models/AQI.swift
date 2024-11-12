//
//  AQI.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/11/24.
//

import Foundation


struct AQIResponse : Codable {
    let list: [AQIList]
    let coord: [Double]
    let location: String?
}

struct AQIList : Codable {
    let dt: Int
    let main: AQIMain
    let components: AQIComponents
}

struct AQIMain : Codable {
    let aqi: Int
}

struct AQIComponents : Codable {
    let co: Float
    let no: Float
    let no2: Float
    let o3: Float
    let so2: Float
    let pm2_5: Float
    let pm10: Float
    let nh3: Float
}
