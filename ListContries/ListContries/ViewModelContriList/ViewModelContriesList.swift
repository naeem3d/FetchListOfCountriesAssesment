//
//  ViewModelContriesList.swift
//  ListContries
//
//  Created by naeem alabboodi on 8/29/23.
//

import Foundation
class CountriesListViewModel: ObservableObject {
    @Published var countriesListElementArray: [CountriesListElement] = []
    
    private var apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = ApiServices()) {
        self.apiService = apiService
    }
    
    func fetchContriesList() async {
        do {
            let countries = try await apiService.fetchCountries()
            DispatchQueue.main.async {
                self.countriesListElementArray = countries
            }
        } catch {
            print("Error fetching countries: \(error.localizedDescription)")
        }
    }
}
