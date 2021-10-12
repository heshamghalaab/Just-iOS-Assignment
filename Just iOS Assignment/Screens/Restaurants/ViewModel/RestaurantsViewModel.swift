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
    var searchKeyIsBackSpace: Bool { get set }
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
    private var allRestaurants: [Restaurant] = []
    private var sortingOption: SortingOption = .newest
    
    init(restaurantsProvider: RestaurantsProviding = RestaurantsProvider()){
        self.restaurantsProvider = restaurantsProvider
    }
    
    // MARK: Inputs
    
    func loadRestaurants() {
        self.restaurants = self.restaurantsProvider.restaurants()
        self.performSorting()
        self.allRestaurants = self.restaurants
        self.reloadRestaurantsData?()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty{
            self.restaurants = allRestaurants
            self.performSorting()
        }else{
            // check if backspace is clicked or not , because if it is not so we don't need
            // to filter the whole restaurants we just need to filter the filtered restaurants.
            self.restaurants = (searchKeyIsBackSpace ? allRestaurants : restaurants).filter({
                $0.name.lowercased().hasPrefix(searchText.lowercased())
            })
            self.reloadRestaurantsData?()
        }
    }
    
    func restaurantCellViewModel(atIndexPath indexPath: IndexPath) -> RestaurantCellViewModelProtocol{
        RestaurantCellViewModel(restaurant: restaurants[indexPath.row], sortingOption: self.sortingOption)
    }
    
    func didSelect(sortingOption: SortingOption){
        self.sortingOption = sortingOption
        self.performSorting()
    }
    
    func performSorting(){
        let buckets: [Restaurant.Status : Bucket] = [
            .open: Bucket(), .orderAhead: Bucket(), .closed: Bucket()
        ]

        self.restaurants = BucketSort().performSorting(
            restaurants, distributor: StatusDistributor(),
            sorter: InsertionSorter(sortOption: sortingOption),
            buckets: buckets)
        self.reloadRestaurantsData?()
    }
    
    // MARK: Outputs
    var numberOfRestaurants: Int { restaurants.count }
    var reloadRestaurantsData: ( () -> Void )?
    var searchKeyIsBackSpace: Bool = false
}
