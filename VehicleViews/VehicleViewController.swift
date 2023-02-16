//
//  VehicleViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/5/23.
//

import UIKit

protocol VehicleViewControllerDelegate{
    func updateVehicle()
}

class VehicleViewController: UIViewController {

    var vehicleData: [VehicleDetails] = [] {
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
        tableview.register(VehicleTableViewCell.self, forCellReuseIdentifier: VehicleTableViewCell.identifier)
       
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
        

        
        getVehicleData()
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
    
    @objc func addTapped(){
        let addVehicleVC = AddVehicleViewController()
        addVehicleVC.delegate = self
        self.present(addVehicleVC, animated: true)
    }
}
extension VehicleViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            vehicleData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updateVehicleVC = UpdateVehicleViewController()
        updateVehicleVC.data = vehicleData[indexPath.row]
        updateVehicleVC.delegate = self
        self.present(updateVehicleVC, animated: true)
    }
}

extension VehicleViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vehicleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: VehicleTableViewCell.identifier) as? VehicleTableViewCell else {
            return UITableViewCell()
        }
        cell.data = vehicleData[indexPath.row]
        return cell
    }
}
extension VehicleViewController: VehicleViewControllerDelegate{
    func updateVehicle() {
        getVehicleData()
    }
}
