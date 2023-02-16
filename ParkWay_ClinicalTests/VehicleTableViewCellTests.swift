//
//  VehicleTableViewCellTests.swift
//  ParkWay_ClinicalTests
//
//  Created by Deepesh Haryani on 2/10/23.
//

@testable import ParkWay_Clinical
import Foundation
import XCTest

// XCTAssertEqual(<#T##expression1: Equatable##Equatable#>, <#T##expression2: Equatable##Equatable#>)
//XCTAssertNil(<#T##expression: Any?##Any?#>)
//XCTAssertNotNil(<#T##expression: Any?##Any?#>)
//XCTUnwrap // Guard
//XCTAssertTrue(<#T##expression: Bool##Bool#>)
//XCTAssertFalse(<#T##expression: Bool##Bool#>)


class VehicleTableViewCellTests: XCTestCase {

    func testVehicleNameLabelExists() throws {
        let cell = VehicleTableViewCell()
        let stackView = try XCTUnwrap(cell.subviews.first as? UIStackView)
        XCTAssertEqual(stackView.alignment, .center)
        XCTAssertEqual(stackView.distribution, .fillEqually)
        
        let label = try XCTUnwrap(stackView.subviews.first)
    }
    
    func testSetValues() {
        let cell = VehicleTableViewCell()
        cell.setValue()
        XCTAssertNil(cell.vehicleNameLabel.text)
        
        let data = VehicleDetails(VehicleId: 1,
                                  PlateNumber: "PlateNo",
                                  Manufacturer: "Manuf",
                                  Model: "Model")
        cell.data = data
        cell.setValue()
        XCTAssertNotNil(cell.vehicleNameLabel.text)
        XCTAssertEqual(cell.vehicleNameLabel.text, data.PlateNumber)
    }
}
var dict : [Int : Int] = [:]
