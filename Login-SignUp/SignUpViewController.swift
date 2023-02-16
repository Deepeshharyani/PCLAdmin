//
//  SignUpViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 1/30/23.
//

import UIKit

class SignUpViewController: UIViewController {

    var data: AuthenticateUserAccount?
    
    
    var parkWayImage: UIImageView = {
        var parkWayImg = UIImageView()
        parkWayImg.image = UIImage(named:"ParkWay")
        parkWayImg.translatesAutoresizingMaskIntoConstraints = false
        return parkWayImg
    }()
    
    var loginTextField: UITextField = {
        var loginText = UITextField()
        loginText.placeholder = "Username"
        return loginText
    }()

    var passwordTextField: UITextField = {
        var passwordText = UITextField()
        passwordText.isSecureTextEntry = true
        passwordText.placeholder = "Password"
        return passwordText
    }()
    
    var doneButton: UIButton = {
        var button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = UIColor(named: "Maroon")
       
        return button
    }()
    
    var stackView: UIStackView = {
        var sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(parkWayImage)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(doneButton)
        self.view.addSubview(stackView)
        stackView.backgroundColor = .white
        view.backgroundColor = .white
        
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
             stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -300),
             stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 50),
             stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -50),
             parkWayImage.heightAnchor.constraint(equalToConstant: 200),
             passwordTextField.bottomAnchor.constraint(equalTo: doneButton.topAnchor,constant: 40),
             loginTextField.topAnchor.constraint(equalTo: parkWayImage.bottomAnchor,constant: 20)
            ])
    }
    @objc func doneTapped(){
        signUpDone()
    }
    
    func signUpDone(){
        guard let username = self.loginTextField.text else {
            return
        }
        guard let password = self.passwordTextField.text else {
            return
        }
        createUser(username: username, password: password, completionHandler: {createUserResult in
            switch createUserResult {
            case .success(let model):
                self.data = model
                
                DispatchQueue.main.async {
                    if self.data?.Result.lowercased() == "success"{
                        let vc = LoginViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Alert!", message: self.data?.Result, preferredStyle: .alert)
                        let reTryAction = UIAlertAction(title: "Re-try", style: .cancel)
                        
                        alert.addAction(reTryAction)
                        self.present(alert, animated: true)
                    }
                }
               
            case .failure(_):
                print("Error")
            }
            
        }
        )
        }
    }



