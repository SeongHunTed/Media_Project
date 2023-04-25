//
//  LoginViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/06.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    let emailField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Email을 입력하세요"
        textField.becomeFirstResponder()
        textField.textContentType = .emailAddress
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let passwordField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "PW를 입력하세요"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        return stackView
    }()
    
    func setUpStackView() {
        
        self.view.addSubview(self.stackView)
        
        let stackContents: [UIView] = [emailField, passwordField, loginButton, signUpButton]
        
        // 코드 개선 방향 찾아야함
        stackView.addArrangedSubview(stackContents[0])
        stackView.addArrangedSubview(stackContents[1])
        stackView.addArrangedSubview(stackContents[2])
        stackView.addArrangedSubview(stackContents[3])
        
        stackView.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        emailField.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        passwordField.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        loginButton.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        signUpButton.heightAnchor.constraint(
            equalToConstant: 50).isActive = true
        
        emailField.widthAnchor.constraint(
            equalTo: emailField.heightAnchor, multiplier: 5.0).isActive = true
        passwordField.widthAnchor.constraint(
            equalTo: passwordField.heightAnchor, multiplier: 5.0).isActive = true
        loginButton.widthAnchor.constraint(
            equalTo: loginButton.heightAnchor, multiplier: 5.0).isActive = true
        signUpButton.widthAnchor.constraint(
            equalTo: signUpButton.heightAnchor, multiplier: 5.0).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpStackView()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setKeyboardObserver()
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        killKeyboardObserver()
    }
    
    
    // MARK: - Keyboard Event
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func killKeyboardObserver() {
        keyboardWillHide()
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
//    키보드 높이만큼 view의 y를 올려줌
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 1, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight/2)
            })
        }
    }

//    키보드 높이만큼 view의 y를 내려줌
    @objc private func keyboardWillHide() {
        self.view.transform = .identity
    }
    
    // 화면 터치시 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
             self.view.endEditing(true)
       }
    
    // return 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func loginButtonTapped(_ sender: UIButton) {
        print("LoginVC :    Login Button Tapped")
        
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        let loginRequest = LoginRequest(
            email: email,
            password: password
        )
        
        APIClient.shared.auth.login(loginRequest) { [weak self] result in
            switch result {
            case .success(let loginResponse):
                APIClient.shared.authToken = loginResponse.token
                APIClient.shared.isSeller = loginResponse.isSeller
                self?.killKeyboardObserver()
                NotificationCenter.default.post(name: .didLoginSuccess, object: nil)
                
                let defualts = UserDefaults.standard
                defualts.set(true, forKey: "isLoggedIn")
                defualts.set(email, forKey: "email")
                defualts.set(password, forKey: "password")
                self?.dismiss(animated: true)
            case .failure:
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "확인", message: "ID, PW를 다시 확인하세요", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    @objc func signUpButtonTapped(_ sender: UIButton) {
        print("LoginVC :    SignUp Button Tapped")
        
        let signUpVC = SignUpViewController()
        
        signUpVC.modalTransitionStyle = .coverVertical
        signUpVC.modalPresentationStyle = .automatic
        
        self.present(signUpVC, animated: true, completion: nil)
    }
}
