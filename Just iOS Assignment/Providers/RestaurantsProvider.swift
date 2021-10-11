//
//  RestaurantsProvider.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 11/10/2021.
//

import Foundation
import os.log

fileprivate struct RestaurantResponse: Codable, Equatable {
    let restaurants: [Restaurant]
}

protocol RestaurantsProviding {
    func restaurants() -> [Restaurant]
}

struct RestaurantsProvider: RestaurantsProviding {

    private let dataDecoder: DataDecoding
    private let resourceName: String
    private let bundle: Bundle

    init(dataDecoder: DataDecoding = DataDecoder(),
         resourceName: String = "restaurants",
         bundle: Bundle = Bundle.main) {
        self.dataDecoder = dataDecoder
        self.resourceName = resourceName
        self.bundle = bundle
    }

    func restaurants() -> [Restaurant] {
        guard let path = bundle.path(forResource: resourceName, ofType: "json") else {
            os_log("Failed to locate the json file", log: .modelsLogger, type: .error)
            return []
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let response: RestaurantResponse = try dataDecoder.decodeModel(from: data)
            return response.restaurants
            
        } catch{
            logDecoding(error: error)
            return []
        }
    }
    
    private func logDecoding(error: Error){
        switch error{
        case let DecodingError.dataCorrupted(context):
            os_log("############# DECODING_ERROR data Corrupted #############", log: .modelsLogger, type: .error)
            os_log("context '%@'", log: .modelsLogger, type: .error, context.debugDescription)
        case let DecodingError.keyNotFound(key, context):
            os_log("############# DECODING_ERROR Key Not found #############", log: .modelsLogger, type: .error)
            os_log("Key '%@' \ncontext: %@ \ncodingPath: %@", log: .modelsLogger, type: .error, "\(key)", context.debugDescription, context.codingPath)
        case let DecodingError.valueNotFound(value, context):
            os_log("############# DECODING_ERROR Value Not found #############", log: .modelsLogger, type: .error)
            os_log("Value '%@' \ncontext: %@ \ncodingPath: %@", log: .modelsLogger, type: .error, "\(value)", context.debugDescription, context.codingPath)
        case let DecodingError.typeMismatch(type, context):
            os_log("############# DECODING_ERROR Type mismatch #############", log: .modelsLogger, type: .error)
            os_log("Type '%@' \nmismatch: %@ \ncodingPath: %@", log: .modelsLogger, type: .error, "\(type)", context.debugDescription, context.codingPath)
        default:
            os_log("############# DECODING_ERROR Error #############", log: .modelsLogger, type: .error)
            os_log("UnExpected Error '%@'", log: .modelsLogger, type: .error, error.localizedDescription)
        }
    }
}

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
