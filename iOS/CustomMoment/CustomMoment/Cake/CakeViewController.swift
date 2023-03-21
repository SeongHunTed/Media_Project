//
//  CakeViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/20.
//

import UIKit

class CakeViewController: UIViewController {
    
    let vcIdentifier = "CakeVC"
    
    let cakeImages = ["cake1", "cake2", "cake3", "cake4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setDelegate()
        configure()
    }
    
    // delegate 설정
    private func setDelegate() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    // MARK: - Components
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SubCakeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SubCakeCollectionViewCell.self))
        return collectionView
    }()
    
    // collectionview layour
    private func configure() {
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layourenvironment -> NSCollectionLayoutSection? in
            return self.cakeBannerCompositionalLayout()
        }
    }
    
    private func cakeBannerCompositionalLayout() -> NSCollectionLayoutSection {
        
        // header 구현 -> 기존 헤더 사용
        
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.07))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
}


// MARK: extension
extension CakeViewController: UICollectionViewDelegate {
    
}

extension CakeViewController: UICollectionViewDataSource {
    
    // 필수 구현 1 : 섹션의 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cakeImages.count
    }
    
    // 필수 구현 2 : 아이템의 쎌 설정(?)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: SubCakeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SubCakeCollectionViewCell.self), for: indexPath) as? SubCakeCollectionViewCell else { return UICollectionViewCell()
        }
        
        cell.configure()
        cell.cellImage.image = UIImage(named: cakeImages[indexPath.item])
        
        return cell
    }
    
    // dataSource Header, Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderView", for: indexPath) as! MyHeaderView
            header.prepare(text: "월선화 > 강릉바다떡케이크")
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
