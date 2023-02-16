//
//  SettingsViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 1/30/23.
//

import UIKit

struct TableData: Equatable {
    let name: String
}

class SettingsViewController: UIViewController {

    var tableArray: [TableData] = [
        TableData(name: "Driver"),
        TableData(name: "Customer"),
        TableData(name: "Vehicle"),
        TableData(name: "Route")
    ]
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(settingTableViewCell.self, forCellReuseIdentifier: settingTableViewCell.identifier)
       
        view.backgroundColor = .white
        self.view.addSubview(tableview)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [tableview.topAnchor.constraint(equalTo: safeArea.topAnchor),
             tableview.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             tableview.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             tableview.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)])
        
        self.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "Maroon")
    }
}
extension SettingsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let driverVC = DriverViewController()
            self.navigationController?.pushViewController(driverVC, animated: true)
        }else if  indexPath.row == 1{
            let customerVC = CustomerViewController()
            self.navigationController?.pushViewController(customerVC, animated: true)
        }else if indexPath.row == 2{
            let vehicleVC = VehicleViewController()
            self.navigationController?.pushViewController(vehicleVC, animated: true)
        }else if indexPath.row == 3 {
            let routeVC = RouteViewController()
            self.navigationController?.pushViewController(routeVC, animated: true)
        }
           
        
//        let driverVC = DriverViewController()
//        self.navigationController?.pushViewController(driverVC, animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: settingTableViewCell.identifier) as? settingTableViewCell else {
            return UITableViewCell()
        }
        cell.data = tableArray[indexPath.row]
        return cell
    }
}
