//
//  HomeViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/06.
//

import UIKit

class HomeViewController: UIViewController {

    let loginButton = UIButton(type: .system)
    
    let images = ["mainFirstImage", "mainSecondImage", "mainThirdImage", "mainFourthImage"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpDelegate()
        bannerLayout()
        imageLayout()
        setUpLoginButton()
    }
    
    // MARK: - Components
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MainCollectionViewCell.self))
        return collectionView
    }()
    
    func setUpDelegate() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    func bannerLayout() {
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    // MARK: - Logo Layout
    
    private let logo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func imageLayout() {
        self.view.addSubview(logo)
        logo.topAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        logo.centerXAnchor.constraint(
            equalTo: self.view.centerXAnchor).isActive = true
        logo.widthAnchor.constraint(
            equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        logo.heightAnchor.constraint(
            equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        logo.contentMode = .scaleAspectFit
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

// 콜렉션뷰 델리겟 - 액션과 관련된 것들
extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCollectionViewCell.self), for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        // 향후에 여러가지 설정 이미지 넣어야함
        
        cell.bannerImage.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
}

//  MARK: - CollectionView Compositional Layout

extension HomeViewController {
    
//    private func getLayout() -> UICollectionViewLayout {
//        return UICollectionViewCompositionalLayout { sectionIndex, layoutenvironment -> NSCollectionLayoutSection? inputView
//            switch self.
//            
//        }
//    }
    
    // Compositional layout
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        
        // Compositional layout create
        let layout = UICollectionViewCompositionalLayout {
            // input : tuple("key" : "value", "key" : "value") -> return NSCollectionLayoutSection
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // item size - absolute : 고정값, estimated : 추측, fraction : 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            // making item with above size
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            // group size
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
            
            // making group
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // making section
            let section = NSCollectionLayoutSection(group: group)
             section.orthogonalScrollingBehavior = .groupPaging
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
            return section
        }
        
        return layout
    }
}

enum MySection {
    struct BannerImage {
        let image: UIImage
    }
    struct CakeImage {
        let image: UIImage
    }
    
    case banner([BannerImage])
    case cake([CakeImage])
}
