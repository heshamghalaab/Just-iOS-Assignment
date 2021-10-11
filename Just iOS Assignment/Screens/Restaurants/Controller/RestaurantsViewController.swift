//
//  RestaurantsViewController.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 11/10/2021.
//

import UIKit

class RestaurantsViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var restaurantsTableView: UITableView!
    
    // MARK: Properties
    
    var viewModel: RestaurantsViewModelProtocol = RestaurantsViewModel()
    var restaurantsDataSource: RestaurantsDataSource!
    
    // MARK: - View controller lifecycle methods
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        restaurantsTableViewConfigurations()
        viewModel.inputs.loadRestaurants()
    }
    
    private func restaurantsTableViewConfigurations(){
        restaurantsDataSource = RestaurantsDataSource(viewModel: self.viewModel)
        restaurantsTableView.dataSource = restaurantsDataSource
        let nib = UINib(nibName: RestaurantTableViewCell.identifier, bundle: nil)
        restaurantsTableView.register(nib, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
    }
    
    private func bindViewModel(){
        viewModel.outputs.reloadRestaurantsData = { [weak self] in
            guard let self = self else { return }
            self.restaurantsTableView.reloadData()
        }
    }
}
