//
//  ParkWayNewtworkLayer.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 1/31/23.
//

import Foundation

enum ResponseResultEnum : Codable{
    case success(AuthenticateUserAccount)
    case failure(String)
}
enum DriverResultEnum : Codable{
    case success([DriverDetails])
    case failure(String)
}

enum DetailsForAdminEnum : Codable{
    case success([DetailForAdminResponse])
    case failure(String)
}

enum AddDriverEnum: Codable{
    case success(AddDriver)
    case failure(String)
}

enum CustomerResultEnum : Codable{
    case success([CustomerDetails])
    case failure(String)
}
enum VehicleResultEnum : Codable{
    case success([VehicleDetails])
    case failure(String)
}

enum RouteResultEnum : Codable{
    case success([routeDetails])
    case failure(String)
}
// MARK: - LOGIN
func createUser(username: String, password: String , completionHandler : @escaping (ResponseResultEnum) -> Void){
    let Url = String(format: "https://gapinternationalwebapi20200521010239.azurewebsites.net/api/User/CreateUserAccount")
        guard let url = URL(string: Url) else {
            return }
        let body: [String: Any] = [
            "UserName": username,
            "Password": password
        ]
      
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                      options: .prettyPrinted)
            request.httpBody = jsonData
            
        } catch {
            print("failed to convert body")
        }
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let data):
            let decoder = JSONDecoder()
            do{
                let resultSignUp = try decoder.decode(AuthenticateUserAccount.self, from: data)
                completionHandler(.success(resultSignUp))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
    }
}

func userLogin(username: String, password: String, completionHandler: @escaping (ResponseResultEnum) -> Void){
    let Url = String(format: "https://gapinternationalwebapi20200521010239.azurewebsites.net/api/User/UserLogin")
    guard let url = URL(string: Url) else {
        return }
    let body: [String: Any] = [
        "UserName": username,
        "Password": password
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                  options: .prettyPrinted)
        request.httpBody = jsonData
    } catch {
        print("failed to convert body")
    }
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let data):
            let decoder = JSONDecoder()
            do{
                let resultLogin = try decoder.decode(AuthenticateUserAccount.self, from: data)
                completionHandler(.success(resultLogin))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
    }
}


func requestGetDetailsForAdmin(completionHandler: @escaping (DetailsForAdminEnum) -> ()){
    let Url = String(format: Constants.URL.adminDetailUrl)
    
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
    var request = URLRequest(url: url)
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let adminDetailData):
            let decoder = JSONDecoder()
            do{
                let resultAdminDetailDriver = try decoder.decode([DetailForAdminResponse].self, from: adminDetailData)
                completionHandler(.success(resultAdminDetailDriver))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }
    
}

// MARK: - CUSTOMER

func requestGetCustomer(completionHandler: @escaping (CustomerResultEnum) -> ()){
    let Url = String(format: Constants.URL.getCustomers)
    
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
    
    var request = URLRequest(url: url)
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let customerData):
            let decoder = JSONDecoder()
            do{
                let resultGetDriver = try decoder.decode([CustomerDetails].self, from: customerData)
                completionHandler(.success(resultGetDriver))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }

}

func requestAddCutomer(newCustData: CustomerDetails,
                       pickUpTime: String,
                       completionHandler: @escaping(ResponseResultEnum)->()){
    let Url = String(format: Constants.URL.addCustomer)
    
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
    
    let body: [String: Any] = [
        "City" : newCustData.City,
        "Cust_Lat" : "\(newCustData.Cust_Lat)",
        "Cust_Log" : "\(newCustData.Cust_Log)",
        "CustomerName" : newCustData.CustomerName,
        "PickupTime": pickUpTime,
        "State" : newCustData.State,
        "StreetAddress" : newCustData.StreetAddress,
        "Zip" : newCustData.Zip
    ]
        
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                  options: .prettyPrinted)
        request.httpBody = jsonData
        
    } catch {
        completionHandler(.failure("JSON Error"))
    }
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let addCustomerData):
            let decoder = JSONDecoder()
            do{
                let addCustomerResult = try decoder.decode(AuthenticateUserAccount.self, from: addCustomerData)
                completionHandler(.success(addCustomerResult))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
            
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }
}

