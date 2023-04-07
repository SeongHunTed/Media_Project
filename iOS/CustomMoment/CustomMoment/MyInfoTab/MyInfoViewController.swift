//
//  MyInfoViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/29.
//

import UIKit

class MyInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        imageSetUp()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFit
    }
    
    // MARK: - Variables
    
    let profile = "ted"
    let userName = "김성훈"
    let data = ["장바구니", "구매내역", "회원정보", "test"]
    let cellImage = ["cart", "creditcard", "person", "pencil"]
    
    // MARK: - Profile
    
    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = userName + " 님"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: profile)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemRed.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.layer.cornerRadius = 4
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.8).cgColor
        stackView.addSubview(profileImage)
        stackView.addSubview(profileLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - logo
    private lazy var logo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(homeButtonTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bottomBoarder = UIImageView(frame: CGRect(x: 0, y: 96.6, width: self.view.frame.width, height: 0.5))
    
    // 로고 터치 처리
    func imageSetUp() {
        self.view.addSubview(logo)
        self.view.addSubview(bottomBoarder)
        
        logo.topAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        logo.centerXAnchor.constraint(
            equalTo: self.view.centerXAnchor).isActive = true
        logo.widthAnchor.constraint(
            equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        logo.heightAnchor.constraint(
            equalTo: self.view.heightAnchor, multiplier: 0.045).isActive = true
        logo.contentMode = .scaleAspectFit
        
        bottomBoarder.backgroundColor = .black.withAlphaComponent(0.6)
        bottomBoarder.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    }
    
    @objc func homeButtonTapped() {
        print("CakeVC :     Logo Tapped()")
        
        tabBarController?.selectedIndex = 0
    }
    
    // MARK: - TableView
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Configure
    
    private func configure() {
        
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: bottomBoarder.bottomAnchor, constant: 20).isActive = true
//        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        profileImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        
        profileLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20).isActive = true
        profileLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyInfoTableViewCell.self, forCellReuseIdentifier: "MyInfoTableViewCell")
    }
}

extension MyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoTableViewCell", for: indexPath) as? MyInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.label.text = data[indexPath.row]
        cell.cellImageView.image = UIImage(systemName: cellImage[indexPath.row])?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // UITableView의 셀을 누르면 해당 기능에 맞는 화면으로 이동합니다.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // "사진" 버튼을 눌렀을 때
            // 새로운 UIViewController를 생성하여 present 합니다.
            let cartVC = CartViewController("장바구니")
            cartVC.modalTransitionStyle = .coverVertical
            cartVC.modalPresentationStyle = .fullScreen
            self.present(cartVC, animated: true)
        case 1:
            // "장바구니" 버튼을 눌렀을 때
            let orderVC = OrderViewController("구매내역")
            orderVC.modalTransitionStyle = .coverVertical
            orderVC.modalPresentationStyle = .fullScreen
            self.present(orderVC, animated: true)
        case 2:
            // "구매내역" 버튼을 눌렀을 때
            let memberInfoVC = MemberInfoViewController("회원정보")
            memberInfoVC.modalTransitionStyle = .coverVertical
            memberInfoVC.modalPresentationStyle = .fullScreen
            self.present(memberInfoVC, animated: true)
        default:
            break
        }
    }
}
