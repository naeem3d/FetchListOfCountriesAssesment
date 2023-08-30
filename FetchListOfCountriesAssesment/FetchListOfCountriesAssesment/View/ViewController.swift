//
//  ViewController.swift
//  FetchListOfCountriesAssesment
//
//  Created by naeem alabboodi on 8/29/23.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    
    
    var searchController: UISearchController!
    var filteredCountries: [CountriesListElement]?
    
    
    let vm =  CountriesListViewModel()
    let CountriesArray = [
        "Iraq","USA","Japan","North Koria","China"
    ]
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CountryTableViewCell.nib(), forCellReuseIdentifier: CountryTableViewCell.identitier)
        
        self.title = "Countries List"
        
        tableView.dataSource = self
        tableView.delegate = self
        vm.fetchContriesList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdated), name: Notification.Name("dataUpdated"), object: nil)
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Countries or Capitals"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
    }
    
    @objc func dataUpdated() {
        tableView.reloadData()
    }
    func filterContentForSearchText(_ searchText: String) {
        filteredCountries = vm.countriesListElementArray?.filter { (country: CountriesListElement) -> Bool in
            return country.name.lowercased().contains(searchText.lowercased()) || country.capital.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        // or whatever height you desire
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row ")
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCountries?.count ?? 0
        }
        return vm.countriesListElementArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        let country: CountriesListElement?
        if isFiltering {
            country = filteredCountries?[indexPath.row]
        } else {
            country = vm.countriesListElementArray?[indexPath.row]
        }
        cell.countryName.text = country?.name
        cell.region.text = country?.region.rawValue
        cell.code.text = country?.code
        cell.capital.text = country?.capital
        return cell
    }
    var isFiltering: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
}

