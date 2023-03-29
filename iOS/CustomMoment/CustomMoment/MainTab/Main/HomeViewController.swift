//
//  HomeViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/06.
//


//RGB    234    84    80
//HSL    0.00    0.79    0.62
//HSV    2°    66°    92°
//CMYK    0.00    0.64    0.66   0.08
//XYZ    38.55    24.4123

import UIKit

class HomeViewController: UIViewController {

    let vcIdentifier = "HomeVC"
    
    private var curPage = 0
    private let bannerImages = ["mainFirstImage", "mainSecondImage", "mainThirdImage", "mainFourthImage"]
    private let cakeImages = ["cake1", "cake2", "cake3", "cake4", "cake5", "cake6", "cake7", "cake8", "cake9"]
    
    private lazy var dataSource: [MySection] = [
        .banner([
            .init(image: self.bannerImages[0]),
            .init(image: self.bannerImages[1]),
            .init(image: self.bannerImages[2]),
            .init(image: self.bannerImages[3]),
        ]),
        .cake([
            .init(image: self.cakeImages[0]),
            .init(image: self.cakeImages[1]),
            .init(image: self.cakeImages[2]),
            .init(image: self.cakeImages[3]),
            .init(image: self.cakeImages[4]),
            .init(image: self.cakeImages[5]),
            .init(image: self.cakeImages[6]),
            .init(image: self.cakeImages[7]),
            .init(image: self.cakeImages[8]),
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpDelegate()
        imageLayout()
        bannerLayout()
        bannerTimer()
        setUpLoginButton()
    }
    
    // MARK: - Components

    
    // 컬렉션뷰 생성
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: BannerCollectionViewCell.self))
        collectionView.register(MainCakeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MainCakeCollectionViewCell.self))
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    // 컬렉션뷰를 위한 델리게이트 생성
    private func setUpDelegate() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    // 컬렉션뷰 - 배너 : 레이아웃
    private func bannerLayout() {
        collectionView.topAnchor.constraint(equalTo: self.bottomBoarder.bottomAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    // MARK: - Logo Layout
    
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
    func imageLayout() {
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
        print("HomeVC :     Logo Tapped()")
        
        if self.vcIdentifier != "HomeVC" {
            let homeVC = HomeViewController()
            self.present(homeVC, animated: true)
        }
    }
    
    // MARK: - Login Part
    
    let loginButton = UIButton(type: .system)
    
    // 로그인버튼 생성
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
        loginButton.backgroundColor = .clear
        loginButton.layer.cornerRadius = 4
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // 로그인버튼 처리
    @objc func loginButtonTapped(sender: UIButton) {
        print("HomeVC :    Login Button Tapped")
        
        let loginVC = LoginViewController()
        
        loginVC.modalTransitionStyle = .coverVertical
        loginVC.modalPresentationStyle = .automatic
        
        self.present(loginVC, animated: true, completion: nil)
    }
    
    
}

//  MARK: - CollectionView Compositional Layout

extension HomeViewController {
    
    // CollectionView Layout 생성
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutenvironment -> NSCollectionLayoutSection? in
            switch self.dataSource[sectionIndex] {
            case.banner:
                return self.bannerCompositionalLayout()
            case.cake:
                return self.cakeCompositionalLayout()
            }
        }
    }
    
    // banner compositional layout
    private func bannerCompositionalLayout() -> NSCollectionLayoutSection {
        
//        collectionView.register(MyFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MyFooterView")
        
        // item size - absolute : 고정값, estimated : 추측, fraction : 퍼센트
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        // making item with above size
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // group size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        
        // making group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
//        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
//
//        section.boundarySupplementaryItems = [footer]
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
    
    // Cake Compositional Layout
    private func cakeCompositionalLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        
        // item size - absolute : 고정값, estimated : 추측, fraction : 퍼센트
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .fractionalHeight(0.7))
        
        // making item with above size
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
        
        // group size
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: .fractionalHeight(0.4))
        
        // making group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
        section.orthogonalScrollingBehavior = .continuous
//        section.boundarySupplementaryItems = [header, footer]
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // Banner Timer action()
    private func bannerTimer() {
        let _ : Timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    
    // Banner move action
    private func bannerMove() {
        if curPage == collectionView.numberOfItems(inSection: 0) {
            collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            curPage = 0
            return
        }
        curPage += 1
        collectionView.scrollToItem(at: NSIndexPath(item: curPage, section: 0) as IndexPath, at: .right, animated: true)
    }
}

// 섹션분리
enum MySection {
    struct BannerImage {
        let image: String
    }
    struct CakeImage {
        let image: String
    }
    
    case banner([BannerImage])
    case cake([CakeImage])
}

// MARK: - 콜렉션뷰 델리겟 - 액션과 관련된 것들
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
        
        if indexPath.section == 1 {
            cakeTapped()
        }
    }
    
    @objc func cakeTapped() {
        print("HomeVC :     Collection Cell Tapped")
        
        let cakeVC = MainCakeViewController()
        
        self.present(cakeVC, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.dataSource[section] {
        case let .banner(items):
            return items.count
        case let .cake(items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.dataSource[indexPath.section] {
        case let .banner(items):
            guard let cell: BannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BannerCollectionViewCell.self), for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bannerLayout()
            cell.cellImage.image = UIImage(named: items[indexPath.item].image)
            cell.cellImage.contentMode = .scaleAspectFill
            cell.cellImage.clipsToBounds = true

            return cell
            
        case let .cake(items):
            guard let cell: MainCakeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCakeCollectionViewCell.self), for: indexPath) as? MainCakeCollectionViewCell else {
                return UICollectionViewCell()
            }
            collectionView.showsHorizontalScrollIndicator = true
            collectionView.showsVerticalScrollIndicator = false
            cell.cellImage.image = UIImage(named: items[indexPath.item].image)
            cell.cakeLayout()
            
            // cell design
            // scaleAspectFill 원본 비율 유지 + 여백없이
            cell.cellImage.contentMode = .scaleAspectFill
            cell.cellImage.clipsToBounds = true
            cell.layer.cornerRadius = 8
            cell.layer.borderWidth = 0.1
            cell.contentView.layer.borderColor = CGColor(red: 0.0, green: 0, blue: 0, alpha: 0.1)
//            cell.layer.shadowColor = UIColor.black.cgColor
//            cell.layer.shadowOpacity = 0.5
//            cell.layer.shadowRadius = 0.3
//            cell.layer.shadowOffset = CGSize(width: 1, height: 1)
//            cell.layer.masksToBounds = false
            
            return cell
        }
        
    }
    
    // dataSource Header, Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderView", for: indexPath) as! MyHeaderView
            header.prepare(text: "오늘의 추천 케이크")
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyFooterView", for: indexPath) as! MyFooterView
            footer.prepare()
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}