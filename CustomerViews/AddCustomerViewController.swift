//
//  AddCustomerViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/4/23.
//

import UIKit
import CoreLocation

class AddCustomerViewController: UIViewController {
    var custData: CustomerDetails?
    var delegate: CustomerViewControllerDelegate?
    let addCustomerLabel: UILabel = {
        var addDriver = UILabel()
        addDriver.text = "Add Customer"
        addDriver.textAlignment = .center
        addDriver.textColor = UIColor(named: "Maroon")
        return addDriver
    }()
    
    let customerNameTextField: UITextField = {
        var customerName = UITextField()
        customerName.placeholder = "Customer Name"
        customerName.textAlignment = .center
        customerName.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        customerName.borderStyle = UITextField.BorderStyle.roundedRect
        return customerName
    }()
    
    let streetTextField: UITextField = {
        var street = UITextField()
        street.placeholder = "Street"
        street.textAlignment = .center
        street.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        street.borderStyle = UITextField.BorderStyle.roundedRect
        return street
    }()
    
    let cityTextField: UITextField = {
        var city = UITextField()
        city.placeholder = "City"
        city.textAlignment = .center
        city.borderStyle = UITextField.BorderStyle.roundedRect
        city.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        return city
    }()
    
    let stateTextField: UITextField = {
        var state = UITextField()
        state.placeholder = "State"
        state.textAlignment = .center
        state.borderStyle = UITextField.BorderStyle.roundedRect
        state.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        return state
    }()
    
    let zipTextField: UITextField = {
        var zip = UITextField()
        zip.placeholder = "Zip"
        zip.textAlignment = .center
        zip.borderStyle = UITextField.BorderStyle.roundedRect
        zip.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        return zip
    }()
    
    var cityStateZipStackView: UIStackView = {
        var cityStateZipStack = UIStackView()
        cityStateZipStack.axis = .horizontal
        cityStateZipStack.alignment = .fill
        cityStateZipStack.distribution = .fillEqually
        cityStateZipStack.spacing = 1
        cityStateZipStack.translatesAutoresizingMaskIntoConstraints = false
        return cityStateZipStack
    }()
    
    let pickUpLabel: UILabel = {
        var pickUp = UILabel()
        pickUp.text = "Standard PickUp Time"
        pickUp.textColor = UIColor(named: "Maroon")
        return pickUp
    }()
    
    let datePick: UIDatePicker = {
        var date = UIDatePicker()
        date.datePickerMode = .time
        date.preferredDatePickerStyle = .inline
        date.contentHorizontalAlignment = .center
        return date
    }()
    
    let resetButton: UIButton = {
        var reset = UIButton()
        reset.setTitle("Reset", for: .normal)
        reset.setTitleColor(.white, for: .normal)
        reset.backgroundColor = UIColor(named: "Maroon")
        return reset
    }()
    
    let cancelButton: UIButton = {
        var cancel = UIButton()
        cancel.setTitle("Cancel", for: .normal)
        cancel.setTitleColor(.white, for: .normal)
        cancel.backgroundColor = UIColor(named: "Maroon")
        return cancel
    }()
    
    var resetCancelStackView: UIStackView = {
        var resetCancelStack = UIStackView()
        resetCancelStack.axis = .horizontal
        resetCancelStack.alignment = .fill
        resetCancelStack.distribution = .fillEqually
        resetCancelStack.spacing = 1
        resetCancelStack.translatesAutoresizingMaskIntoConstraints = false
        return resetCancelStack
    }()
    
    let addButton: UIButton = {
        var add = UIButton()
        add.setTitle("Add", for: .normal)
        add.setTitleColor(.white, for: .normal)
        add.backgroundColor = UIColor(named: "Maroon")
        add.translatesAutoresizingMaskIntoConstraints = false
        return add
    }()
    
    var mainStackView: UIStackView = {
        var mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fillEqually
        mainStack.spacing = 10
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStackView.addArrangedSubview(addCustomerLabel)
        mainStackView.addArrangedSubview(customerNameTextField)
        mainStackView.addArrangedSubview(streetTextField)
        cityStateZipStackView.addArrangedSubview(cityTextField)
        cityStateZipStackView.addArrangedSubview(stateTextField)
        cityStateZipStackView.addArrangedSubview(zipTextField)
        mainStackView.addArrangedSubview(cityStateZipStackView)
        mainStackView.addArrangedSubview(pickUpLabel)
        mainStackView.addArrangedSubview(datePick)
        resetCancelStackView.addArrangedSubview(resetButton)
        resetCancelStackView.addArrangedSubview(cancelButton)
        mainStackView.addArrangedSubview(resetCancelStackView)
        mainStackView.addArrangedSubview(addButton)
        self.view.addSubview(mainStackView)
        view.backgroundColor = .white
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
             mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
             mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
             cityStateZipStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             cityStateZipStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
             resetCancelStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             resetCancelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
             addButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             addButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
            ])
    }
    
    @objc func resetButtonTapped(){
        self.customerNameTextField.text = ""
        self.streetTextField.text = ""
        self.cityTextField.text = ""
        self.stateTextField.text = ""
        self.zipTextField.text = ""
    }
    
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func addButtonTapped(){
        guard let city = self.cityTextField.text,
              let state = self.stateTextField.text,
              let street = self.streetTextField.text,
              let zip = self.zipTextField.text,
           //   let cust_id = self.custData?.CustomerId,
              let customerName = self.customerNameTextField.text else {
            return
        }
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let pickUpTime = dateFormatter.string(from: datePick.date)
        
        var newCustData = CustomerDetails(
                                          CustomerName: customerName,
                                          StreetAddress: street,
                                          City: city,
                                          State: state,
                                          Zip: zip)
        
        getLatLog(StreetAddress: street, city: city, state: state, zip: zip, completionHandler: { lat, lon in
            newCustData.Cust_Lat = lat
            newCustData.Cust_Log = lon
            requestAddCutomer(newCustData: newCustData,
                           pickUpTime: pickUpTime,
                           completionHandler: { addCustomerResult in
                DispatchQueue.main.async {
                    let alert = handleResult(for: addCustomerResult, from: self)
                    self.present(alert, animated: true) {
                        self.delegate?.newCustomerUpdated()
                    }
                }
            })
        })
    }
    func getLatLog(StreetAddress: String, city: String,state: String, zip: String, completionHandler: @escaping (Double?,Double?)-> ()){
        var geocoder = CLGeocoder()
        var address = "\(StreetAddress),\(city),\(state) \(zip)"
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            completionHandler(lat,lon)
        }
    }
}

