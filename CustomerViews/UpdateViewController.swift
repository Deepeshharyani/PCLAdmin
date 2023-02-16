//
//  UpdateViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/5/23.
//

import UIKit
import CoreLocation

class UpdateCustomerViewController: UIViewController {

    var custData: CustomerDetails? {
        didSet {
            setValues()
        }
    }
    var delegate: CustomerViewControllerDelegate?
    
    let updateCustomerLabel: UILabel = {
        var updateCustomer = UILabel()
        updateCustomer.text = "Update Customer"
        updateCustomer.textAlignment = .center
        updateCustomer.textColor = UIColor(named: "Maroon")
        updateCustomer.font = .preferredFont(forTextStyle: .largeTitle)
        return updateCustomer
    }()
    
    let updateCustomerNameTextField: UITextField = {
        var updateCustomerName = UITextField()
        updateCustomerName.placeholder = "Customer Name"
        updateCustomerName.textAlignment = .center
        updateCustomerName.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        updateCustomerName.borderStyle = UITextField.BorderStyle.roundedRect
        return updateCustomerName
    }()
    
    let updateCustomerStreetTextField: UITextField = {
        var updateCustomerStreet = UITextField()
        updateCustomerStreet.placeholder = "Street"
        updateCustomerStreet.textAlignment = .center
        updateCustomerStreet.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        updateCustomerStreet.borderStyle = UITextField.BorderStyle.roundedRect
        return updateCustomerStreet
    }()
    
    let updateCustomerCityTextField: UITextField = {
        var updateCustomerCity = UITextField()
        updateCustomerCity.placeholder = "City"
        updateCustomerCity.textAlignment = .center
        updateCustomerCity.borderStyle = UITextField.BorderStyle.roundedRect
        updateCustomerCity.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        return updateCustomerCity
    }()
    
    let updateCustomerStateTextField: UITextField = {
        var updateCustomerState = UITextField()
        updateCustomerState.placeholder = "State"
        updateCustomerState.textAlignment = .center
        updateCustomerState.borderStyle = UITextField.BorderStyle.roundedRect
        updateCustomerState.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        return updateCustomerState
    }()
    
    let updateCustomerZipTextField: UITextField = {
        var updateCustomerZip = UITextField()
        updateCustomerZip.placeholder = "Zip"
        updateCustomerZip.textAlignment = .center
        updateCustomerZip.borderStyle = UITextField.BorderStyle.roundedRect
        updateCustomerZip.layer.borderColor = UIColor(named: "Maroon")?.cgColor
        return updateCustomerZip
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
    
    
    let updateButton: UIButton = {
        var update = UIButton()
        update.setTitle("Update", for: .normal)
        update.setTitleColor(.white, for: .normal)
        update.backgroundColor = UIColor(named: "Maroon")
        update.translatesAutoresizingMaskIntoConstraints = false
        return update
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
    
    let mainView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainStackView.addArrangedSubview(updateCustomerLabel)
        mainStackView.addArrangedSubview(updateCustomerNameTextField)
        mainStackView.addArrangedSubview(updateCustomerStreetTextField)
        cityStateZipStackView.addArrangedSubview(updateCustomerCityTextField)
        cityStateZipStackView.addArrangedSubview(updateCustomerStateTextField)
        cityStateZipStackView.addArrangedSubview(updateCustomerZipTextField)
        mainStackView.addArrangedSubview(cityStateZipStackView)
        mainStackView.addArrangedSubview(pickUpLabel)
        mainStackView.addArrangedSubview(datePick)
        resetCancelStackView.addArrangedSubview(resetButton)
        resetCancelStackView.addArrangedSubview(cancelButton)
        mainStackView.addArrangedSubview(resetCancelStackView)
        mainStackView.addArrangedSubview(updateButton)
        mainView.backgroundColor = .white
        view.backgroundColor = .clear
        self.mainView.addSubview(mainStackView)
        self.view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        let safeArea = self.mainView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
             mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
             mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
             cityStateZipStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             cityStateZipStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
             resetCancelStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             resetCancelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
             updateButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             updateButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
             mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
             mainView.heightAnchor.constraint(equalToConstant: 500),
             mainView.widthAnchor.constraint(equalToConstant: 500)
            ])
    }
    
    
    func setValues(){
        self.updateCustomerNameTextField.text = custData?.CustomerName
        self.updateCustomerStreetTextField.text = custData?.StreetAddress
        self.updateCustomerCityTextField.text = custData?.City
        self.updateCustomerStateTextField.text = custData?.State
        self.updateCustomerZipTextField.text = custData?.Zip
    }
    
    @objc func resetButtonTapped(){
        self.updateCustomerNameTextField.text = ""
        self.updateCustomerStreetTextField.text = ""
        self.updateCustomerCityTextField.text = ""
        self.updateCustomerStateTextField.text = ""
        self.updateCustomerZipTextField.text = ""
    }
    
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func updateButtonTapped(){
        guard let city = self.updateCustomerCityTextField.text,
              let state = self.updateCustomerStateTextField.text,
              let street = self.updateCustomerStreetTextField.text,
              let zip = self.updateCustomerZipTextField.text,
              let cust_id = self.custData?.CustomerId,
              let customerName = self.updateCustomerNameTextField.text else {
            return
        }

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let pickUpTime = dateFormatter.string(from: datePick.date)

        var newCustData = CustomerDetails(CustomerId: cust_id,
                                          CustomerName: customerName,
                                          StreetAddress: street,
                                          City: city,
                                          State: state,
                                          Zip: zip)
        
        getLatLog(StreetAddress: street,
                  city: city,
                  state: state,
                  zip: zip, completionHandler: { lat, lon in
            newCustData.Cust_Lat = lat
            newCustData.Cust_Log = lon
            updateCustomer(newCustData: newCustData,
                           pickUpTime: pickUpTime,
                           completionHandler: { updateCustomerResult in
                DispatchQueue.main.async {
                    let alert = handleResult(for: updateCustomerResult, from: self)
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
