//
//  RestaurantCellViewModel.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 11/10/2021.
//

import UIKit

protocol RestaurantCellViewModelProtocol: AnyObject {
    var restaurantName: String { get }
    var status: Restaurant.Status { get }
    var sortingTitle: String { get }
    var sortingValue: String { get }
}

class RestaurantCellViewModel: RestaurantCellViewModelProtocol {
    
    private let restaurant: Restaurant
    private let sortingOption: SortingOption
    
    init(restaurant: Restaurant, sortingOption: SortingOption) {
        self.restaurant = restaurant
        self.sortingOption = sortingOption
    }
    
    var restaurantName: String { restaurant.name }
    var status: Restaurant.Status { restaurant.status }
    var sortingValue: String { restaurant.sortingValues[sortingOption.key]?.description ?? "" }
    var sortingTitle: String { sortingOption.title + ":"}
}