func updateCustomer(newCustData: CustomerDetails,
                    pickUpTime: String,
                    completionHandler: @escaping(ResponseResultEnum)->()) {
    
    let Url = String(format: Constants.URL.updateCustomerUrl)
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
    let body: [String: Any] = [
        "City" : newCustData.City,
        "Cust_Lat" : "\(newCustData.Cust_Lat)",
        "Cust_Log" : "\(newCustData.Cust_Log)",
        "CustomerName" : newCustData.CustomerName,
        "PickupTime" : pickUpTime,
        "State" : newCustData.State,
        "StreetAddress" : newCustData.StreetAddress,
        "Zip" : newCustData.Zip,
        "CustomerId": newCustData.CustomerId
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                  options: .prettyPrinted)
        request.httpBody = jsonData
        
    } catch {
        completionHandler(.failure("JSON Error"))
    }
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let updateCustomerData):
            let decoder = JSONDecoder()
            do{
                let updateCustomerResult = try decoder.decode(AuthenticateUserAccount.self, from: updateCustomerData)
                completionHandler(.success(updateCustomerResult))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
            
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }
}

// MARK: - DRIVER

func requestGetDriver(completionHandler: @escaping  (DriverResultEnum) -> ()) {
    let url = URL(string: Constants.URL.getDriverUrl)
    
    guard let url = url else {
        return
    }
    
    var request = URLRequest(url: url)
    
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let data):
            let decoder = JSONDecoder()
            do{
                let resultGetDriver = try decoder.decode([DriverDetails].self, from: data)
                completionHandler(.success(resultGetDriver))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }
}


func addDriver(firstName: String, lastName: String, phoneNumber: String, completionHandler: @escaping (ResponseResultEnum) -> ()){
    let Url = String(format: Constants.URL.addDriverUrl)
        guard let url = URL(string: Url) else {
            completionHandler(.failure("URL Error"))
            return
        }
        let body: [String: Any] = [
            "FirstName" : firstName,
            "LastName" : lastName,
            "PhoneNumber" : phoneNumber
        ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                  options: .prettyPrinted)
        request.httpBody = jsonData
        
    } catch {
        completionHandler(.failure("JSON Error"))
    }
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let addDriverdata):
            let decoder = JSONDecoder()
            do{
                let resultAddDriver = try decoder.decode(AuthenticateUserAccount.self, from: addDriverdata)
                completionHandler(.success(resultAddDriver))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
    }
}

func updateDriver(driverId: Int,
                  firstName: String,
                  lastName: String,
                  phoneNumber: String,
                  completionHandler: @escaping (ResponseResultEnum) -> ()){
    let Url = String(format: Constants.URL.updateDriver)
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
    let body: [String: Any] = [
        "DriverId" : driverId,
        "FirstName" : firstName,
        "LastName" : lastName,
        "PhoneNumber" : phoneNumber
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                  options: .prettyPrinted)
        request.httpBody = jsonData
        
    } catch {
        completionHandler(.failure("JSON Error"))
    }
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let updateDriverData):
            let decoder = JSONDecoder()
            do{
                let updateResult = try decoder.decode(AuthenticateUserAccount.self, from: updateDriverData)
                completionHandler(.success(updateResult))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
            
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }
        
}


// MARK: - VEHICLE

func requestgetVehicle(completionHandler: @escaping  (VehicleResultEnum) -> ()){
    let url = URL(string: Constants.URL.getVehicleUrl)
    
    guard let url = url else {
        return
    }
    
    var request = URLRequest(url: url)
    
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let vehicleData):
            let decoder = JSONDecoder()
            do{
                let resultGetVehicle = try decoder.decode([VehicleDetails].self, from: vehicleData)
                completionHandler(.success(resultGetVehicle))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }
}

func updateVehicle(Manufacturer: String,
                   Model: String,
                   PlateNumber: String,
                   VehicleId: Int,
                   completionHandler: @escaping (ResponseResultEnum)->()){
    
    let Url = String(format: Constants.URL.updateVehicleUrl)
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
    
    let body: [String: Any] = [
        "Manufacturer" : Manufacturer,
        "Model" : Model,
        "PlateNumber": PlateNumber,
        "VehicleId" : VehicleId
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                  options: .prettyPrinted)
        request.httpBody = jsonData
        
    } catch {
        completionHandler(.failure("JSON Error"))
    }
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let updateVehicleData):
            let decoder = JSONDecoder()
            do{
                let updateVehicleResult = try decoder.decode(AuthenticateUserAccount.self, from: updateVehicleData)
                completionHandler(.success(updateVehicleResult))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
            
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }
    
}

