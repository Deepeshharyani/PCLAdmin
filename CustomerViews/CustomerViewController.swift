//
//  CustomerViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/4/23.
//

import UIKit

protocol CustomerViewControllerDelegate {
    func newCustomerUpdated()
    func addCustomerupdate()
}

class CustomerViewController: UIViewController {

    var customerData: [CustomerDetails] = [] {
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
        tableview.register(CustomerTableViewCell.self, forCellReuseIdentifier: CustomerTableViewCell.identifier)
       
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
        getData()
    }

    private func getData() {
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
    
    @objc func addTapped(){
        let addCustomerVC = AddCustomerViewController()
        addCustomerVC.delegate = self
        self.present(addCustomerVC, animated: true)
    }
}
extension CustomerViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            customerData.remove(at: indexPath.row)
            // HIT API
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updateCustomerVC = UpdateCustomerViewController()
        updateCustomerVC.custData = customerData[indexPath.row]
        updateCustomerVC.delegate = self
        self.present(updateCustomerVC, animated: true)
    }
    
}

extension CustomerViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return customerData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: CustomerTableViewCell.identifier) as? CustomerTableViewCell else {
            return UITableViewCell()
        }
        cell.data = customerData[indexPath.row]
        return cell
    }

}

extension CustomerViewController: CustomerViewControllerDelegate {
    func addCustomerupdate() {
        self.getData()
    }
    
    func newCustomerUpdated() {
        self.getData()
    }
}
