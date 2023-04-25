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
    
    private var footerView: MyFooterView?
    private let bannerImages = ["banner1", "banner2", "banner3"]
    
    private var cakes: [MainCakeRequest] = []
    private var stores: [MainStoreRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpDelegate()
        apiCall()
        logoLayout()
        bannerLayout()
    }
    
    // MARK: - API Call
    
    private func apiCall() {
        APIClient.shared.main.fetchMainCake{ [weak self] result in
            switch result {
            case .success(let cakes):
                self?.cakes = cakes
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        APIClient.shared.main.fetchMainStore{ [weak self] result in
            switch result {
            case .success(let stores):
                self?.stores = stores
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
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
        collectionView.register(StoreCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: StoreCollectionViewCell.self))
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
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.bottomBoarder.bottomAnchor).isActive = true
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
    func logoLayout() {
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
}
//  MARK: - CollectionView Compositional Layout

extension HomeViewController {
    
    // CollectionView Layout 생성
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutenvironment -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return self.bannerCompositionalLayout()
            } else if sectionIndex == 1 {
                return self.cakeCompositionalLayout()
            } else {
                return self.storeCompositionalLayout()
            }
        }
    }
    
    // banner compositional layout
    private func bannerCompositionalLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(MyFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MyFooterView")
        
        // item size - absolute : 고정값, estimated : 추측, fraction : 퍼센트
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        // making item with above size
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // group size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25))
        
        // making group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.05))
        
        let section = NSCollectionLayoutSection(group: group)
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)

        section.boundarySupplementaryItems = [footer]
        section.orthogonalScrollingBehavior = .paging
        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, point, environment in
            self?.footerView?.bannerPageControl.currentPage = visibleItems.last?.indexPath.row ?? 0
        }
        
        return section
    }
    
    // Cake Compositional Layout
    private func cakeCompositionalLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        
        // item size - absolute : 고정값, estimated : 추측, fraction : 퍼센트
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .fractionalHeight(0.85))
        
        // making item with above size
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 2, trailing: 10)
        
        // group size
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: .fractionalHeight(0.3))
        
        // making group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40.0))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func storeCompositionalLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        
        // item size - absolute : 고정값, estimated : 추측, fraction : 퍼센트
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        // making item with above size
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10)
        
        // group size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(0.4))
        
        // making group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40.0))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

// MARK: - 콜렉션뷰 델리겟 - 액션과 관련된 것들
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
        
        if indexPath.section == 1 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? MainCakeCollectionViewCell else { return }
            let cakeName = cell.cakeLabel.text ?? ""
            let storeName = cell.storeLabel.text ?? ""
            cakeTapped(cakeName, storeName)
        } else if indexPath.section == 2 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? StoreCollectionViewCell else { return }
            let storeName = cell.storeLabel.text ?? ""
            storeTapped(storeName, indexPath.item)
        }
    }
    
    @objc func cakeTapped(_ cakeName: String, _ storeName: String) {
        print("HomeVC :     Collection Cell Tapped")
        
        let cakeVC = MainCakeViewController(cakeName: cakeName, storeName: storeName)
        self.present(cakeVC, animated: true)
    }
    
    @objc func storeTapped(_ storeName: String, _ storeIndex: Int) {
        
        let storeVC = StorePopUpViewController(storeName: storeName, storeIndex: storeIndex)
        self.present(storeVC, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return bannerImages.count
        } else if section == 1 {
            return cakes.count
        } else {
            return stores.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell: BannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BannerCollectionViewCell.self), for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bannerLayout()
            cell.cellImage.image = UIImage(named: bannerImages[indexPath.row])
            cell.cellImage.contentMode = .scaleAspectFill
            cell.cellImage.clipsToBounds = true
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell: MainCakeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCakeCollectionViewCell.self), for: indexPath) as? MainCakeCollectionViewCell else {
                return UICollectionViewCell()
            }
            collectionView.showsHorizontalScrollIndicator = true
            collectionView.showsVerticalScrollIndicator = false
            let cake = cakes[indexPath.item]
            cell.configure(with: cake)
            cell.cellImage.contentMode = .scaleAspectFill
            return cell
        } else {
            guard let cell: StoreCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StoreCollectionViewCell.self), for: indexPath) as? StoreCollectionViewCell else {
                return UICollectionViewCell()
            }
            collectionView.showsHorizontalScrollIndicator = true
            collectionView.showsVerticalScrollIndicator = false
            let store = stores[indexPath.item]
            cell.storeLayout()
            cell.configure(with: store)
            cell.cellImage.contentMode = .scaleAspectFill
//            cell.cellImage.layer.cornerRadius = 0
            
            return cell
        }
    }
    
    // dataSource Header, Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderView", for: indexPath) as! MyHeaderView
            if indexPath.section == 1 {
                header.prepare(text: "오늘의 추천 케이크")
            } else if indexPath.section == 2 {
                header.prepare(text: "지금 HOT한 스토어")
            }
//            let borderLayer = CALayer()
//            borderLayer.frame = CGRect(x: 0, y: header.frame.size.height - 1, width: header.frame.size.width, height: 0.7)
//            borderLayer.backgroundColor = UIColor.gray.withAlphaComponent(0.75).cgColor
//            header.layer.addSublayer(borderLayer)
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyFooterView", for: indexPath) as! MyFooterView
            footer.bannerPageControl.numberOfPages = bannerImages.count
            footerView = footer
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}
