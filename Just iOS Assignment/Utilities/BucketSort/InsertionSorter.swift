//
//  InsertionSorter.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 12/10/2021.
//

import Foundation

protocol Sorter {
    func sort(_ items: [Restaurant]) -> [Restaurant]
}

struct InsertionSorter: Sorter {
    
    let sortOption: SortingOption
    
    init(sortOption: SortingOption){
        self.sortOption = sortOption
    }
    
    func sort(_ items: [Restaurant]) -> [Restaurant] {
        var results = items
        for i in 0 ..< results.count {
            var j = i
            while j > 0 && results[j-1].sortingValues[sortOption.key] ?? 0 <
                    results[j].sortingValues[sortOption.key] ?? 0 {
                
                let auxiliar = results[j-1]
                results[j-1] = results[j]
                results[j] = auxiliar
                
                j -= 1
            }
        }
        return results
    }
}
