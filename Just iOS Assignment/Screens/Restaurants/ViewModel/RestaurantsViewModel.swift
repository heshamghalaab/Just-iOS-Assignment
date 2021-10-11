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
}

protocol RestaurantsViewModelOutputs {
    var restaurants: [Restaurant] { get }
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
    
    init(restaurantsProvider: RestaurantsProviding = RestaurantsProvider()){
        self.restaurantsProvider = restaurantsProvider
    }
    
    // inputs
    func loadRestaurants() {
    }
    
    func filterContentForSearchText(_ searchText: String) {
    }
    
    // Outputs
    var restaurants: [Restaurant] = []
}

