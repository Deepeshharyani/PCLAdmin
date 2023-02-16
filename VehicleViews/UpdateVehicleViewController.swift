//
//  UpdateVehicleViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/5/23.
//

import UIKit

class UpdateVehicleViewController: UIViewController {
    var data: VehicleDetails? {
        didSet {
            setValues()
        }
    }
    var delegate: VehicleViewControllerDelegate?
    
    let updateVehicleLabel: UILabel = {
        var updateVehicle = UILabel()
        updateVehicle.text = "Update Vehicle"
        updateVehicle.textAlignment = .center
        updateVehicle.textColor = UIColor(named: "Maroon")
        updateVehicle.font = .preferredFont(forTextStyle: .largeTitle)
        return updateVehicle
    }()
    
    lazy var updateNumberPlateTextField: UITextField = {
        var firstName = UITextField()
        firstName.textAlignment = .center
        firstName.borderStyle = UITextField.BorderStyle.roundedRect
        return firstName
    }()
    
       lazy var updateVehicleManufacturerTextField: UITextField = {
        var updateVehicleManufacturer = UITextField()
        updateVehicleManufacturer.textAlignment = .center
        updateVehicleManufacturer.borderStyle = UITextField.BorderStyle.roundedRect
        return updateVehicleManufacturer
    }()
    
    lazy var updateVehicleModelTextField: UITextField = {
        var updateVehicleModel = UITextField()
        updateVehicleModel.textAlignment = .center
       
        updateVehicleModel.borderStyle = UITextField.BorderStyle.roundedRect
        return updateVehicleModel
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
        mainStack.distribution = .fill
        mainStack.spacing = 20
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    let mainView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStackView.addArrangedSubview(updateVehicleLabel)
        mainStackView.addArrangedSubview(updateNumberPlateTextField)
        mainStackView.addArrangedSubview(updateVehicleManufacturerTextField)
        mainStackView.addArrangedSubview(updateVehicleModelTextField)
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
            [mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor ),
             mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             resetCancelStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             resetCancelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
             updateButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
             updateButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
             mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
             mainView.heightAnchor.constraint(equalToConstant: 300),
             mainView.widthAnchor.constraint(equalToConstant: 500)
            ])
    }
    
    func setValues(){
        self.updateVehicleModelTextField.text = data?.Model
        self.updateNumberPlateTextField.text = data?.PlateNumber
        self.updateVehicleManufacturerTextField.text = data?.Manufacturer
    }
    
    @objc func resetButtonTapped(){
        self.updateVehicleManufacturerTextField.text = ""
        self.updateNumberPlateTextField.text = ""
        self.updateVehicleModelTextField.text = ""
    }
    
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func updateButtonTapped() {
        guard let plateNumber = self.updateNumberPlateTextField.text,
              let model = self.updateVehicleModelTextField.text,
              let vehicleId = data?.VehicleId,
              let manufacturer = self.updateVehicleManufacturerTextField.text else{
            return
        }
        
        updateVehicle(Manufacturer: manufacturer, Model: model, PlateNumber: plateNumber, VehicleId: vehicleId, completionHandler: { updateVehicleResult in
            DispatchQueue.main.async {
                let alert = handleResult(for: updateVehicleResult, from: self)
                self.present(alert, animated: true) {
                    self.delegate?.updateVehicle()
                }
            }
        })
    }
    
}
