//
//  ContentView.swift
//  ListContries
//
//  Created by naeem alabboodi on 8/29/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = CountriesListViewModel()
    
    @State private var searchText: String = ""
    
    // Filtered list based on the search text
    var filteredCountries: [CountriesListElement] {
        vm.countriesListElementArray.filter { country in
            searchText.isEmpty ||
            country.name.lowercased().contains(searchText.lowercased()) ||
            country.capital.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCountries) { item in
                    VStack {
                        HStack {
                            Text(" \(item.name)")
                                .font(.system(size: 20))
                                .foregroundStyle(Color.purple)
                                .bold()
                            Spacer()
                            Text("  \(item.region.rawValue)")
                            Text("  \(item.code)")
                        }
                        Text(" \(item.capital)")
                    }
                    
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.blue)
                            .opacity(0.1)
                    )
                }
            }
            .searchable(text: $searchText)
            .task {
                await vm.fetchContriesList()
            }
            .navigationTitle("Country List")
        }
    }
}

#Preview {
    ContentView()
}
