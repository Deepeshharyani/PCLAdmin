//
//  ParkWayNetworkLayer.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 1/31/23.
//

import Foundation
enum NetworkResult : Codable{
    case success(Data)
    case failure(String)
}
func requestData(urlRequest: URLRequest,
                 completionHandler: @escaping (NetworkResult) -> Void) {
    URLSession.shared.dataTask(with: urlRequest) { (data, httpRequestHeader, error) in
        if let error = error {
            print(error)
            completionHandler(.failure(error.localizedDescription))
        }
        if let data = data {
            completionHandler(.success(data))
        }else{
            completionHandler(.failure("Data not Found"))
        }
    }.resume()
}
