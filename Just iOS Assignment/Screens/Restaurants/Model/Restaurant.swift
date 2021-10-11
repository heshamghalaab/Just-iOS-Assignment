//
//  Restaurant.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 11/10/2021.
//

import Foundation

struct Restaurant: Codable, Equatable {
    let id: String
    let name: String
    let status: Status
    let sortingValues: SortingValues
    
    enum Status: String, Codable{
        case open
        case orderAhead = "order ahead"
        case closed
        case unknown
        
        public init(from decoder: Decoder) throws {
            self = try Status(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }
    }
    
    struct SortingValues: Codable{
        let bestMatch: Double
        let newest: Double
        let ratingAverage: Double
        let distance: Double
        let popularity: Double
        let averageProductPrice: Double
        let deliveryCosts: Double
        let minCost: Double
    }
    
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.status == rhs.status &&
        lhs.sortingValues.bestMatch == rhs.sortingValues.bestMatch &&
        lhs.sortingValues.newest == rhs.sortingValues.newest &&
        lhs.sortingValues.ratingAverage == rhs.sortingValues.ratingAverage &&
        lhs.sortingValues.distance == rhs.sortingValues.distance &&
        lhs.sortingValues.popularity == rhs.sortingValues.popularity &&
        lhs.sortingValues.averageProductPrice == rhs.sortingValues.averageProductPrice &&
        lhs.sortingValues.deliveryCosts == rhs.sortingValues.deliveryCosts &&
        lhs.sortingValues.minCost == rhs.sortingValues.minCost
    }
}
