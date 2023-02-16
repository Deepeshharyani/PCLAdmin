//
//  SharedFunctions.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 2/7/23.
//

import UIKit

func handleResult(for input: ResponseResultEnum,
                  from: UIViewController) -> UIAlertController {
    switch input {
    case .success(let updateCustomerData):
        var alert = UIAlertController(title: "Success",
                                      message: "",
                                      preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok",
                                    style: .default) {_ in 
            from.dismiss(animated: true)
        }
        if updateCustomerData.Result.lowercased() != "success" {
            alert.title = "Something went wrong!"
            alert.message = updateCustomerData.Result
        }
        alert.addAction(alertOk)
        
        return alert
    case .failure(let errorString):
        let alert = UIAlertController(title: "Something went wrong!",
                                      message: errorString,
                                      preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Try Again",
                                    style: .default)
        alert.addAction(alertOk)
        return alert
    }
}
