//
//  DriverViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/1/23.
//

import UIKit

protocol DriverViewControllerDelegate{
    func newDriverUpdate()
    func newDriverAdded()
}

class DriverViewController: UIViewController {

    
    var driverData: [DriverDetails] = [] {
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
        tableview.register(DriverTableViewCell.self, forCellReuseIdentifier: DriverTableViewCell.identifier)
       
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
        
        getDriverData()
        

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
    
   
    
    @objc func addTapped(){
        let addDriverVC = AddDriverViewController()
        addDriverVC.delegate = self
        self.present(addDriverVC, animated: true)
    }
}
extension DriverViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            driverData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updateDriverVC = UpdateDriverViewController()
        updateDriverVC.data = driverData[indexPath.row]
        updateDriverVC.delegate = self
        self.present(updateDriverVC, animated: true)
    }
    
}

extension DriverViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return driverData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: DriverTableViewCell.identifier) as? DriverTableViewCell else {
            return UITableViewCell()
        }
        cell.data = driverData[indexPath.row]
        return cell
    }
}
extension DriverViewController: DriverViewControllerDelegate{
    func newDriverAdded() {
        self.getDriverData()
    }
    
    func newDriverUpdate() {
        self.getDriverData()
    }
}
    
