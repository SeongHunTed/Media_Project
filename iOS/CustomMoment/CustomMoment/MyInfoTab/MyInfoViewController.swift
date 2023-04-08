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
        collectionViewSetUp()
    }
    
    
    // MARK: - Variables
    
    let loginSuccess = true
    
    let profile = "ted"
    let userName = "김성훈"
    let userEmail = "4047ksh@naver.com"
    let data = ["장바구니", "구매내역", "회원정보", "test"]
    let cellImage = ["cart", "creditcard", "person", "pencil"]
    
    let collectionImages = ["newspaper", "gift", "wonsign.circle", "ticket"]
    let collectionTitle = ["공지사항", "이벤트", "구매내역", "쿠폰"]
    
    let cake = ["cake6"]
    
    // MARK: - Profile
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = userName + " 님"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = userEmail
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("내 정보", for: .normal)
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func profileButtonTapped() {
        let memberInfoVC = MemberInfoViewController()
        
        self.present(memberInfoVC, animated: true)
    }

    private lazy var profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.8).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        bottomBoarder.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    // MARK: - Login Part
    
    let loginButton = UIButton(type: .system)
    
    // 로그인버튼 처리
    @objc func loginButtonTapped(sender: UIButton) {
        print("HomeVC :    Login Button Tapped")
        
        let loginVC = LoginViewController()
        
        loginVC.modalTransitionStyle = .coverVertical
        loginVC.modalPresentationStyle = .automatic
        
        self.present(loginVC, animated: true, completion: nil)
    }
    
    // MARK: - Collection Vieww
    
    // 컬렉션뷰 생성
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
        collectionView.isScrollEnabled = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MyInfoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MyInfoCollectionViewCell.self))
        collectionView.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CartCollectionViewCell.self))
        return collectionView
    }()
    
    private func collectionViewSetUp() {
        self.view.addSubview(collectionView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.topAnchor.constraint(equalTo: self.profileView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    // MARK: - Configure
    
    private func configure() {
        
        self.view.addSubview(profileView)
        
        profileView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10).isActive = true
        profileView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        if loginSuccess == false {
            loginFailedConfigure()
        } else {
            loginSuceesConfigure()
        }
        
    }
    
    private func loginSuceesConfigure() {
        
        profileView.addSubview(nameLabel)
        profileView.addSubview(idLabel)
        profileView.addSubview(profileButton)
        
        idLabel.centerXAnchor.constraint(equalTo: profileView.centerXAnchor).isActive = true
        idLabel.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        
        nameLabel.bottomAnchor.constraint(equalTo: idLabel.topAnchor,constant: -2).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.profileView.centerXAnchor).isActive = true
        
        profileButton.centerXAnchor.constraint(equalTo: profileView.centerXAnchor).isActive = true
        profileButton.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 5).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func loginFailedConfigure() {
        
        profileView.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(
            equalToConstant: 80).isActive = true
        loginButton.heightAnchor.constraint(
            equalToConstant: 30).isActive = true
        loginButton.centerXAnchor.constraint(
            equalTo: self.profileView.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: self.profileView.centerYAnchor).isActive = true
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 4
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
    }
}

// MARK: - CollectionView Delegate, DataSource, Layout

extension MyInfoViewController {
    
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutenvironment -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return self.infoCollectionCompositionalLayout()
            } else {
                return self.cartCollectionCompositionalLayout()
            }
        }
    }
    
    private func infoCollectionCompositionalLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.15))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(10), trailing: nil, bottom: .fixed(10))
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func cartCollectionCompositionalLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.23))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(10), trailing: nil, bottom: .fixed(10))
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

extension MyInfoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.item {
            case 0:
                let noticeVC = NoticeViewController()
                self.present(noticeVC, animated: true)
            case 1:
                let eventVC = EventViewController()
                self.present(eventVC, animated: true)
            case 2:
                let orderVC = OrderViewController()
                self.present(orderVC, animated: true)
            case 3:
                let couponVC = CouponViewController()
                self.present(couponVC, animated: true)
            default:
                print("Nothing happens")
            }
        }
    }
    
}

extension MyInfoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return collectionImages.count
        } else {
            return cake.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if loginSuccess == false {
            return 1
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyInfoCollectionViewCell.self), for: indexPath) as? MyInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.cellImage.image = UIImage(systemName: collectionImages[indexPath.row])
            cell.cellImage.contentMode = .scaleAspectFill
            cell.cellTitle.text = collectionTitle[indexPath.row]
            cell.infoLayout()
            
            cell.cellImage.contentMode = .scaleAspectFill
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CartCollectionViewCell.self), for: indexPath) as? CartCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.cellImage.image = UIImage(named: cake[indexPath.row])
            cell.cartLayout()
            cell.layer.cornerRadius = 8
            cell.layer.borderWidth = 0.5
            cell.contentView.layer.borderColor = UIColor.red.withAlphaComponent(0.8).cgColor
            return cell
        }
        
    }
    
    // dataSource Header, Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderView", for: indexPath) as! MyHeaderView
            header.prepare(text: " 🍰 장바구니")
            let borderLayer = CALayer()
            borderLayer.frame = CGRect(x: 0, y: header.frame.size.height - 1, width: header.frame.size.width, height: 1)
            borderLayer.backgroundColor = UIColor.gray.withAlphaComponent(0.75).cgColor
            header.layer.addSublayer(borderLayer)
                    
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyFooterView", for: indexPath) as! MyFooterView
            footer.bannerPageControl.numberOfPages = collectionView.numberOfItems(inSection: 0)
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}
