//
//  RestaurantsDataSource.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 12/10/2021.
//

import UIKit

class RestaurantsDataSource: NSObject, UITableViewDataSource{
    
    let viewModel: RestaurantsViewModelProtocol
    
    init(viewModel: RestaurantsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.numberOfRestaurants
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell
        
        let cellViewModel = viewModel.inputs.restaurantCellViewModel(atIndexPath: indexPath)
        cell.configure(with: cellViewModel)
        return cell
    }
}

