//
//  AddViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/6/23.
//

import UIKit
protocol AddViewControllerDelegate{
    func driverSelected(selectedDriver: DriverDetails)
    func vehicleSelected(selectedVehicle: VehicleDetails)
    func customerSelected(selectedCustomer: CustomerDetails)
}

class AddViewController: UIViewController {
    var data: routeDetails?
    var selectedVehicle: VehicleDetails?
    var selectedCustomer: [CustomerDetails] = []
    var selectedDriver: DriverDetails?
    var delegate: RouteViewControllerDelegate?
   // var driverData: [DriverDetails] = []
    
    // Selected
    // selected driverDetails
    // selected vehicle details
    // selected [customerdetails]
    
    
    let customerTableView: UITableView = {
        var customerTV = UITableView()
        customerTV.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        return customerTV
    }()
    
    
    let addRouteLabel: UILabel = {
        var addVehicle = UILabel()
        addVehicle.text = "Add Route"
        addVehicle.textAlignment = .center
        addVehicle.textColor = UIColor(named: "Maroon")
        return addVehicle
    }()
    
    let routeIdTextField: UITextField = {
        var routeId = UITextField()
        routeId.textAlignment = .center
        routeId.attributedPlaceholder = NSAttributedString(string: "Route Id", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Maroon")])
        routeId.borderStyle = UITextField.BorderStyle.roundedRect
        return routeId
    }()
    let routeNameTextField: UITextField = {
        var routeName = UITextField()
        routeName.textAlignment = .center
     
        routeName.attributedPlaceholder = NSAttributedString(string: "Route Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Maroon")])
        routeName.borderStyle = UITextField.BorderStyle.roundedRect
        return routeName
    }()
    
    let routeIdNameStackView: UIStackView = {
        var routeIdNameStack = UIStackView()
        routeIdNameStack.axis = .horizontal
        routeIdNameStack.distribution = .fillEqually
        routeIdNameStack.alignment = .fill
        routeIdNameStack.spacing = 5
        return routeIdNameStack
    }()
    
    let driverNameButton: UIButton = {
        var driverName = UIButton()
       
       // driverName.placeholder = "Enter Number Plate"
        driverName.setTitle("Driver Name", for: .normal)
        driverName.setTitleColor(UIColor(named: "Maroon"), for: .normal)
        driverName.layer.borderColor = UIColor(named: "Maroon")?.cgColor
       // driverName.borderStyle = UITextField.BorderStyle.roundedRect
        return driverName
    }()
    let vehicleNumberPlateButton: UIButton = {
        var vehicleNumber = UIButton()
       
       // driverName.placeholder = "Enter Number Plate"
        vehicleNumber.setTitle("Vehicle No.", for: .normal)
        vehicleNumber.setTitleColor(UIColor(named: "Maroon"), for: .normal)
        vehicleNumber.layer.borderColor = UIColor(named: "Maroon")?.cgColor
       // driverName.borderStyle = UITextField.BorderStyle.roundedRect
        return vehicleNumber
    }()
    
    let driverNameVehicleNoStackView: UIStackView = {
        var driverNameVehicleNoStack = UIStackView()
        driverNameVehicleNoStack.axis = .horizontal
        driverNameVehicleNoStack.distribution = .fillEqually
        driverNameVehicleNoStack.alignment = .fill
        driverNameVehicleNoStack.spacing = 5
        return driverNameVehicleNoStack
    }()
    
    let addButton: UIButton = {
        var add = UIButton()
        add.setTitle("Add", for: .normal)
        add.setTitleColor(.white, for: .normal)
        add.backgroundColor = UIColor(named: "Maroon")
        return add
    }()
    
    let cancelButton: UIButton = {
        var cancel = UIButton()
        cancel.setTitle("Cancel", for: .normal)
        cancel.setTitleColor(.white, for: .normal)
        cancel.backgroundColor = UIColor(named: "Maroon")
        return cancel
    }()
    var addCancelStackView: UIStackView = {
        var addCancelStack = UIStackView()
        addCancelStack.axis = .horizontal
        addCancelStack.alignment = .fill
        addCancelStack.distribution = .fillEqually
        addCancelStack.spacing = 5
     //   addCancelStack.translatesAutoresizingMaskIntoConstraints = false
        return addCancelStack
    }()
    
    var mainStackView: UIStackView = {
        var mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.spacing = 30
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customerTableView.delegate = self
        customerTableView.dataSource = self
        
        customerTableView.register(SelectTableViewCell.self, forCellReuseIdentifier: SelectTableViewCell.identifier)
        
        mainStackView.addArrangedSubview(addRouteLabel)
        routeIdNameStackView.addArrangedSubview(routeIdTextField)
        routeIdNameStackView.addArrangedSubview(routeNameTextField)
        driverNameVehicleNoStackView.addArrangedSubview(driverNameButton)
        driverNameVehicleNoStackView.addArrangedSubview(vehicleNumberPlateButton)
        addCancelStackView.addArrangedSubview(addButton)
        addCancelStackView.addArrangedSubview(cancelButton)
        mainStackView.addArrangedSubview(routeIdNameStackView)
        mainStackView.addArrangedSubview(driverNameVehicleNoStackView)
        mainStackView.addArrangedSubview(customerTableView)
        mainStackView.addArrangedSubview(addCancelStackView)
        
        self.view.addSubview(mainStackView)
        self.view.backgroundColor = .white
        
        let safeArea = self.view.safeAreaLayoutGuide
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        driverNameButton.addTarget(self, action: #selector(driverNameTapped), for: .touchUpInside)
        vehicleNumberPlateButton.addTarget(self, action: #selector(vehicleNameTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate(
            [mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 50),
             mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -50),
             mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 20),
             mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -20),
             routeIdNameStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             routeIdNameStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
           //  routeIdNameStackView.heightAnchor.constraint(equalToConstant: 150),
             
             driverNameVehicleNoStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             driverNameVehicleNoStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
             addCancelStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             addCancelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
            ])
       
    }
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func driverNameTapped(){
       
        let driverNameVC = SelectDriverViewController(usedFor: .driver)
        driverNameVC.delegate = self
        self.present(driverNameVC, animated: true)
    }

    @objc func vehicleNameTapped(){
       
        let driverNameVC = SelectDriverViewController(usedFor: .vehicle)
        driverNameVC.delegate = self
        self.present(driverNameVC, animated: true)
    }

    func customerNameTapped(){
       
        let driverNameVC = SelectDriverViewController(usedFor: .customer)
        driverNameVC.delegate = self
        self.present(driverNameVC, animated: true)
    }
    
    @objc func addButtonTapped(){
        guard let driverId = self.selectedDriver?.DriverId,
              let vehicleNumb = self.selectedVehicle?.PlateNumber,
              let routeId = self.routeIdTextField.text,
              let routeName = self.routeNameTextField.text,
              self.selectedCustomer.count > 0 else {
            let alert = UIAlertController(title: "Alert", message: "Please fill proper details", preferredStyle: .alert)
            let alertOk = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(alertOk)
            self.present(alert, animated: true)
            return
        }
        var customerIds = ""
        for value in selectedCustomer{
            customerIds += String(describing: value.CustomerId ?? 0)
            customerIds += ","
        }
        customerIds.dropLast()
        
        requestAddRoute(CustomerID: customerIds, DriverId: driverId, RouteName: routeName, VehicleNo: vehicleNumb, completionHandler: {
            addRouteResult in
            DispatchQueue.main.async {
                let alert = handleResult(for: addRouteResult, from: self)
                self.present(alert, animated: true) {
                    self.delegate?.newRouteAdded()
                }
            }
        })
    }
}

extension AddViewController: AddViewControllerDelegate{
    func vehicleSelected(selectedVehicle: VehicleDetails) {
        self.selectedVehicle = selectedVehicle
        self.vehicleNumberPlateButton.setTitle(selectedVehicle.PlateNumber, for: .normal)
    }
    
    func customerSelected(selectedCustomer: CustomerDetails) {
        self.selectedCustomer.append(selectedCustomer)
        customerTableView.reloadData()
    }
    
    func driverSelected(selectedDriver: DriverDetails) {
        self.selectedDriver = selectedDriver
        
        self.driverNameButton.setTitle(selectedDriver.DriverName, for: .normal)
    }
}
extension AddViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= selectedCustomer.count {
            customerNameTapped()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension AddViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCustomer.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.identifier) as? SelectTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row >= selectedCustomer.count {
            cell.driverNameLabel.text = "+"
        } else {
            cell.driverNameLabel.text = selectedCustomer[indexPath.row].CustomerName
        }
        return cell
    }
}
