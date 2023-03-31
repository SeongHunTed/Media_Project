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
        configureMap()
        
    }
    
    // MARK: - Layout Components
    
    let storeDetailImages = ["detail1", "detail2", "detail3", "detail4"]
    
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
        return collectionView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "⏰ 영업 : 수~일 10:00~17:00/ 휴무 : 월, 화"
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let digitLabel: UILabel = {
        let label = UILabel()
        label.text = "☎️ 02-222-5555"
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "🚗 서울시 관악구 미성3길 20 1층"
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Naver Maps
    
    // Map Object
    private lazy var naverMapView: NMFMapView = {
        let mapFrame = CGRect(x: self.view.bounds.width*0.05, y: self.view.bounds.height*0.11, width: self.view.bounds.width*0.9, height: self.view.bounds.height*0.3)
        let map = NMFMapView(frame: mapFrame)
        map.layer.borderColor = UIColor.systemGray4.cgColor
        map.layer.borderWidth = 0.5
        return map
    }()
    
    // Map Camera Position
    private let cameraUpdate: NMFCameraUpdate = {
        let camera = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.5670135, lng: 126.9783740), zoomTo: 15.0)
        return camera
    }()
    
    // Set Store's Marker
    private let marker: NMFMarker = {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
        return marker
    }()
    
    private func configureMap() {
        naverMapView.moveCamera(cameraUpdate)
        marker.mapView = naverMapView
    }
    
    // MARK: - Set Up Layout
    
    private func configure() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        stackView.addSubview(timeLabel)
        stackView.addSubview(digitLabel)
        stackView.addSubview(addressLabel)
        stackView.addSubview(naverMapView)
        
        timeLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
        
        digitLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10).isActive = true
        digitLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: digitLabel.bottomAnchor, constant: 10).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
        
//        print(addressLabel.frame.origin, addressLabel.bounds.origin)
//        print(stackView.frame.width, stackView.frame.height)
//
//        naverMapView.frame(forAlignmentRect: CGRect(x: addressLabel.frame.origin.x, y: addressLabel.frame.origin.y + 20, width: stackView.frame.width * 0.8, height: stackView.frame.height * 0.3))
//        naverMapView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20).isActive = true
//        naverMapView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
//        naverMapView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20).isActive = true
//        naverMapView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    // MARK: - CollectionView Layout
    
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutenvironment -> NSCollectionLayoutSection? in
            return self.storeCompositionalLayout()
        }
    }
    
    private func storeCompositionalLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.13))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: extension
extension StorePopUpViewController: UICollectionViewDelegate {
    
}

extension StorePopUpViewController: UICollectionViewDataSource {
    
    // 필수 구현 1 : 섹션의 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeDetailImages.count
    }
    
    // 필수 구현 2 : 아이템의 쎌 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: StorePopUpCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StorePopUpCollectionViewCell.self), for: indexPath) as? StorePopUpCollectionViewCell else { return UICollectionViewCell()
        }
        
        cell.configure()
        cell.cellImage.image = UIImage(named: storeDetailImages[indexPath.item])
        
        return cell
    }
    
    // dataSource Header, Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderView", for: indexPath) as! MyHeaderView
            header.prepare(text: "딥 다이브")
            return header
//        case UICollectionView.elementKindSectionFooter:
//            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyFooterView", for: indexPath) as! MyFooterView
//            footer.prepare()
//            return footer
        default:
            return UICollectionReusableView()
        }
    }

}
