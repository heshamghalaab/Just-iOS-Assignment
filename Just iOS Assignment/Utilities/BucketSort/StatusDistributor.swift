//
//  StatusDistributor.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 12/10/2021.
//

import Foundation

protocol Distributor {
    func distribute(_ element: Restaurant, buckets: inout [Restaurant.Status: Bucket])
}

struct StatusDistributor: Distributor {
    func distribute(_ element: Restaurant, buckets: inout [Restaurant.Status: Bucket]) {
        buckets[element.status]?.add(element)
    }
}
