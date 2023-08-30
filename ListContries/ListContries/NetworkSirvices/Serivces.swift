//
//  Serivces.swift
//  ListContries
//
//  Created by naeem alabboodi on 8/29/23.
//

import Foundation


enum APIServiceError: Error {
    case invalidURL
    case decodingError
    case unknownError
}

protocol APIServiceProtocol {
    func fetchCountries() async throws -> [CountriesListElement]
}

class ApiServices: APIServiceProtocol {
    
    let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
    
    func fetchCountries() async throws -> [CountriesListElement] {
        guard let url = URL(string: urlString) else { throw APIServiceError.invalidURL }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let contriesList = try JSONDecoder().decode([CountriesListElement].self, from: data)
            
            return contriesList
        } catch _ as DecodingError {
            throw APIServiceError.decodingError
        } catch {
            throw APIServiceError.unknownError
        }
    }
}
