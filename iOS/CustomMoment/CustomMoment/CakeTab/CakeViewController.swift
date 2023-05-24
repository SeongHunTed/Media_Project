//
//  CakeViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/29.
//

import UIKit


class CakeViewController: UIViewController {
    
    private var hasMoreData = true
    private var filter: String?
    private var cakes: [MainCakeRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        firstApiCall()
        imageSetUp()
        collectionViewSetUp()
        
    }
    
    // MARK: - API Call
    
    private func firstApiCall() {
        APIClient.shared.cake.fetchCakeTapCake(0) { [weak self] result in
            switch result {
            case .success(let cakes):
                self?.cakes = cakes
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    if cakes.count < 10 {
                        self?.hasMoreData = false
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func filterApiCall() {
        APIClient.shared.cake.fetchFilterCake(0) { [weak self] result in
            switch result {
            case .success(let cakes):
                self?.cakes = cakes
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    if cakes.count < 10 {
                        self?.hasMoreData = false
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func highFilterApiCall() {
        APIClient.shared.cake.fetchHighFilterCake(0) { [weak self] result in
            switch result {
            case .success(let cakes):
                self?.cakes = cakes
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    if cakes.count < 10 {
                        self?.hasMoreData = false
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func lowFilterApiCall() {
        APIClient.shared.cake.fetchLowFilterCake(0) { [weak self] result in
            switch result {
            case .success(let cakes):
                self?.cakes = cakes
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    if cakes.count < 10 {
                        self?.hasMoreData = false
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    
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
        self.view.addSubview(loadingIndicator)
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
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private func loadingIndicatorSetUp() {
        loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
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
//        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 20, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.36))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
//        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(10), top: nil, trailing: .fixed(-10), bottom: nil)
        
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
            let storeName = cell.storeLabel.text ?? ""
            cakeTapped(cakeName, storeName)
        }
    }
    
    @objc func cakeTapped(_ cakeName: String, _ storeName: String) {
        print("CakeVC :     Collection Cell Tapped")
        
        let cakeVC = MainCakeViewController(cakeName: cakeName, storeName: storeName)
        
        self.present(cakeVC, animated: true)
    }
    
}


extension CakeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCakeCollectionViewCell.self), for: indexPath) as? MainCakeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let cake = cakes[indexPath.item]
        cell.configure(with: cake)
        cell.cellImage.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 상위 필터 버튼과 밑에 케이크들
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cakes.count
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
            filterApiCall()
        }
    }
}

extension CakeViewController: CakeHeaderViewDelegate {
    func filterButtonTapped(_ title: String) {
        
        self.filter = title
        
        if title == "인기순" {
            firstApiCall()
        } else if title == "최신순" {
            filterApiCall()
        } else if title == "높은가격순" {
            highFilterApiCall()
        } else {
            lowFilterApiCall()
        }
    }
    
    
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

// scroll하여 api 추가호출
extension CakeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.height
        if offsetY > contentHeight - scrollViewHeight {
            loadMoreData(self.filter ?? "")
        }
    }
    
    private func loadMoreData(_ filter: String) {
        guard hasMoreData else { return }
        loadingIndicator.startAnimating()
        
        let nextPage = (collectionView.numberOfItems(inSection: 0) / 10)
        
        if filter == "인기순" {
            APIClient.shared.cake.fetchCakeTapCake(nextPage) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingIndicator.stopAnimating()
                    switch result {
                    case . success(let newCakes):
                        self?.cakes.append(contentsOf: newCakes)
                        self?.collectionView.reloadData()
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        } else if filter == "최신순" {
            APIClient.shared.cake.fetchFilterCake(nextPage) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingIndicator.stopAnimating()
                    switch result {
                    case . success(let newCakes):
                        self?.cakes.append(contentsOf: newCakes)
                        self?.collectionView.reloadData()
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        } else if filter == "높은가격순" {
            APIClient.shared.cake.fetchHighFilterCake(nextPage) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingIndicator.stopAnimating()
                    switch result {
                    case . success(let newCakes):
                        self?.cakes.append(contentsOf: newCakes)
                        self?.collectionView.reloadData()
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            APIClient.shared.cake.fetchLowFilterCake(nextPage) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingIndicator.stopAnimating()
                    switch result {
                    case . success(let newCakes):
                        self?.cakes.append(contentsOf: newCakes)
                        self?.collectionView.reloadData()
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
