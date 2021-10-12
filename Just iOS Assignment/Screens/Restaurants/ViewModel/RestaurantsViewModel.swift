//
//  RestaurantsViewModel.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 11/10/2021.
//

import Foundation

protocol RestaurantsViewModelInputs {
    func loadRestaurants()
    func filterContentForSearchText(_ searchText: String)
    func restaurantCellViewModel(atIndexPath indexPath: IndexPath) -> RestaurantCellViewModelProtocol
    func didSelect(sortingOption: SortingOption)
}

protocol RestaurantsViewModelOutputs {
    var numberOfRestaurants: Int { get }
    var reloadRestaurantsData: ( () -> Void )? { get set }
}

protocol RestaurantsViewModelProtocol {
    var inputs: RestaurantsViewModelInputs { get }
    var outputs: RestaurantsViewModelOutputs { get set }
}

class RestaurantsViewModel: RestaurantsViewModelOutputs, RestaurantsViewModelInputs, RestaurantsViewModelProtocol {
    
    var inputs: RestaurantsViewModelInputs { self }
    var outputs: RestaurantsViewModelOutputs {
        get { self }
        set {      }
    }
    
    private let restaurantsProvider: RestaurantsProviding
    private var restaurants: [Restaurant] = []
    private var sortingOption: SortingOption = .newest
    
    init(restaurantsProvider: RestaurantsProviding = RestaurantsProvider()){
        self.restaurantsProvider = restaurantsProvider
    }
    
    // inputs
    func loadRestaurants() {
        self.restaurants = self.restaurantsProvider.restaurants()
        self.reloadRestaurantsData?()
    }
    
    func filterContentForSearchText(_ searchText: String) {
    }
    
    func restaurantCellViewModel(atIndexPath indexPath: IndexPath) -> RestaurantCellViewModelProtocol{
        RestaurantCellViewModel(restaurant: restaurants[indexPath.row], sortingOption: self.sortingOption)
    }
    
    func didSelect(sortingOption: SortingOption){
        self.sortingOption = sortingOption
    }
      
    // Outputs
    var numberOfRestaurants: Int { restaurants.count }
    var reloadRestaurantsData: ( () -> Void )?
}

