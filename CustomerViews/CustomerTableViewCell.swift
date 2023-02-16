//
//  CustomerTableViewCell.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/4/23.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {

    static let identifier = "CustomerTableViewCell"
    
    var data: CustomerDetails? {
        didSet {
            setValue()
        }
    }
    
    let customerNameLabel: UILabel = {
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
        
        stackView.addArrangedSubview(customerNameLabel)

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
        self.customerNameLabel.text = data.CustomerName
    }

}
