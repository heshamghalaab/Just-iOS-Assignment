//
//  BucketSortTests.swift
//  Just iOS AssignmentTests
//
//  Created by Ghalaab on 12/10/2021.
//

import XCTest
@testable import Just_iOS_Assignment

class BucketSortTests: XCTestCase {

    func test_CreationOfBucketSort(){
        let buckets: [Restaurant.Status : Bucket] = [ : ]

        let restaurants = BucketSort().performSorting(
            [], distributor: StatusDistributor(),
            sorter: InsertionSorter(sortOption: .newest),
            buckets: buckets)
        XCTAssertEqual(restaurants.count, 0)
    }
    let SORT_KEY = "newest"
    
    func testBucketSort_WhenallRestaurantsBelongingToOneBucket(){
        let buckets: [Restaurant.Status : Bucket] = [.open: Bucket() , .closed: Bucket()]
        
        let demoRestaurants: [Restaurant] = [
            Restaurant(id: "3", name: "", status: .open, sortingValues: [SORT_KEY: 4]),
            Restaurant(id: "0", name: "", status: .open, sortingValues: [SORT_KEY: 1]),
            Restaurant(id: "2", name: "", status: .open, sortingValues: [SORT_KEY: 3]),
            Restaurant(id: "1", name: "", status: .open, sortingValues: [SORT_KEY: 2]),
            Restaurant(id: "4", name: "", status: .open, sortingValues: [SORT_KEY: 5])
        ]
        
        let restaurants = BucketSort().performSorting(
            demoRestaurants, distributor: StatusDistributor(),
            sorter: InsertionSorter(sortOption: .newest),
            buckets: buckets)
        XCTAssertEqual(restaurants.count, 5)
        
        let restaurantsNewestValues = restaurants.compactMap({ $0.sortingValues[SORT_KEY] })
        XCTAssertEqual(restaurantsNewestValues.isDescending(), true)
        
        let restaurantsNewestClosedValues = restaurants.filter ({ $0.status == .closed}).compactMap({ $0.sortingValues["newest"] })
        XCTAssertEqual(restaurantsNewestClosedValues.count, 0)
    }
    
    func testBucketSort_WhenallRestaurantsBelongingToDifferentBuckets(){
        let buckets: [Restaurant.Status : Bucket] = [.open: Bucket() , .closed: Bucket()]
        
        let demoRestaurants: [Restaurant] = [
            Restaurant(id: "3", name: "", status: .open, sortingValues: [SORT_KEY: 4]),
            Restaurant(id: "0", name: "", status: .closed, sortingValues: [SORT_KEY: 1]),
            Restaurant(id: "2", name: "", status: .open, sortingValues: [SORT_KEY: 3]),
            Restaurant(id: "1", name: "", status: .closed, sortingValues: [SORT_KEY: 2]),
            Restaurant(id: "4", name: "", status: .open, sortingValues: [SORT_KEY: 5])
        ]
        
        let restaurants = BucketSort().performSorting(
            demoRestaurants, distributor: StatusDistributor(),
            sorter: InsertionSorter(sortOption: .newest),
            buckets: buckets)
        XCTAssertEqual(restaurants.count, 5)
        
        let restaurantsNewestOpenValues = restaurants
            .filter({ $0.status == .open})
            .compactMap({ $0.sortingValues[SORT_KEY] })
        let restaurantsNewestClosedValues = restaurants
            .filter({ $0.status == .closed})
            .compactMap({ $0.sortingValues[SORT_KEY] })
        
        XCTAssertEqual(restaurantsNewestOpenValues.isDescending(), true)
        XCTAssertEqual(restaurantsNewestClosedValues.isDescending(), true)
    }
    
    func test_AllRestaurantsPerformance() {
        
        let restaurants = RestaurantsProvider().restaurants()
        XCTAssertTrue(!restaurants.isEmpty)
        
        let buckets: [Restaurant.Status : Bucket] = [.open: Bucket(), .orderAhead :Bucket(), .closed: Bucket()]
        let bucketSort = BucketSort()
        
        self.measure {
            let sortedRestaurants = bucketSort.performSorting(
                restaurants, distributor: StatusDistributor(),
                sorter: InsertionSorter(sortOption: .newest),
                buckets: buckets)
            XCTAssertEqual(sortedRestaurants.count, restaurants.count)
        }
    }

}

extension Array where Element: Comparable {
    func isDescending() -> Bool {
        return zip(self, self.dropFirst()).allSatisfy(>=)
    }
}
