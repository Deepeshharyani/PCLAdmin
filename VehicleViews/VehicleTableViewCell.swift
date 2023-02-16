//
//  VehicleTableViewCell.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/5/23.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    static let identifier = "VehicleTableViewCell"
    
    var data: VehicleDetails? {
        didSet {
            setValue()
        }
    }
    
    let vehicleNameLabel: UILabel = {
        var vehicle = UILabel()
        vehicle.textColor = .black
        return vehicle
    }()

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
        
        stackView.addArrangedSubview(vehicleNameLabel)

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
    
    func setValue(){
        guard let data = data else {
            return
        }
        self.vehicleNameLabel.text = data.PlateNumber
    }

}
