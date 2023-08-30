//
//  Services.swift
//  FetchListOfCountriesAssesment
//
//  Created by naeem alabboodi on 8/29/23.
//

import Foundation

enum APIServiceError: Error {
    case Error400
    case Error401
    case Error404
    case Error429
    case Errors5xx
}
protocol APIServiceProtocol {
}

class APIServces: APIServiceProtocol {
    func fetchWeatherDataForCity(url: String)  async throws  -> [CountriesListElement] {
        guard let urllast = URL(string: url) else {throw APIServiceError.Error429}
        do {
            let (data, _) = try await URLSession.shared.data(from: urllast)
            let pittsbrughWeather = try JSONDecoder().decode([CountriesListElement].self, from: data)
            print(pittsbrughWeather)
            return pittsbrughWeather
        } catch {
            if error is DecodingError {
                throw APIServiceError.Error400
            } else {
                throw APIServiceError.Error401
            }
        }
    }
}
