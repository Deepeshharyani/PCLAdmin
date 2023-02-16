//
//  RouteClientDetailsViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/14/23.
//

import UIKit

class RouteClientDetailsViewController: UIViewController {
    
    var routeData: [routeDetails] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    var routeid = 0
//    var data2: [DetailForAdminResponse] = [] {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableview.reloadData()
//            }
//        }
//    }
    
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
        tableview.register(RouteClientDetailsViewControllerTableViewCell.self, forCellReuseIdentifier: RouteClientDetailsViewControllerTableViewCell.identifier)
        
        
        
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: safeArea.topAnchor),
             tableview.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             tableview.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             tableview.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Maroon")
            getRouteData()
    }
    
    private func getRouteData(){
        requestGetRoutedetail(RouteNumber: routeid, completionHandler: { routeResult in
            DispatchQueue.main.async {
                switch routeResult{
                case .success(let routeList):
                    
                    self.routeData = routeList
                    
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
extension RouteClientDetailsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension RouteClientDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier:  RouteClientDetailsViewControllerTableViewCell.identifier) as? RouteClientDetailsViewControllerTableViewCell else {
            return UITableViewCell()
        }
        cell.data = routeData[indexPath.row].Customer.first
        cell.driverData = routeData[indexPath.row].Route
        return cell
    }
}
