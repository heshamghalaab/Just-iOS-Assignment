//
//  BucketSort.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 12/10/2021.
//

import Foundation

struct BucketSort{
    
    func performSorting(
        _ elements: [Restaurant], distributor: Distributor,
        sorter: Sorter, buckets: [Restaurant.Status : Bucket])
    -> [Restaurant] {
        
        var bucketsCopy = buckets
        for elem in elements {
            distributor.distribute(elem, buckets: &bucketsCopy)
        }
        
        var results = [Restaurant]()        
        var allStatus = Restaurant.Status.allCases
        allStatus.removeLast() // removing unknown case
        
        for status in allStatus{
            results += bucketsCopy[status]?.sort(sorter) ?? []
        }
        return results
    }
}
