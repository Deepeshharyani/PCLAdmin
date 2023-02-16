//
//  DriverTableViewCellTests.swift
//  ParkWay_ClinicalTests
//
//  Created by Deepesh Haryani on 2/10/23.
//

import Foundation
import XCTest
@testable import ParkWay_Clinical

class DriverTableViewCellTests: XCTestCase {
   
    func testSetValues(){
        let cell = DriverTableViewCell()
        cell.setValue()
        XCTAssertNil(cell.driverNameLabel.text)
        
        let data = DriverDetails(DriverId: 1, DriverName: "Driver", PhoneNumber: "9090909000")
        cell.data = data
        cell.setValue()
        XCTAssertEqual(cell.driverNameLabel.text, data.DriverName)
    }
}