func requestAddVehicle(Manufacturer: String,
                       Model: String,
                       PlateNumber: String,
                       completionHandler: @escaping (ResponseResultEnum) -> () ){
    let Url = String(format: Constants.URL.addVehicleUrl)
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
    
    let body: [String: Any] = [
        "Manufacturer" : Manufacturer,
        "Model" : Model,
        "PlateNumber": PlateNumber
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                  options: .prettyPrinted)
        request.httpBody = jsonData
        
    } catch {
        completionHandler(.failure("JSON Error"))
    }
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let addVehicleData):
            let decoder = JSONDecoder()
            do{
                let addVehicleResult = try decoder.decode(AuthenticateUserAccount.self, from: addVehicleData)
                completionHandler(.success(addVehicleResult))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
            
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }
}

// MARK: - ROUTE

func requestGetRoute(completionHandler: @escaping (RouteResultEnum) ->()){
    
    let Url = String(format: Constants.URL.getRouteUrl)
    
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
    
    var request = URLRequest(url: url)
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let routeData):
            let decoder = JSONDecoder()
            do{
                let resultGetRoute = try decoder.decode([routeDetails].self, from: routeData)
                completionHandler(.success(resultGetRoute))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }
}

func requestGetRoutedetail(RouteNumber: Int ,completionHandler: @escaping (RouteResultEnum) ->()){
    
    let Url = String(format: Constants.URL.getRoutedetailUrl) + "\(RouteNumber)"
    
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
//    let body: [String: Any] = [
//        "RouteNumber": RouteNumber
//    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
//    do {
//        let jsonData = try JSONSerialization.data(withJSONObject: body,
//                                                  options: .prettyPrinted)
//        request.httpBody = jsonData
//
//    } catch {
//        completionHandler(.failure("JSON Error"))
//    }
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let routeData):
            let decoder = JSONDecoder()
            do{
                let resultGetRoute = try decoder.decode([routeDetails].self, from: routeData)
                completionHandler(.success(resultGetRoute))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
        
    }
}

func requestAddRoute(CustomerID: String,DriverId: Int,RouteName: String,VehicleNo: String, completionHandler: @escaping (ResponseResultEnum) -> ()){
    let Url = String(format: Constants.URL.addRouteUrl)
    
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
    
    let body: [String: Any] = [
        "CustomerID" : CustomerID,
        "DriverId" : DriverId,
        "RouteName": RouteName,
        "VehicleNo" : VehicleNo
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                  options: .prettyPrinted)
        request.httpBody = jsonData
        
    } catch {
        completionHandler(.failure("JSON Error"))
    }
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let addRouteData):
            let decoder = JSONDecoder()
            do{
                let addRouteResult = try decoder.decode(AuthenticateUserAccount.self, from: addRouteData)
                completionHandler(.success(addRouteResult))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
            
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
    }
}
func updateRoute(CustomerID: String,DriverId: Int,RouteName: String,RouteNo: String,VehicleNo: String, completionHandler: @escaping (ResponseResultEnum) -> ()){
    let Url = String(format: Constants.URL.updateRouteUrl)
    
    guard let url = URL(string: Url) else {
        completionHandler(.failure("URL Error"))
        return
    }
    let body: [String: Any] = [
        "CustomerID" : CustomerID,
        "DriverId" : DriverId,
        "RouteName": RouteName,
        "RouteNo" : RouteNo,
        "VehicleNo" : VehicleNo
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                  options: .prettyPrinted)
        request.httpBody = jsonData
        
    } catch {
        completionHandler(.failure("JSON Error"))
    }
    
    requestData(urlRequest: request) { networkResult in
        switch networkResult{
        case .success(let updateRouteData):
            let decoder = JSONDecoder()
            do{
                let updateRouteResult = try decoder.decode(AuthenticateUserAccount.self, from: updateRouteData)
                completionHandler(.success(updateRouteResult))
            }catch{
                completionHandler(.failure("Decoding Error"))
            }
            
        case .failure(_):
            completionHandler(.failure("Network Error"))
        }
    }
}
