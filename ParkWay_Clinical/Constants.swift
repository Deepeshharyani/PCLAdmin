//
//  Constants.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/1/23.
//

import Foundation

struct Constants {
    struct URL {
        static let getDriverUrl = "https://pclwebapi.azurewebsites.net/api/Driver/GetDriver"
        static let addDriverUrl = "https://pclwebapi.azurewebsites.net/api/Driver/AddDriver"
        static let updateDriver = "https://pclwebapi.azurewebsites.net/api/Driver/UpdateDriver"
        static let getCustomers = "https://pclwebapi.azurewebsites.net/api/Customer/GetCustomer"
        static let addCustomer = "https://pclwebapi.azurewebsites.net/api/Customer/AddCustomer"
        static let updateCustomerUrl = "https://pclwebapi.azurewebsites.net/api/Customer/UpdateCustomer"
        static let getVehicleUrl = "https://pclwebapi.azurewebsites.net/api/vehicle/GetVehicle"
        static let updateVehicleUrl = "https://pclwebapi.azurewebsites.net/api/vehicle/UpdateVehicle"
        static let addVehicleUrl = "https://pclwebapi.azurewebsites.net/api/vehicle/AddVehicle"
        static let getRouteUrl = "https://pclwebapi.azurewebsites.net/api/Route/GetRoute"
        static let getRoutedetailUrl = "https://pclwebapi.azurewebsites.net/api/Route/GetRouteDetail/?RouteNumber="
        static let addRouteUrl = "https://pclwebapi.azurewebsites.net/api/Route/AddRoute"
        static let updateRouteUrl = "https://pclwebapi.azurewebsites.net/api/Route/EditRoute"
        static let adminDetailUrl = "https://pclwebapi.azurewebsites.net/api/Admin/GetDetailForAdmin"
    }
}
