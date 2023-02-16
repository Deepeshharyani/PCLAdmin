//
//  UpdateDriverViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/3/23.
//

import UIKit

class UpdateDriverViewController: UIViewController {

    var data: DriverDetails? {
        didSet {
            setValues()
        }
    }
    
    var delegate: DriverViewControllerDelegate?
    let updateDriverLabel: UILabel = {
        var updateDriver = UILabel()
        updateDriver.text = "Update Driver"
        updateDriver.textColor = UIColor(named: "Maroon")
        updateDriver.font = .preferredFont(forTextStyle: .largeTitle)
        return updateDriver
    }()
    
    let firstNameTextField: UITextField = {
        var firstName = UITextField()
        firstName.textAlignment = .center
        firstName.placeholder = "Enter First Name"
        firstName.borderStyle = UITextField.BorderStyle.roundedRect
        firstName.font = .preferredFont(forTextStyle: .title2)
        return firstName
    }()
    
    let lastNameTextField: UITextField = {
        var lastName = UITextField()
        lastName.textAlignment = .center
        lastName.placeholder = "Enter Last Name"
        lastName.borderStyle = UITextField.BorderStyle.roundedRect
        lastName.font = .preferredFont(forTextStyle: .title2)
        return lastName
    }()
    
    let phoneNumberTextField: UITextField = {
        var phoneNumber = UITextField()
        phoneNumber.textAlignment = .center
        phoneNumber.placeholder = "Enter Phone Number"
        phoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        phoneNumber.font = .preferredFont(forTextStyle: .title2)
        return phoneNumber
    }()
    
    var personalDetailStackView: UIStackView = {
        var personalStack = UIStackView()
        personalStack.axis = .vertical
        personalStack.alignment = .fill
        personalStack.distribution = .fillEqually
        return personalStack
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
        mainStack.alignment = .center
        mainStack.distribution = .fill
        mainStack.spacing = 20
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()

    let mainView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStackView.addArrangedSubview(updateDriverLabel)
        personalDetailStackView.addArrangedSubview(firstNameTextField)
        personalDetailStackView.addArrangedSubview(lastNameTextField)
        personalDetailStackView.addArrangedSubview(phoneNumberTextField)
        resetCancelStackView.addArrangedSubview(resetButton)
        resetCancelStackView.addArrangedSubview(cancelButton)
        mainStackView.addArrangedSubview(personalDetailStackView)
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
             mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             personalDetailStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             personalDetailStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             resetCancelStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             resetCancelStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             updateButton.topAnchor.constraint(equalTo: resetCancelStackView.bottomAnchor, constant: 80),
             updateButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             updateButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
             mainView.heightAnchor.constraint(equalToConstant: 300),
             mainView.widthAnchor.constraint(equalToConstant: 500)
            ])
        
        
    }
    
    func setValues(){
        let names = data?.DriverName.split(separator: " ")
        self.firstNameTextField.text = String(describing: names?.first ?? "")
        self.lastNameTextField.text = String(describing: names?.last ?? "")
        self.phoneNumberTextField.text = data?.PhoneNumber
        
    }
    
    @objc func resetButtonTapped(){
        self.firstNameTextField.text = ""
        self.lastNameTextField.text = ""
        self.phoneNumberTextField.text = ""
    }
    
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func updateButtonTapped() {
        guard let driverId = self.data?.DriverId else {
            return
        }
        guard let firstName = self.firstNameTextField.text else{
            return
        }
        guard let lastName = self.lastNameTextField.text else{
            return
        }
        guard let phoneNumber = self.phoneNumberTextField.text else{
            return
        }
        
        updateDriver(driverId: driverId, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, completionHandler: { updateDriverResult in
            DispatchQueue.main.async {
                let alert = handleResult(for: updateDriverResult, from: self)
                self.present(alert, animated: true) {
                    self.delegate?.newDriverUpdate()
                }
            }
        })
    }
}
