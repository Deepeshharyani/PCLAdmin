//
//  RouteTableViewCell.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/6/23.
//

import UIKit

class RouteTableViewCell: UITableViewCell {
    static let identifier = "RouteTableViewCell"
    
    var data: routeDetails? {
        didSet {
            setValue()
        }
    }
    
    let RouteIdLabel: UILabel = {
        var RouteId = UILabel()
        RouteId.text = "Route ID"
        RouteId.font = UIFont.boldSystemFont(ofSize: 16.0)
        RouteId.textColor = .black
        return RouteId
    }()
    
    let RouteIdTextField: UITextField = {
        var RouteIdText = UITextField()
        RouteIdText.textColor = .black
        return RouteIdText
    }()
    

    let routeIdstackView: UIStackView = {
        var routeIdstack = UIStackView()
        routeIdstack.axis = .vertical
        routeIdstack.alignment = .center
        routeIdstack.distribution = .fillEqually
        routeIdstack.spacing = 2
    //    stack.translatesAutoresizingMaskIntoConstraints = false
        return routeIdstack
    }()
    
    let RouteNameLabel: UILabel = {
        var Routename = UILabel()
        Routename.text = "Route Name"
        Routename.font = UIFont.boldSystemFont(ofSize: 16.0)
        Routename.textColor = .black
        return Routename
    }()
    
    let RouteNameTextField: UITextField = {
        var RouteNameText = UITextField()
        RouteNameText.textColor = .black
        return RouteNameText
    }()
    

    let RouteNamestackView: UIStackView = {
        var RouteNamestack = UIStackView()
        RouteNamestack.axis = .vertical
        RouteNamestack.alignment = .center
        RouteNamestack.distribution = .fillEqually
        RouteNamestack.spacing = 2
    //    stack.translatesAutoresizingMaskIntoConstraints = false
        return RouteNamestack
    }()
    
    let DriverNameLabel: UILabel = {
        var driverName = UILabel()
        driverName.text = "Driver Name"
        driverName.font = UIFont.boldSystemFont(ofSize: 16.0)
        driverName.textColor = .black
        return driverName
    }()
    
    let DriverNameTextField: UITextField = {
        var DriverNameText = UITextField()
        DriverNameText.textColor = .black
        return DriverNameText
    }()
    

    let DriverNamestackView: UIStackView = {
        var DriverNamestack = UIStackView()
        DriverNamestack.axis = .vertical
        DriverNamestack.alignment = .center
        DriverNamestack.distribution = .fillEqually
        DriverNamestack.spacing = 2
    //    stack.translatesAutoresizingMaskIntoConstraints = false
        return DriverNamestack
    }()
    
    var mainStackView: UIStackView = {
        var mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .fill
        mainStack.distribution = .fillEqually
        mainStack.spacing = 5
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        routeIdstackView.addArrangedSubview(RouteIdLabel)
        routeIdstackView.addArrangedSubview(RouteIdTextField)
        RouteNamestackView.addArrangedSubview(RouteNameLabel)
        RouteNamestackView.addArrangedSubview(RouteNameTextField)
        DriverNamestackView.addArrangedSubview(DriverNameLabel)
        DriverNamestackView.addArrangedSubview(DriverNameTextField)
        mainStackView.addArrangedSubview(routeIdstackView)
        mainStackView.addArrangedSubview(RouteNamestackView)
        mainStackView.addArrangedSubview(DriverNamestackView)
        self.addSubview(mainStackView)
            
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setValue(){
        guard let data = data else {
            return
        }
        self.RouteIdTextField.text = "\(data.Route.RouteNo)"
        self.RouteNameTextField.text  = data.Route.RouteName
        self.DriverNameTextField.text = data.Route.DriverName
    }
}
