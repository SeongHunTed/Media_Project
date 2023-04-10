//
//  SignUpViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/07.
//

import UIKit

class SignUpViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let stackView: UIStackView! = UIStackView()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.myFontM
        label.text = " 이메일"
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        label.textAlignment = .left
        return label
    }()

    let emailField: UITextField = {
        let textField = UITextField()

        textField.placeholder = " 이메일"
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont.myFontR.withSize(16)
        textField.textContentType = .emailAddress
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.myFontM
        label.text = " 비밀번호"
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        label.textAlignment = .left
        return label
    }()

    let passwordField: UITextField = {
        let textField = UITextField()

        textField.placeholder = " 비밀번호"
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        // 해당 security 속성 추가 안됨 -> 임시방편 .oneTimeCode
        // iOS 내장 암호기능을 못쓰는듯한 오류
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let checkPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.myFontM
        label.text = " 비밀번호 확인"
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        label.textAlignment = .left
        return label
    }()

    let checkPasswordField: UITextField = {
        let textField = UITextField()

        textField.placeholder = " 비밀번호 확인"
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
//        textField.textAlignment = .left
//        textField.textContentType = .oneTimeCode
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.myFontM
        label.text = " 주소"
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        label.textAlignment = .left
        return label
    }()

    let addressField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.myFontR.withSize(16)
        textField.placeholder = " 주소"
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.myFontM
        label.text = " 이름"
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        label.textAlignment = .left
        return label
    }()


    let nameField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.myFontR.withSize(16)
        textField.placeholder = " 이름"
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let digitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.myFontM
        label.text = " 전화번호"
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        label.textAlignment = .left
        return label
    }()

    let digitField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.myFontR.withSize(16)
        textField.placeholder = " 전화번호 '-'빼고 입력하세요"
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad

        return textField
    }()

    private let birthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.myFontM
        label.text = " 생년월일"
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        label.textAlignment = .left
        return label
    }()

    let birthField: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.myFontR.withSize(20.0)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 4
        
        return button
    }()

    func textFieldSetUp() {
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.checkPasswordField.delegate = self
        self.nameField.delegate = self
        self.digitField.delegate = self
        self.addressField.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSetUp()
        setUpLayout()

    }

    func setUpLayout() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(
            equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        
        stackView.axis = .vertical
        stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        stackView.spacing = 20
        
        let testImage = UIView()
        testImage.backgroundColor = stackView.backgroundColor
        testImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(checkPasswordLabel)
        stackView.addArrangedSubview(checkPasswordField)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(digitLabel)
        stackView.addArrangedSubview(digitField)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(addressField)
        stackView.addArrangedSubview(birthLabel)
        stackView.addArrangedSubview(birthField)
        stackView.addArrangedSubview(signUpButton)
        stackView.addArrangedSubview(testImage)
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

        emailLabel.topAnchor.constraint(
            equalTo: stackView.topAnchor, constant: 60).isActive = true
        emailLabel.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true

        emailField.topAnchor.constraint(
            equalTo: emailLabel.bottomAnchor, constant: 20).isActive = true
        emailField.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true
        emailField.trailingAnchor.constraint(
            equalTo: stackView.trailingAnchor, constant: -27).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        passwordLabel.topAnchor.constraint(
            equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        passwordLabel.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true

        passwordField.topAnchor.constraint(
            equalTo: passwordLabel.bottomAnchor, constant: 20).isActive = true
        passwordField.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true
        passwordField.trailingAnchor.constraint(
            equalTo: stackView.trailingAnchor, constant: -27).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        checkPasswordLabel.topAnchor.constraint(
            equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        checkPasswordLabel.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true

        checkPasswordField.topAnchor.constraint(
            equalTo: checkPasswordLabel.bottomAnchor, constant: 20).isActive = true
        checkPasswordField.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true
        checkPasswordField.trailingAnchor.constraint(
            equalTo: stackView.trailingAnchor, constant: -27).isActive = true
        checkPasswordField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        nameLabel.topAnchor.constraint(
            equalTo: checkPasswordField.bottomAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true

        nameField.topAnchor.constraint(
            equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        nameField.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true
        nameField.trailingAnchor.constraint(
            equalTo: stackView.trailingAnchor, constant: -27).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        digitLabel.topAnchor.constraint(
            equalTo: nameField.bottomAnchor, constant: 20).isActive = true
        digitLabel.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true

        digitField.topAnchor.constraint(
            equalTo: digitLabel.bottomAnchor, constant: 20).isActive = true
        digitField.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true
        digitField.trailingAnchor.constraint(
            equalTo: stackView.trailingAnchor, constant: -27).isActive = true
        digitField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        addressLabel.topAnchor.constraint(
            equalTo: digitField.bottomAnchor, constant: 20).isActive = true
        addressLabel.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true

        addressField.topAnchor.constraint(
            equalTo: addressLabel.bottomAnchor, constant: 20).isActive = true
        addressField.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true
        addressField.trailingAnchor.constraint(
            equalTo: stackView.trailingAnchor, constant: -27).isActive = true
        addressField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        birthLabel.topAnchor.constraint(
            equalTo: addressField.bottomAnchor, constant: 20).isActive = true
        birthLabel.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true
        birthLabel.trailingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: -27).isActive = true
        
        birthField.topAnchor.constraint(
            equalTo: birthLabel.bottomAnchor, constant: 20).isActive = true
        birthField.leadingAnchor.constraint(
            equalTo: stackView.leadingAnchor, constant: 27).isActive = true
        birthField.trailingAnchor.constraint(
            equalTo: stackView.trailingAnchor, constant: -27).isActive = true
        
        signUpButton.trailingAnchor.constraint(
            equalTo: stackView.trailingAnchor, constant: -27).isActive = true

    }
    
    @objc func signUpButtonTapped(sender: UIButton) {
        print("SignUpVC:    SignUp Button Tapped")
        
        let signupModel = LoginModel()
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let name = nameField.text else { return }
        guard let digit = digitField.text else { return }
        guard let address = addressField.text else { return }
        let dateFormatter = DateFormatter()
        let birth = dateFormatter.string(from: birthField.date)
        
        signupModel.signUp(email, password, name, digit, address, birth)
        
        self.dismiss(animated: true)
    }
}

extension SignUpViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
