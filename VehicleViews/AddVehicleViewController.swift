//
//  AddVehicleViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/6/23.
//

import UIKit

class AddVehicleViewController: UIViewController {
    var data: AuthenticateUserAccount?
    var delegate: VehicleViewControllerDelegate?
    let addVehicleLabel: UILabel = {
        var addVehicle = UILabel()
        addVehicle.text = "Add Vehicle"
        addVehicle.textColor = UIColor(named: "Maroon")
        addVehicle.font = .preferredFont(forTextStyle: .largeTitle)
        return addVehicle
    }()
    
    let addNumberPlateTextField: UITextField = {
        var addNumberPlate = UITextField()
        addNumberPlate.textAlignment = .center
        addNumberPlate.placeholder = "Enter Number Plate"
        addNumberPlate.borderStyle = UITextField.BorderStyle.roundedRect
        return addNumberPlate
    }()
    
    let addVehicleManufacturerTextField: UITextField = {
        var addVehicleManufacturer = UITextField()
        addVehicleManufacturer.textAlignment = .center
        addVehicleManufacturer.placeholder = "Enter Manufacturer Name"
        addVehicleManufacturer.borderStyle = UITextField.BorderStyle.roundedRect
        return addVehicleManufacturer
    }()
    
    let addVehicleModelTextField: UITextField = {
        var addVehicleModel = UITextField()
        addVehicleModel.textAlignment = .center
        addVehicleModel.placeholder = "Enter Model Name"
        addVehicleModel.borderStyle = UITextField.BorderStyle.roundedRect
        return addVehicleModel
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
        mainStackView.addArrangedSubview(addVehicleLabel)
        mainStackView.addArrangedSubview(addNumberPlateTextField)
        mainStackView.addArrangedSubview(addVehicleManufacturerTextField)
        mainStackView.addArrangedSubview(addVehicleModelTextField)
        resetCancelStackView.addArrangedSubview(resetButton)
        resetCancelStackView.addArrangedSubview(cancelButton)
        mainStackView.addArrangedSubview(resetCancelStackView)
        mainStackView.addArrangedSubview(addButton)
        mainView.backgroundColor = .white
        view.backgroundColor = .clear
        self.mainView.addSubview(mainStackView)
        self.view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
       addButton.addTarget(self, action: #selector(addVehicleButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        let safeArea = self.mainView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
             mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             resetCancelStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             resetCancelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
             addButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             addButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
             mainView.heightAnchor.constraint(equalToConstant: 300),
             mainView.widthAnchor.constraint(equalToConstant: 500)
            ])
        
    }
    @objc func resetButtonTapped(){
        self.addNumberPlateTextField.text = ""
        self.addVehicleManufacturerTextField.text = ""
        self.addVehicleModelTextField.text = ""
    }
    
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func addVehicleButtonTapped(){
        guard let manufacturer = self.addVehicleManufacturerTextField.text else {
            return
        }
        guard let model = self.addVehicleModelTextField.text else {
            return
        }
        guard let plateNumber = self.addNumberPlateTextField.text else {
            return
        }
//        guard let vehicleId = self.data?.VehicleId else {
//            return
//        }
        
      requestAddVehicle(Manufacturer: manufacturer, Model: model, PlateNumber: plateNumber, completionHandler: {
            addVehicleResult in
          DispatchQueue.main.async {
          let alert = handleResult(for: addVehicleResult, from: self)
              self.present(alert, animated: true) {
                  self.delegate?.updateVehicle()
                  
              }
          }
        })
    }
}
