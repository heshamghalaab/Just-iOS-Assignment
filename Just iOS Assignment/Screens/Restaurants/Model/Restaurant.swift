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
    let sortingValues: [String: Double]
    
    enum Status: String, Codable, CaseIterable{
        case open
        case orderAhead = "order ahead"
        case closed
        case unknown
        
        init(from decoder: Decoder) throws {
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
        lhs.sortingValues == rhs.sortingValues
    }
}
