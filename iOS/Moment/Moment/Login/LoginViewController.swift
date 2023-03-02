//
//  LoginViewController.swift
//  Moment
//
//  Created by Hoon on 2023/02/27.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var useremailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        useremailTextField.text = "ID"
        passwordTextField.text = "PASSWORD"
        useremailTextField.textColor = UIColor.darkGray
        passwordTextField.textColor = UIColor.darkGray
    }
    

    @IBAction func textFieldTouched(_ sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let email = useremailTextField.text
        let password = passwordTextField.text
        
        let user = User(email: email!, password: password!)
        
        login(user: user, completion: <#(Result<String, Error>) -> Void#>)
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
