//
//  CakeViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/29.
//

import UIKit


class CakeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageSetUp()
        collectionViewSetUp()
    }
    
    // MARK: - Variables
    
    private let cakeImages = ["cake1", "cake2", "cake3", "cake4", "cake5", "cake6", "cake7", "cake8", "cake9"]

    
    // MARK: - Top View : Logo
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
    
    // MARK: - Collection Vieww
    
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
        collectionView.register(MainCakeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MainCakeCollectionViewCell.self))
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    private func collectionViewSetUp() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.topAnchor.constraint(equalTo: self.bottomBoarder.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
}


// MARK: - CollectionView Delegate, DataSource, Layout
extension CakeViewController {
    
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutenvironment -> NSCollectionLayoutSection? in
            return self.cakeCollectionCompositionalLayout()
        }
    }
    
    private func cakeCollectionCompositionalLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(CakeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CakeStoreHeaderView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 20, trailing: 15)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.33))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
//        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: .fixed(20))
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.08))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
}

extension CakeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
        
        if indexPath.section == 0 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? MainCakeCollectionViewCell else { return }
            let cakeName = cell.cakeLabel.text ?? ""
            cakeTapped(cakeName)
        }
    }
    
    @objc func cakeTapped(_ cakeName: String) {
        print("CakeVC :     Collection Cell Tapped")
        
        let cakeVC = MainCakeViewController(cakeName: cakeName)
        
        self.present(cakeVC, animated: true)
    }
    
}


extension CakeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCakeCollectionViewCell.self), for: indexPath) as? MainCakeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cellImage.image = UIImage(named: cakeImages[indexPath.item])
        cell.cellImage.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 상위 필터 버튼과 밑에 케이크들
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cakeImages.count
    }
    
    // dataSource Header, Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CakeStoreHeaderView", for: indexPath) as! CakeHeaderView
        header.delegate = self
        return header
    }
    

}


extension CakeViewController: CalendarPopUpDelegate {
    
    func didSelectDate(_ data: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"
        let dateString = dateFormatter.string(from: data)
        if let headerView = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).first as? CakeHeaderView {
            headerView.calendarButton.setTitle(dateString, for: .normal)
        }
    }
    
    
}

extension CakeViewController: CakeHeaderViewDelegate {
    
    func showCalendarPopUp() {
        let calendarPopUpVC = CalendarPopUpViewController()
        calendarPopUpVC.modalPresentationStyle = .overFullScreen
        calendarPopUpVC.delegate = self
        present(calendarPopUpVC, animated: true, completion: nil)
    }

    func calendarButtonTapped() {
        print("CakeVC :     func calendarButtonTapped()")
        showCalendarPopUp()
    }
}
