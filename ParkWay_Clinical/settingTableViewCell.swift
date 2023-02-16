//
//  settingTableViewCell.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 1/30/23.
//

import UIKit

class settingTableViewCell: UITableViewCell {
    
    static let identifier = "settingTableViewCell"
    
    var data: TableData? {
        didSet {
            setValue()
        }
    }
    
    let optionLabel: UILabel = {
        var option = UILabel()
        option.textColor = .black
        return option
    }()
    
//    let driverLabel: UILabel = {
//        var driver = UILabel()
//        driver.text = "Driver"
//        driver.backgroundColor = .white
//        driver.textColor = .black
//        return driver
//    }()
//
//    let customerLabel: UILabel = {
//        var customer = UILabel()
//        customer.text = "Customer"
//        customer.backgroundColor = .white
//        customer.textColor = .black
//        return customer
//    }()
//
//    let vehiclesLabel: UILabel = {
//        var vehicles = UILabel()
//        vehicles.text = "Vehicles"
//        vehicles.backgroundColor = .white
//        vehicles.textColor = .black
//        return vehicles
//    }()
//
//    let routesLabel: UILabel = {
//        var routes = UILabel()
//        routes.text = "Routes"
//        routes.backgroundColor = .white
//        routes.textColor = .black
//        return routes
//    }()
//
    let stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackView.addArrangedSubview(optionLabel)
//        stackView.addArrangedSubview(driverLabel)
//        stackView.addArrangedSubview(customerLabel)
//        stackView.addArrangedSubview(vehiclesLabel)
//        stackView.addArrangedSubview(routesLabel)
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setValue(){
        guard let data = data else {
            return
        }
        self.optionLabel.text = data.name
    }
}
