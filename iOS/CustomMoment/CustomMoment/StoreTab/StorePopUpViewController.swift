//
//  StorePopUpViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/01.
//

import UIKit
import NMapsMap

class StorePopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configure()
        
    }
    
    // MARK: - Layout Components
    
    let storeDetailImages = ["detail1", "detail2", "detail3", "detail4"]
    let cakeImages = ["cake1", "cake2", "cake3", "cake4", "cake5", "cake6", "cake7", "cake8", "cake9"]
    
    // collectionview
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
        collectionView.isScrollEnabled = true
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
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.07))
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        section.boundarySupplementaryItems = [header, footer]
        return section
    }
    
    private func storeCakeCompositionalLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(StorePopUpSecondHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "StorePopUpSecondHeaderView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        
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

// MARK: extension
extension StorePopUpViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
        
        if indexPath.section == 1 {
            cakeTapped()
        }
    }
    
    @objc func cakeTapped() {
        print("StorePopVC :     Collection Cell Tapped")
        
        let cakeVC = MainCakeViewController()
        
        self.present(cakeVC, animated: true)
    }
    
}

extension StorePopUpViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // 필수 구현 1 : 섹션의 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return storeDetailImages.count
        } else {
            return cakeImages.count
        }
    }
    
    // 필수 구현 2 : 아이템의 쎌 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell: StorePopUpCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StorePopUpCollectionViewCell.self), for: indexPath) as? StorePopUpCollectionViewCell else { return UICollectionViewCell()
            }
            
            cell.configure()
            cell.cellImage.image = UIImage(named: storeDetailImages[indexPath.item])
            
            return cell
        } else {
            
            guard let cell: MainCakeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCakeCollectionViewCell.self), for: indexPath) as? MainCakeCollectionViewCell else { return UICollectionViewCell()
            }
            
            cell.cellImage.image = UIImage(named: cakeImages[indexPath.item])
            cell.cakeLayout()
            
            cell.cellImage.contentMode = .scaleAspectFill
            cell.cellImage.clipsToBounds = true
            cell.layer.cornerRadius = 8
            cell.layer.borderWidth = 0.1
            cell.contentView.layer.borderColor = CGColor(red: 0.0, green: 0, blue: 0, alpha: 0.1)
            
            return cell
        }
        
}
    
    // dataSource Header, Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 0 {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StorePopUpHeaderView", for: indexPath) as! StorePopUpHeaderView
                header.prepare(text: "딥 다이브")
                return header
            } else {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StorePopUpSecondHeaderView", for: indexPath) as! StorePopUpSecondHeaderView
                return header
            }
        case UICollectionView.elementKindSectionFooter:
            print("Working FooterView")
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StorePopUpFooterView", for: indexPath) as! StorePopUpFooterView
//            footer.prepare()
            return footer
        default:
            return UICollectionReusableView()
        }
    }

}
