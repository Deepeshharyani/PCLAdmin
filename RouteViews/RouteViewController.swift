//
//  RouteViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/6/23.
//

import UIKit

protocol RouteViewControllerDelegate{
    func newRouteAdded()
}

enum AddorUpdate: Codable {
    case add
    case update
}


class RouteViewController: UIViewController {

    var routeData: [routeDetails] = [] {
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

        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(RouteTableViewCell.self, forCellReuseIdentifier: RouteTableViewCell.identifier)
       
        view.backgroundColor = .white
        self.view.addSubview(tableview)
        
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [tableview.topAnchor.constraint(equalTo: safeArea.topAnchor),
             tableview.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             tableview.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             tableview.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)])
        
        
  self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    self.navigationController?.navigationBar.barTintColor = UIColor(named: "Maroon")
        getRouteData()
    }
    
    private func getRouteData(){
        requestGetRoute(completionHandler: { routeResult in
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
    
    @objc func addTapped(){
        let addRouteVC = AddViewController()
        addRouteVC.delegate = self
        self.present(addRouteVC, animated: true)
    }
}
extension RouteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            routeData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension RouteViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return routeData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: RouteTableViewCell.identifier) as? RouteTableViewCell else {
            return UITableViewCell()
        }
        cell.data = routeData[indexPath.row]
        return cell
    }
}
extension RouteViewController: RouteViewControllerDelegate{
    func newRouteAdded() {
        self.getRouteData()
    }
}

