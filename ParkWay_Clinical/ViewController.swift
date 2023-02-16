//
//  ViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 1/28/23.
//

import UIKit

class ViewController: UIViewController {

    
    var data: [DetailForAdminResponse] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    let tableview: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: safeArea.topAnchor),
             tableview.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             tableview.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             tableview.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        self.title = "Home"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "Maroon")
        
        requestGetDetailsForAdmin(completionHandler: {adminDetailResult in
            DispatchQueue.main.async {
                    switch adminDetailResult{
                case .success(let adminDetailList):
                    
                    self.data = adminDetailList
                    
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let routeClientDetailsVc = RouteClientDetailsViewController()
        routeClientDetailsVc.routeid = data[indexPath.row].RouteNo
        self.navigationController?.pushViewController(routeClientDetailsVc, animated:  true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier:  HomeTableViewCell.identifier) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.routeNoLabel.text = "Route No"
        cell.routeNoTextLabel.text = "\(data[indexPath.row].RouteNo)"
        cell.accountStatusLabel.text = "Account Status"
        cell.pickedUpAtLabel.text = "Picked-up at"
        cell.pickedUpAtTime.text = data[indexPath.row].PickUp_Dt
        cell.pickedUpByLabel.text = "Picked-up by"
        cell.pickedUpByTextLabel.text = (data[indexPath.row].UpdatedByDriver ?? "")
        cell.specimenLabel.text = "Specimen Collected"
        cell.specimenTextLabel.text = String(describing: data[indexPath.row].NumberOfSpecimens)
        cell.onTimeorNot.text = "On Time"
        return cell
    }
        
  }
