//
//  RestaurantTableViewCell.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 11/10/2021.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var statusViewFlag: UIView!
    @IBOutlet weak var sortingValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with restaurantCellViewModel: RestaurantCellViewModelProtocol){
        restaurantNameLabel.text = restaurantCellViewModel.restaurantName
        sortingValueLabel.text = "Sorting Value."
        
        switch restaurantCellViewModel.status{
        case .open: statusViewFlag.backgroundColor = .green
        case .orderAhead: statusViewFlag.backgroundColor = .blue
        case .closed: statusViewFlag.backgroundColor = .red
        case .unknown: statusViewFlag.backgroundColor = .black
        }
    }
}
