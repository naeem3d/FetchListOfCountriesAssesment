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
    
    private var apiService = ApiServices()
    
    init(apiService: APIServiceProtocol = ApiServices()) {
           self.apiServiceProt = apiService
       }
    
 
    func fetchSchools() {
        Task {
            do {
               let fetchCountries = try await apiService.fetchCountries() 
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
