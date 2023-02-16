//
//  RouteClientDetailsViewControllerTableViewCell.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/14/23.
//

import UIKit

class RouteClientDetailsViewControllerTableViewCell: UITableViewCell {
    
    static let identifier = "RouteClientDetailsViewControllerTableViewCell"
    var data: CustomerResponse? {
        didSet {
            setValue()
        }
    }
    
    var driverData: RouteResponse? {
        didSet {
            setValue()
        }
    }

    let CustomerName : UILabel = {
        var customerName = UILabel()
        customerName.textAlignment = .center
        return customerName
    }()
    
    let customerStreetLabel : UILabel = {
        var street = UILabel()
        street.textAlignment = .center
        return street
    }()
    
    let customerStackView: UIStackView = {
        var customerStack = UIStackView()
        customerStack.axis = .vertical
        customerStack.alignment = .fill
        customerStack.distribution = .fillEqually
        customerStack.spacing = 3
        return customerStack
    }()
    let specimenLabel : UILabel = {
        var specimen = UILabel()
        specimen.textAlignment = .center
        specimen.lineBreakMode = .byWordWrapping
        specimen.numberOfLines = 0
        return specimen
    }()
    let pickupAtLabel : UILabel = {
        var pickUp = UILabel()
        pickUp.textAlignment = .center
        return pickUp
    }()
    let collectedLabel : UILabel = {
        var collected = UILabel()
        collected.textAlignment = .center
        return collected
    }()
    let customerIdLabel : UILabel = {
        var customerId = UILabel()
        customerId.textAlignment = .center
        return customerId
    }()
//    let remainingStackView: UIStackView = {
//        var remainingStack = UIStackView()
//        remainingStack.axis = .horizontal
//        remainingStack.alignment = .fill
//        remainingStack.distribution = .fillEqually
//        remainingStack.spacing = 3
//        return remainingStack
//    }()
    let mainStackView: UIStackView = {
        var mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .fill
        mainStack.distribution = .fillEqually
        mainStack.spacing = 3
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customerStackView.addArrangedSubview(CustomerName)
        customerStackView.addArrangedSubview(customerStreetLabel)
        mainStackView.addArrangedSubview(customerStackView)
        mainStackView.addArrangedSubview(specimenLabel)
        mainStackView.addArrangedSubview(pickupAtLabel)
        mainStackView.addArrangedSubview(collectedLabel)
        mainStackView.addArrangedSubview(customerIdLabel)
      //  mainStackView.addArrangedSubview(remainingStackView)
        self.addSubview(mainStackView)
        
        
        NSLayoutConstraint.activate(
            [mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
             mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
             mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setValue(){
       guard let data = data else {
           return
       }
        self.CustomerName.text = data.CustomerName
        self.customerStreetLabel.text = data.StreetAddress
        self.specimenLabel.text = "Specimen  Collected: \(String(describing: data.SpecimensCollected))"
        self.pickupAtLabel.text = data.PickUpTime
        self.collectedLabel.text = data.CollectionStatus
        self.customerIdLabel.text = String(describing: data.CustomerId)
   }
}
