//
//  RestaurantTableViewCell.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 11/10/2021.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var sortingTitleLabel: UILabel!
    @IBOutlet weak var sortingValueLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with restaurantCellViewModel: RestaurantCellViewModelProtocol){
        restaurantNameLabel.text = restaurantCellViewModel.restaurantName
        sortingValueLabel.text = restaurantCellViewModel.sortingValue
        sortingTitleLabel.text = restaurantCellViewModel.sortingTitle
        statusLabel.text = restaurantCellViewModel.status.rawValue
        
        switch restaurantCellViewModel.status{
        case .open: statusLabel.backgroundColor = .greenColor
        case .orderAhead: statusLabel.backgroundColor = .blueColor
        case .closed: statusLabel.backgroundColor = .redColor
        case .unknown: statusLabel.backgroundColor = .black
        }
    }
}
