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
    private var restaurantsDataSource: RestaurantsDataSource!
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View controller lifecycle methods
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        restaurantsTableViewConfigurations()
        searchControllerConfigurations()
        viewModel.inputs.loadRestaurants()
    }
    
    // Configure restaurants table view
    private func restaurantsTableViewConfigurations(){
        restaurantsDataSource = RestaurantsDataSource(viewModel: self.viewModel)
        restaurantsTableView.dataSource = restaurantsDataSource
        let nib = UINib(nibName: RestaurantTableViewCell.identifier, bundle: nil)
        restaurantsTableView.register(nib, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
    }
    
    // Configure search controller.
    private func searchControllerConfigurations(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Restaurants"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    private func bindViewModel(){
        viewModel.outputs.reloadRestaurantsData = { [weak self] in
            guard let self = self else { return }
            self.restaurantsTableView.reloadData()
        }
    }
    
    // MARK: - @IBAction Methods
    
    @IBAction func onTapSelectSortingOption(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "Sorting Options",
            message: "Please select an Option",
            preferredStyle: .actionSheet)
        
        SortingOption.allCases.forEach { option in
            alert.addAction(UIAlertAction(title: option.title, style: .default, handler: { _ in
                self.viewModel.inputs.didSelect(sortingOption: option)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension RestaurantsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputs.filterContentForSearchText(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputs.filterContentForSearchText("")
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        viewModel.outputs.searchKeyIsBackSpace = text.isBackspace
        return true
    }
}
