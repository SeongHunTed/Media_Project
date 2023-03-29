//
//  LoginViewController.swift
//  Moment
//
//  Created by Hoon on 2023/02/27.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var useremailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    var keyboardDismissTabGesture: UIGestureRecognizer = UITapGestureRecognizer(target: LoginViewController.self, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }
    
    fileprivate func config(){
        self.keyboardDismissTabGesture.delegate = self
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("MainVC - viewDidAppear() called")
        self.useremailTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SignUpViewController
        print("\(nextVC)로 넘어갑니다")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MainVC - viewWillAppear() called")
        
        // 키보드 올라가는 이벤트 받는 처리
        
    }
    
    struct User: Decodable {
        var token: String
        var isSeller: Bool
        var message: String
        
        enum CodingKeys: String, CodingKey {
            case token = "token"
            case isSeller = "is_seller"
            case message = "message"
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("MainVC - gestureRecognizer shouldReceive() called")
        
        if(touch.view?.isDescendant(of: useremailTextField) == true){
            return false
        } else if (touch.view?.isDescendant(of: passwordTextField) == true){
            return false
        } else {
            view.endEditing(true)
            return true
        }
    }
    

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let email = useremailTextField.text!
        let password = passwordTextField.text!
        
        let loginParams = [
            "email" : email as String,
            "password" : password as String
        ] as Dictionary
        
        let url = "http://custommoment.link/accounts/login"
        
        print(loginParams["email"]!)
        print(loginParams["password"]!)
        
        AF.request(url,
                   method: .post,
                   parameters: loginParams,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"]).responseDecodable(of: User.self) {
            response in
            switch response.result {
            case .success:
                print(response.value!)
                self.dismiss(animated: true)
            case .failure(let err):
                print(err)
            }
        }
    }
}
