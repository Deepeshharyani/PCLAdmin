//
//  DriverTableViewCell.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/2/23.
//

import UIKit

class DriverTableViewCell: UITableViewCell {

    static let identifier = "DriverTableViewCell"
    
    var data: DriverDetails? {
        didSet {
            setValue()
        }
    }
    
    let driverNameLabel: UILabel = {
        var option = UILabel()
        option.textColor = .black
        return option
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
        
        stackView.addArrangedSubview(driverNameLabel)

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
        self.driverNameLabel.text = data.DriverName
    }
}
