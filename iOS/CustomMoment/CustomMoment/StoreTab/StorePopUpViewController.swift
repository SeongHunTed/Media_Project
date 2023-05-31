//
//  StorePopUpViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/01.
//

import UIKit
import NMapsMap

class StorePopUpViewController: UIViewController {
    
    private var footerView: StorePopUpFooterView?
    
    var storeName: String
    var storeIndex: Int
    
    private var storeInfo: MainStorePopUpRequest?
    
    private var cakes: [MainCakeRequest] = []
    
    private let long = [127.035559, 126.987670, 126.838952, 126.792351]
    private let lat = [37.5268459, 37.535031, 37.5576973, 37.6493171]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        apiCall()
        configure()
    }
    
    init(storeName: String, storeIndex: Int) {
        self.storeName = storeName
        self.storeIndex = storeIndex
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API Call
    private func apiCall() {
        APIClient.shared.main.fetchStoreInfo(self.storeName) { [weak self] result in
            switch result {
            case .success(let store):
                self?.storeInfo = store
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        APIClient.shared.cake.fetchCakePerStore(self.storeName) { [weak self] result in
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
    }
    
    // MARK: - Layout Components
    
    private let dismissIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray
        view.layer.cornerRadius = 2.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // collectionview
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = false // 이부분 나중에 잘 봐
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(StorePopUpCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: StorePopUpCollectionViewCell.self))
        collectionView.register(MainCakeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MainCakeCollectionViewCell.self))
        return collectionView
    }()
   
    // MARK: - Set Up Layout
    
    private func configure() {
        self.view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.view.addSubview(dismissIndicator)
        dismissIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        dismissIndicator.widthAnchor.constraint(equalToConstant: 60).isActive = true
        dismissIndicator.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
    
    // MARK: - CollectionView Layout
    
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutenvironment -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return self.storeCompositionalLayout()
            } else {
                return self.storeCakeCompositionalLayout()
            }
        }
    }
    
    private func storeCompositionalLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(StorePopUpHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "StorePopUpHeaderView")
        collectionView.register(StorePopUpFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "StorePopUpFooterView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.45))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.06))
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        section.boundarySupplementaryItems = [header, footer]
        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, point, environment in
            self?.footerView?.pageControl.currentPage = visibleItems.last?.indexPath.row ?? 0
        }
        return section
    }
    
    private func storeCakeCompositionalLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(StorePopUpSecondHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "StorePopUpSecondHeaderView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.33))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(2), top: nil, trailing: .fixed(2), bottom: .fixed(20))
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.07))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: -extension
extension StorePopUpViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
        
        if indexPath.section == 1 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? MainCakeCollectionViewCell else { return }
            let cakeName = cell.cakeLabel.text ?? ""
            let storeName = cell.storeLabel.text ?? ""
            cakeTapped(cakeName, storeName)
        }
    }
    
    @objc func cakeTapped(_ cakeName: String, _ storeName: String) {
        print("StorePopVC :     Collection Cell Tapped")
        
        let cakeVC = MainCakeViewController(cakeName: cakeName, storeName: storeName)
        
        self.present(cakeVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        if !visibleIndexPaths.contains(indexPath) {
            return
        }
        let contentOffset = collectionView.contentOffset
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        collectionView.contentOffset = contentOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return size
    }
    
}

extension StorePopUpViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // 필수 구현 1 : 섹션의 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else {
            return cakes.count
        }
    }
    
    // 필수 구현 2 : 아이템의 쎌 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell: StorePopUpCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StorePopUpCollectionViewCell.self), for: indexPath) as? StorePopUpCollectionViewCell else { return UICollectionViewCell()
            }
            
            if let storeInfo = storeInfo {
                cell.storePopUpLayout()
                cell.configure(with: storeInfo, item: indexPath.item)
//                cell.pageControl.numberOfPages = 5
//                cell.pageControl.currentPage = 0
            } else {
                print("Nothing")
            }
            
            return cell
        } else {
            
            guard let cell: MainCakeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCakeCollectionViewCell.self), for: indexPath) as? MainCakeCollectionViewCell else { return UICollectionViewCell()
            }
            
            let cake = cakes[indexPath.item]
            cell.configure(with: cake)
            cell.cellImage.contentMode = .scaleAspectFill
            cell.layer.cornerRadius = 8
//            cell.layer.borderWidth = 0.1
//            cell.contentView.layer.borderColor = CGColor(red: 0.0, green: 0, blue: 0, alpha: 0.1)
            
            return cell
        }
        
}
    
    // dataSource Header, Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 0 {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StorePopUpHeaderView", for: indexPath) as! StorePopUpHeaderView
                header.prepare(text: "\(storeInfo?.storeName ?? "Unknown Store") " )
                return header
            } else {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StorePopUpSecondHeaderView", for: indexPath) as! StorePopUpSecondHeaderView
                return header
            }
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StorePopUpFooterView", for: indexPath) as! StorePopUpFooterView
            if let storeInfo = storeInfo {
                footer.configure(with: storeInfo, lat[storeIndex], long[storeIndex])
            }
            footerView = footer
            return footer
        default:
            return UICollectionReusableView()
        }
    }

}
