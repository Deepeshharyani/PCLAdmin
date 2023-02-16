//
//  AddDriverViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/2/23.
//

import UIKit

class AddDriverViewController: UIViewController {
    
    var data: AuthenticateUserAccount?
    var delegate: DriverViewControllerDelegate?
    let addDriverLabel: UILabel = {
        var addDriver = UILabel()
        addDriver.text = "Add Driver"
        addDriver.textColor = UIColor(named: "Maroon")
        addDriver.font = .preferredFont(forTextStyle: .largeTitle)
        return addDriver
    }()
    
    let firstNameTextField: UITextField = {
        var firstName = UITextField()
        firstName.placeholder = "First Name"
        firstName.textAlignment = .center
        firstName.borderStyle = UITextField.BorderStyle.roundedRect
        
        return firstName
    }()
    
    let lastNameTextField: UITextField = {
        var lastName = UITextField()
        lastName.placeholder = "Last Name"
        lastName.textAlignment = .center
        lastName.borderStyle = UITextField.BorderStyle.roundedRect
        
        return lastName
    }()
    
    let phoneNumberTextField: UITextField = {
        var phoneNumber = UITextField()
        phoneNumber.placeholder = "Phone Number"
        phoneNumber.textAlignment = .center
        phoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        
        return phoneNumber
    }()
    
    var personalDetailStackView: UIStackView = {
        var personalStack = UIStackView()
        personalStack.axis = .vertical
        personalStack.alignment = .fill
        personalStack.distribution = .fillEqually
        //  personalStack.spacing = 3
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
        mainStack.alignment = .center
        mainStack.distribution = .fill
        mainStack.spacing = 20
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    let mainView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStackView.addArrangedSubview(addDriverLabel)
        personalDetailStackView.addArrangedSubview(firstNameTextField)
        personalDetailStackView.addArrangedSubview(lastNameTextField)
        personalDetailStackView.addArrangedSubview(phoneNumberTextField)
        resetCancelStackView.addArrangedSubview(resetButton)
        resetCancelStackView.addArrangedSubview(cancelButton)
        mainStackView.addArrangedSubview(personalDetailStackView)
        mainStackView.addArrangedSubview(resetCancelStackView)
        mainStackView.addArrangedSubview(addButton)
        mainView.backgroundColor = .white
        view.backgroundColor = .clear
        self.mainView.addSubview(mainStackView)
        self.view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
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
             addButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             addButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor), mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
             mainView.heightAnchor.constraint(equalToConstant: 300),
             mainView.widthAnchor.constraint(equalToConstant: 500)
            ])
        
    }
    
    @objc func resetButtonTapped(){
        self.firstNameTextField.text = ""
        self.lastNameTextField.text = ""
        self.phoneNumberTextField.text = ""
    }
    
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }
    
    
    @objc func addButtonTapped(){
        addDriverButton()
    }
    
    @objc func addDriverButton(){
        guard let fName = self.firstNameTextField.text else {
            return
        }
        guard let lName = self.lastNameTextField.text else {
            return
        }
        guard let phoneNumber = self.phoneNumberTextField.text else {
            return
        }
        
        addDriver(firstName: fName, lastName: lName, phoneNumber: phoneNumber, completionHandler: {
            addDriverResult in
            DispatchQueue.main.async {
                let alert = handleResult(for: addDriverResult, from: self)
                self.present(alert, animated: true) {
                    self.delegate?.newDriverAdded()
                }
            }
        })
    }
}
