//
//  RestaurantsViewModelTests.swift
//  Just iOS AssignmentTests
//
//  Created by Ghalaab on 12/10/2021.
//

import XCTest

@testable import Just_iOS_Assignment

class RestaurantsViewModelTests: XCTestCase {
    
    func testRestaurantsCount_whenTheJsonFileHasRestaurantsData() {
        let provider: RestaurantsProviding = RestaurantsProvider(
            resourceName: "testRestaurants",
            bundle: Bundle(for: DataDecoderTests.self))
        let viewModel: RestaurantsViewModelProtocol = RestaurantsViewModel(
            restaurantsProvider: provider)
        viewModel.inputs.loadRestaurants()
        
        XCTAssertTrue(viewModel.outputs.numberOfRestaurants == 3)
    }
    
    
    func testRestaurantsCount_whenTheJsonFileIsEmpty() {
        let provider: RestaurantsProviding = RestaurantsProvider(
            resourceName: "emptyRestaurants",
            bundle: Bundle(for: DataDecoderTests.self))
        let viewModel: RestaurantsViewModelProtocol = RestaurantsViewModel(
            restaurantsProvider: provider)
        viewModel.inputs.loadRestaurants()
        
        XCTAssertTrue(viewModel.outputs.numberOfRestaurants == 0)
    }
    
    func testFilteringRestaurants_whenPerfixMatching(){
        let provider: RestaurantsProviding = RestaurantsProvider(
            resourceName: "testRestaurants",
            bundle: Bundle(for: DataDecoderTests.self))
        let viewModel: RestaurantsViewModelProtocol = RestaurantsViewModel(
            restaurantsProvider: provider)
        viewModel.inputs.loadRestaurants()
        
        XCTAssertTrue(viewModel.outputs.numberOfRestaurants == 3)
        viewModel.inputs.filterContentForSearchText("T")
        XCTAssertTrue(viewModel.outputs.numberOfRestaurants == 2)
        viewModel.inputs.filterContentForSearchText("Tand")
        XCTAssertTrue(viewModel.outputs.numberOfRestaurants == 1)
    }
    
    func testFilteringRestaurants_whenPerfixDidnotMatch(){
        let provider: RestaurantsProviding = RestaurantsProvider(
            resourceName: "testRestaurants",
            bundle: Bundle(for: DataDecoderTests.self))
        let viewModel: RestaurantsViewModelProtocol = RestaurantsViewModel(
            restaurantsProvider: provider)
        viewModel.inputs.loadRestaurants()
        
        XCTAssertTrue(viewModel.outputs.numberOfRestaurants == 3)
        viewModel.inputs.filterContentForSearchText("TestName")
        XCTAssertTrue(viewModel.outputs.numberOfRestaurants == 0)
    }
    
    func testSorting_whenSelectingSortOption(){
        let provider: RestaurantsProviding = RestaurantsProvider(
            resourceName: "testRestaurants",
            bundle: Bundle(for: DataDecoderTests.self))
        let viewModel: RestaurantsViewModelProtocol = RestaurantsViewModel(
            restaurantsProvider: provider)
        viewModel.inputs.loadRestaurants()
        XCTAssertTrue(viewModel.outputs.numberOfRestaurants == 3)
        
        let cellViewModel = viewModel.inputs.restaurantCellViewModel(
            atIndexPath: IndexPath(row: 0, section: 0))
        viewModel.inputs.didSelect(sortingOption: .newest)
        XCTAssertEqual(cellViewModel.status == .open, true)
    }
}
