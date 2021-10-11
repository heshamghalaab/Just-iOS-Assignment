//
//  SortingOption.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 12/10/2021.
//

import Foundation

enum SortingOption: CaseIterable{
    case bestMatch
    case newest
    case ratingAverage
    case distance
    case popularity
    case averageProductPrice
    case deliveryCost
    case minimumCost
    
    var title: String{
        switch self{
        case .bestMatch: return "Best Match"
        case .newest: return "Newest"
        case .ratingAverage: return "Rating Average"
        case .distance: return "Distance"
        case .popularity: return "Popularity"
        case .averageProductPrice: return "Average Produc Price"
        case .deliveryCost: return "Delivery Cost"
        case .minimumCost: return "Minimum Cost"
        }
    }
}
