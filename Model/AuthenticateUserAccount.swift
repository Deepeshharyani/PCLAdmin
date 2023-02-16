//
//  CreateUSserAccount.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 1/31/23.
//

import Foundation

struct AuthenticateUserAccount: Codable {
    var Result: String
}

struct DriverDetails: Codable {
    var DriverId: Int
    var DriverName: String
    var PhoneNumber: String
}

struct AddDriver: Codable{
    var FirstName: String
    var LastName: String
    var PhoneNumber: String
    var Result: String
}

struct CustomerDetails: Codable {
    var CustomerId: Int?
    var CustomerName: String?
    var StreetAddress: String?
    var City: String?
    var State: String?
    var Zip: String?
    var CollectionStatus: String?
    var SpecimenCount: Int?
    var PickUpTime: String?
    var IsSelected: Bool?
    var Cust_Lat: Double?
    var Cust_Log: Double?
}

struct VehicleDetails: Codable{
    var VehicleId: Int
    var PlateNumber: String
    var Manufacturer: String
    var Model: String
}

struct routeDetails: Codable{
    var Route: RouteResponse
    var Customer: [CustomerResponse]
}
struct RouteResponse: Codable{
    var RouteNo: Int
    var RouteName: String
    var DriverId: Int
    var DriverName: String
    var VehicleNo: String
}
struct CustomerResponse: Codable{
    var CustomerId: Int
    var CustomerName: String
    var StreetAddress: String
    var City: String
    var State: String
    var Zip: String
    var PickUpTime: String
    var SpecimensCollected: Int
    var CollectionStatus: String
    var IsSelected: Bool
    var Cust_Lat: Double
    var Cust_Log: Double
}
struct DetailForAdminResponse : Codable{
    var TranId : Int
    var RouteNo : Int
    var CustomerId : Int
    var Status : Int
    var PickUp_Dt : String?
    var PickUp_Time : String?
    var NumberOfSpecimens : Int
    var CreatedDate: String?
    var UpdatedByDriver : String?
}
