//
//  WeatherDataModel.swift
//  DemoProject
//
//  Created by Newmac on 28/06/23.
//

import Foundation

// MARK: - WeatherDataModel
struct WeatherDataModel: Codable {
    let current: Current?
}

// MARK: - Current
struct Current: Codable {
    let tempC, tempF: Double?
    let windKph: Double?
    let humidity: Int?
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case windKph = "wind_kph"
        case humidity
        case condition
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
}
enum Text: String, Codable {
    
    case lightRainShower = "Light rain shower"
    case moderateRain = "Moderate rain"
    case partlyCloudy = "Partly Cloudy "
    case patchyLightDrizzle = "Patchy light drizzle"
    case patchyRainNearby = "Patchy rain nearby"
}

