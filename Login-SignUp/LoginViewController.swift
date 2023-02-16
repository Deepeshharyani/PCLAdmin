//
//  LoginViewController.swift
//  ParkWay_Clinical
//
//  Created by Deepesh Haryani on 1/30/23.
//

import UIKit

class LoginViewController: UIViewController {
    
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
    
    var loginButton: UIButton = {
        var button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(named: "Maroon")
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    var signButton: UIButton = {
        var signbutton = UIButton()
        signbutton.setTitle("SignUp", for: .normal)
        signbutton.backgroundColor = .red
        signbutton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        return signbutton
    }()
    
    let loginSignupStackView: UIStackView = {
        let loginSignupStack = UIStackView()
        loginSignupStack.axis = .horizontal
        loginSignupStack.alignment = .fill
        loginSignupStack.distribution = .fillEqually
        loginSignupStack.spacing = 3
        // mainStack.translatesAutoresizingMaskIntoConstraints = false
        return loginSignupStack
    }()
    
    let mainStackView: UIStackView = {
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        mainStackView.addArrangedSubview(parkWayImage)
        mainStackView.addArrangedSubview(loginTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        loginSignupStackView.addArrangedSubview(loginButton)
        loginSignupStackView.addArrangedSubview(signButton)
        mainStackView.addArrangedSubview(loginSignupStackView)
        self.view.addSubview(mainStackView)
        mainStackView.backgroundColor = .white
        view.backgroundColor = .white
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
             mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -50),
             mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 50),
             mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -50),
             passwordTextField.bottomAnchor.constraint(equalTo: loginSignupStackView.bottomAnchor,constant: -30),
           loginTextField.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 230),
             parkWayImage.heightAnchor.constraint(equalToConstant: 200)])
        
    }
    
    @objc func signupTapped() {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func loginTapped(){
        guard let username = self.loginTextField.text else {
            return
        }
        guard let password = self.passwordTextField.text else {
            return
        }
        
        userLogin(username: username, password: password, completionHandler: {
            userLoginResult in
            switch userLoginResult{
            case .success(let loginModel):
                self.data = loginModel
                
                DispatchQueue.main.async {
                    if self.data?.Result.lowercased() == "login successful"{
                        self.routeToHomeScreen()
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
        })
    }

    func routeToHomeScreen() {
        let tabBarCnt = UITabBarController()
        tabBarCnt.tabBar.backgroundColor = .white
        tabBarCnt.tabBar.tintColor = UIColor.black

        let firstVc = UINavigationController(rootViewController: ViewController())
        firstVc.title = "Home"
        let secondVc = UINavigationController(rootViewController: SettingsViewController())
        secondVc.title = "Settings"
     
         tabBarCnt.setViewControllers([firstVc, secondVc], animated: true)
         tabBarCnt.modalPresentationStyle = .fullScreen
        self.present(tabBarCnt, animated: true)
    }
}
