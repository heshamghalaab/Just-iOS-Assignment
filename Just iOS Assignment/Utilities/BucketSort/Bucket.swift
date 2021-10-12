//
//  Bucket.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 12/10/2021.
//

import Foundation

struct Bucket {
    var elements: [Restaurant] = [Restaurant]()
    
    mutating func add(_ item: Restaurant) {
        elements.append(item)
    }

    func sort(_ algorithm: Sorter) -> [Restaurant] {
        return algorithm.sort(elements)
    }
}
