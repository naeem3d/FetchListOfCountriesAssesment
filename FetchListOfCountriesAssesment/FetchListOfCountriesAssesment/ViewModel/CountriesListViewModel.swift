//
//  CountriesListViewModel.swift
//  FetchListOfCountriesAssesment
//
//  Created by naeem alabboodi on 8/29/23.
//

import Foundation

class CountriesListViewModel: ObservableObject {
  @Published   var countriesListElementArray: [CountriesListElement]?
    
    private var apiServiceProt: APIServiceProtocol
    
    private var apiService = APIServces()
    
    init(apiService: APIServiceProtocol = APIServces()) {
           self.apiServiceProt = apiService
       }
    
 
    func fetchSchools() {
        Task {
            do {
                let fetchCountries = try await apiService.fetchWeatherDataForCity(url: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json")
                DispatchQueue.main.async {
                    self.countriesListElementArray = fetchCountries
                    
                print(fetchCountries)
                    NotificationCenter.default.post(name: Notification.Name("dataUpdated"), object: nil)
                }
            } catch {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }

    }
    
    
}
