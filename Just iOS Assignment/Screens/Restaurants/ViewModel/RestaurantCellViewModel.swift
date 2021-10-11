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
}

class RestaurantCellViewModel: RestaurantCellViewModelProtocol {
    
    private let restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    var restaurantName: String { restaurant.name }
    var status: Restaurant.Status { restaurant.status }
}
