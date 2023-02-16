//
//  AddVehicleViewControllerTests.swift
//  ParkWay_ClinicalTests
//
//  Created by Deepesh Haryani on 2/10/23.
//

import Foundation
import XCTest
@testable import ParkWay_Clinical

class AddVehicleViewControllerTests: XCTestCase{
    func testresetButtonTapped(){
        let cell = AddVehicleViewController()
        
        cell.addNumberPlateTextField.text = "ABC"
        cell.addVehicleManufacturerTextField.text = "DEF"
        cell.addVehicleModelTextField.text = "GHI"
        
        cell.resetButtonTapped()
        
        XCTAssertEqual(cell.addNumberPlateTextField.text, "")
        XCTAssertEqual(cell.addVehicleManufacturerTextField.text, "")
        XCTAssertEqual(cell.addVehicleModelTextField.text, "")
    }
}
