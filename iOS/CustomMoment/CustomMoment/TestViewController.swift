//
//  TestViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/08.
//

import UIKit

class TestViewController: UIViewController {

    private let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    private let appiconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appicon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "아이디"
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private let loginIdTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.placeholder = "아이디를 입력해주세요"
        textField.textAlignment = .left
        textField.textContentType = .emailAddress
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .always
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "비밀번호"
        label.textColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private let loginPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.isSecureTextEntry = true
        textField.textAlignment = .left
        textField.clearButtonMode = .always
        return textField
    }()
    
    private let idTextFieldDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    private let passwordTextFieldDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "login"), for: .normal)
        button.addTarget(self, action: #selector(loginButtonClicked(sender:)),
                         for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var backBarButtonItem: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self,
                         action: #selector(dismissThisViewController),
                         for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }()
    
//    private let indicatorView: LoadingIndicatorView = {
//        let view = LoadingIndicatorView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.noticeLabel.text = ""
//        return view
//    }()
//
//    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleShowKeyboard),
                                               name: UIWindow.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleHideKeyboard),
                                               name: UIWindow.keyboardWillHideNotification,
                                               object: nil)
            
        self.loginIdTextField.delegate = self
        self.loginPasswordTextField.delegate = self
        self.tapGesture.delegate = self
        
        setupNavigationBar()
        setUpLayout()
    }

    private func setupNavigationBar() {
        
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    @objc func loginButtonClicked(sender: UIButton) {
        let alertController = UIAlertController(title: "알림",
                                                message: "아이디 혹은 비밀번호를 확인해주세요",
                                                preferredStyle: .alert)
        
        let successButton = UIAlertAction(title: "확인",
                                          style: .cancel,
                                          handler: nil)
        alertController.addAction(successButton)
        
//        guard let email = loginIdTextField.text,
//            let password = loginPasswordTextField.text else { return }
//
//        guard !email.isEmpty || !password.isEmpty else {
//            self.present(alertController, animated: true, completion: nil)
//            self.indicatorView.deactivateIndicatorView()
//
//            return
//        }
//        self.indicatorView.activateIndicatorView()
//        authService.signIn(with: email, password: password)
//            .flatMapLatest { [weak self] (uid) -> Observable<(String, String)> in
//                guard let self = self else { return .empty() }
//                return Observable.combineLatest(Observable.just(uid),
//                                                self.pushManager.fetchToken())
//            }
//            .flatMapLatest { [weak self] (result) -> Observable<(String, URLResponseProtocol)> in
//                guard let self = self else { return .error(APIError.notDefined) }
//                return Observable.combineLatest(Observable.just(result.0),
//                                                self.userInfoService.updatePushToken(uid: result.0, token:      result.1))
//            }
//            .flatMapLatest { [weak self] (result) -> Observable<UserInformation> in
//                guard let self = self else { return .error(APIError.notDefined) }
//                return self.userInfoService.fetchUserInfo(path: "users/\(result.0)")
//            }
//            .flatMapLatest { [weak self] (userInfo) -> Observable<Bool> in
//                guard let self = self else { return .error(APIError.notDefined) }
//                UserInfoManager.shared.setUserInfomation(userInfo)
//                return self.adminService.fetchAdminList()
//                    .flatMapLatest { (list) -> Observable<Bool> in
//                        let isAdmin = list
//                            .filter { $0 == userInfo.userUid }
//                            .isEmpty == false
//                        return .just(isAdmin)
//                    }
//            }
//            .asObservable()
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] isAdmin in
//                self?.indicatorView.deactivateIndicatorView()
//                let mainTabBarController: MainTabBarController = MainTabBarController(shouldShowDefaultUserInfoView: false)
//                let adminViewController = AdminTabBarController()
//                UIApplication.shared.keyWindow?.rootViewController = isAdmin ? adminViewController : mainTabBarController
//                }, onError: { [weak self] _ in
//                    self?.indicatorView.deactivateIndicatorView()
//                    self?.present(alertController, animated: true, completion: nil)
//            })
//            .disposed(by: disposeBag)
    }

    func setUpLayout () {
        view.backgroundColor = .white
        
//        view.addSubview(indicatorView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(appiconImageView)
        contentView.addSubview(idLabel)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(idTextFieldDivider)
        contentView.addSubview(loginButton)
        contentView.addSubview(loginIdTextField)
        contentView.addSubview(loginPasswordTextField)
        contentView.addSubview(passwordTextFieldDivider)
        
        contentView.addGestureRecognizer(tapGesture)
        
//        indicatorView.deactivateIndicatorView()
//        indicatorView.widthAnchor.constraint(
//            greaterThanOrEqualToConstant: 180).isActive = true
//        indicatorView.heightAnchor.constraint(
//            greaterThanOrEqualToConstant: 50).isActive = true
//        indicatorView.centerYAnchor.constraint(
//            equalTo: view.centerYAnchor).isActive = true
//        indicatorView.centerXAnchor.constraint(
//            equalTo: view.centerXAnchor).isActive = true
        
        scrollView.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(
            equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(
            equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(
            equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(
            equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(
            equalTo: scrollView.widthAnchor).isActive = true
        
        appiconImageView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 110).isActive = true
        appiconImageView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 27).isActive = true
        
        idLabel.topAnchor.constraint(
            equalTo: appiconImageView.bottomAnchor,
            constant: 40).isActive = true
        idLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 27).isActive = true
        idLabel.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -27).isActive = true
        idLabel.heightAnchor.constraint(
            equalToConstant: 24).isActive = true
        idLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        loginIdTextField.topAnchor.constraint(
            equalTo: idLabel.bottomAnchor,
            constant: 8).isActive = true
        loginIdTextField.widthAnchor.constraint(
            equalTo: idLabel.widthAnchor).isActive = true
        loginIdTextField.heightAnchor.constraint(
            equalToConstant: 36).isActive = true
        loginIdTextField.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
   
        idTextFieldDivider.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        idTextFieldDivider.widthAnchor.constraint(
            equalTo: loginIdTextField.widthAnchor).isActive = true
        idTextFieldDivider.topAnchor.constraint(
            equalTo: loginIdTextField.bottomAnchor,
            constant: 8).isActive = true
        idTextFieldDivider.heightAnchor.constraint(
            equalToConstant: 1).isActive = true
        
        passwordLabel.topAnchor.constraint(
            equalTo: idTextFieldDivider.bottomAnchor,
            constant: 24).isActive = true
        passwordLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 27).isActive = true
        passwordLabel.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -27).isActive = true
        passwordLabel.heightAnchor.constraint(
            equalToConstant: 24).isActive = true
        passwordLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        loginPasswordTextField.topAnchor.constraint(
            equalTo: passwordLabel.bottomAnchor,
            constant: 8).isActive = true
        loginPasswordTextField.widthAnchor.constraint(
            equalTo: passwordLabel.widthAnchor).isActive = true
        loginPasswordTextField.heightAnchor.constraint(
            equalToConstant: 36).isActive = true
        loginPasswordTextField.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        passwordTextFieldDivider.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        passwordTextFieldDivider.topAnchor.constraint(
            equalTo: loginPasswordTextField.bottomAnchor,
            constant: 8).isActive = true
        passwordTextFieldDivider.heightAnchor.constraint(
            equalToConstant: 1).isActive = true
        passwordTextFieldDivider.widthAnchor.constraint(
            equalTo: loginPasswordTextField.widthAnchor).isActive = true
        
        loginButton.topAnchor.constraint(
            equalTo: passwordTextFieldDivider.bottomAnchor,
            constant: 100).isActive = true
        loginButton.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        loginButton.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 27).isActive = true
        loginButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -27).isActive = true
        loginButton.heightAnchor.constraint(
            equalToConstant: 70).isActive = true
        loginButton.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -162).isActive = true
    }
    
    @objc private func dismissThisViewController() {
        dismiss(animated: true)
    }
    
    @objc func handleShowKeyboard(notification: NSNotification) {
        guard let keyboardFrame =
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        scrollView.contentOffset.y = keyboardFrame.height
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
            self?.scrollView.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func handleHideKeyboard(notification: NSNotification) {
        scrollView.contentOffset.y = 0
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
            self?.scrollView.layoutIfNeeded()
        }, completion: nil)
    }
}

extension TestViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TestViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }
}
