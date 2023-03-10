//
//  HomeViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/06.
//

import UIKit

class HomeViewController: UIViewController {

    let loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpLoginButton()
    }
    
    // MARK: - Login Part
    
    func setUpLoginButton() {
        self.view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(
            equalToConstant: 80).isActive = true
        loginButton.heightAnchor.constraint(
            equalToConstant: 30).isActive = true
        loginButton.topAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        loginButton.trailingAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 4
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped(sender: UIButton) {
        print("HomeVC :    Login Button Tapped")
        
        let loginVC = LoginViewController()
        
        loginVC.modalTransitionStyle = .coverVertical
        loginVC.modalPresentationStyle = .automatic
        
        self.present(loginVC, animated: true, completion: nil)
    }
    
}
