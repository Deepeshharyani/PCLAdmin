//
//  SelectDriverViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/6/23.
//

import UIKit

enum SelectionOptions {
    case driver
    case vehicle
    case customer
}

class SelectDriverViewController: UIViewController {

    var usedFor: SelectionOptions

    init(usedFor: SelectionOptions) {
        self.usedFor = usedFor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: AddViewControllerDelegate?
    var driverData: [DriverDetails] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }

    var vehicleData: [VehicleDetails] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }

    var customerData: [CustomerDetails] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }

    let titleLabel: UILabel = {
        var addVehicle = UILabel()
        addVehicle.textAlignment = .left
        addVehicle.textColor = UIColor(named: "Maroon")
        addVehicle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return addVehicle
    }()

    let tableview: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
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
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(SelectTableViewCell.self, forCellReuseIdentifier: SelectTableViewCell.identifier)
       
        view.backgroundColor = .white
        self.mainStackView.addArrangedSubview(titleLabel)
        self.mainStackView.addArrangedSubview(tableview)
        self.view.addSubview(mainStackView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
             mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -30),
             mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
             mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)])
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Maroon")
        titleLabel.text = getTitle(for: usedFor)
        switch usedFor {
        case .driver:
            getDriverData()
        case .vehicle:
            getVehicleData()
        case .customer:
            getCustomerData()
        }
    }

    func getTitle(for element: SelectionOptions) -> String {
        switch element {
        case .driver:
            return "Select a Driver"
        case .vehicle:
            return "Select a Vehicle"
        case .customer:
            return "Select a Customer"
        }
    }
    
    private func getVehicleData(){
        requestgetVehicle(completionHandler: { vehicleResult in
            DispatchQueue.main.async {
                    switch vehicleResult{
                case .success(let vehicleList):

                    self.vehicleData = vehicleList

                case .failure(let errorString):
                    let alert = UIAlertController(title: "Alert", message: errorString, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Cancel", style: .cancel)

                    alert.addAction(alertAction)
                    self.present(alert, animated: true)
                }
            }
        })
    }
    
    private func getCustomerData() {
        requestGetCustomer(completionHandler: { customerResult in
             DispatchQueue.main.async {
                     switch customerResult{
                 case .success(let customerList):
                     
                     self.customerData = customerList
                     
                 case .failure(let errorString):
                     let alert = UIAlertController(title: "Alert", message: errorString, preferredStyle: .alert)
                     let alertAction = UIAlertAction(title: "Cancel", style: .cancel)
                     
                     alert.addAction(alertAction)
                     self.present(alert, animated: true)
                 }
             }
         })
    }

    
    private func getDriverData(){
        requestGetDriver(completionHandler: { driverResult in
            DispatchQueue.main.async {
                switch driverResult{
                case .success(let driverList):
                    
                    self.driverData = driverList
                    
                case .failure(let errorString):
                    let alert = UIAlertController(title: "Alert", message: errorString, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Cancel", style: .cancel)
                    
                    alert.addAction(alertAction)
                    self.present(alert, animated: true)
                }
            }
        })
    }
    
}
extension SelectDriverViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch usedFor {
        case .driver:
            self.delegate?.driverSelected(selectedDriver: driverData[indexPath.row])
        case .vehicle:
            self.delegate?.vehicleSelected(selectedVehicle: vehicleData[indexPath.row])
        case .customer:
            self.delegate?.customerSelected(selectedCustomer: customerData[indexPath.row])
        }
        
        self.dismiss(animated: true)
    }
    
}
extension SelectDriverViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch usedFor {
        case .driver:
            return driverData.count
        case .vehicle:
            return vehicleData.count
        case .customer:
            return customerData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: SelectTableViewCell.identifier) as? SelectTableViewCell else {
            return UITableViewCell()
        }
        switch usedFor {
        case .driver:
            cell.driverNameLabel.text = driverData[indexPath.row].DriverName
        case .vehicle:
            cell.driverNameLabel.text = vehicleData[indexPath.row].PlateNumber
        case .customer:
            cell.driverNameLabel.text = customerData[indexPath.row].CustomerName
        }
        
        return cell
    }
}

