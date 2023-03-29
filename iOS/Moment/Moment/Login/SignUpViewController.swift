//
//  SignUpViewController.swift
//  Moment
//
//  Created by Hoon on 2023/03/03.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userDigit: UITextField!
    @IBOutlet weak var userBirth: UITextField!
    @IBOutlet weak var userAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let email = userEmail.text!
        let password = userPassword.text!
        let name = userName.text!
        let digit = userDigit.text!
        let birth = userBirth.text!
        let address = userAddress.text!
        
        let signUpParams = [
            "email" : email as String,
            "password" : password as String,
            "name" : name as String,
            "digit" : digit as String,
            "birth" : birth as String,
            "address" : address as String
        ] as Dictionary
        
        let url = "http://custommoment.link/accounts/signup"
        
        print(signUpParams["email"]!)
        print(signUpParams["password"]!)
        
        AF.request(url,
                   method: .post,
                   parameters: signUpParams,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"]).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response.value!)
                self.viewWillDisappear(true)
            case .failure(let err):
                print(err)
            }
        }
    }

}
