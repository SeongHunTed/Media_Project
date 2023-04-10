//
//  CakeViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/20.
//

import UIKit

class MainCakeViewController: UIViewController {
    
    // MARK: - Variables
    let vcIdentifier = "CakeVC"
    
    let cakeImages = ["cake1", "cake2", "cake3", "cake4"]
    let infoImages = ["infoview"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setDelegate()
        configure()
    }
    
//    override func viewDidLayoutSubviews() {
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y: 0.0, width: infoView.frame.width, height: 1.0)
//        bottomLine.backgroundColor = UIColor.systemRed.cgColor
//        infoView.layer.addSublayer(bottomLine)
//    }
    
    // delegate 설정
    private func setDelegate() {
        self.scrollView.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    // MARK: - Components
    
    // scrollView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // collectionview
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "김성훈 케이크"
        label.font = UIFont.myFontM.withSize(20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "20,000원"
        label.font = UIFont.myFontM.withSize(20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("상품 정보", for: .normal)
        button.titleLabel?.font = UIFont.myFontM.withSize(14.0)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let reviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("구매 후기", for: .normal)
        button.titleLabel?.font = UIFont.myFontM.withSize(14.0)
        button.tintColor = .systemRed
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "infoview")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 상품 정보
    private let infoLabel: UILabel = {
        let textField = UILabel()
        textField.text = "케이크에 대한 설명이 들어갈 부분입니다만 일단을 졸라길게 한번 써보겠습니다. 이게 넘어가는지 확인해야죠"
        textField.font = UIFont.myFontR
        textField.numberOfLines = 0
        textField.textAlignment = .natural
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // 주문 버튼 View
    private let orderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 주문버튼
    private let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.titleLabel?.font = UIFont.myFontM.withSize(16.0)
        button.setTitle("주문 하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.tintColor = .white
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - 하단 뷰 Layout
    private func configure() {
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(stackView)
        self.view.addSubview(orderView)
        
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        collectionView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(infoButton)
        scrollView.addSubview(reviewButton)
        
        nameLabel.topAnchor.constraint(
            equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        priceLabel.topAnchor.constraint(
            equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        priceLabel.leadingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        infoButton.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: 33).isActive = true
        infoButton.leadingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        
        reviewButton.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
        reviewButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        reviewButton.heightAnchor.constraint(equalToConstant: 33).isActive = true
        reviewButton.leadingAnchor.constraint(
            equalTo: infoButton.trailingAnchor).isActive = true
        
        scrollView.addSubview(infoImage)
        
        infoImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        infoImage.topAnchor.constraint(equalTo: infoButton.bottomAnchor).isActive = true
        infoImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        infoImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        infoImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // OrderView Layout
        orderView.addSubview(orderButton)
        
        orderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        orderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        orderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        orderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        orderView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08).isActive = true
        
        // OrderButton
        orderButton.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 20).isActive = true
        orderButton.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -20).isActive = true
        orderButton.centerXAnchor.constraint(equalTo: orderView.centerXAnchor).isActive = true
        orderButton.centerYAnchor.constraint(equalTo: orderView.centerYAnchor, constant: -10).isActive = true
        
        // Button Tapped
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        reviewButton.addTarget(self, action: #selector(reviewButtonTapped), for: .touchUpInside)
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)

    }
    
    // MARK: - Buttons
    
    @objc func infoButtonTapped(_ sender: UIButton) {
        print("CakeVC :     infoButtonTapped")
        
        if sender.backgroundColor == .white {
            sender.backgroundColor = .systemRed
            sender.tintColor = .white
            reviewButton.tintColor = .systemRed
            reviewButton.backgroundColor = .white
        } else {
            print("nothing happened")
        }
    }
    
    @objc func reviewButtonTapped(_ sender: UIButton) {
        print("CakeVC :     reviewButtonTapped")
        
        if sender.backgroundColor == .white {
            sender.backgroundColor = .systemRed
            sender.tintColor = .white
            infoButton.tintColor = .systemRed
            infoButton.backgroundColor = .white
        } else {
            print("nothing")
        }
    }
    
    @objc func orderButtonTapped(_ sender: UIButton) {
        print("CakeVC:      Order Button Tapped")
        
        let optionVC = MainOptionViewController()
        
        self.present(optionVC, animated: true)
    }
    
    // MARK: - 상단 뷰 Layout - Compositional Layout
    
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutenvironment -> NSCollectionLayoutSection? in
            return self.cakeBannerCompositionalLayout()
        }
    }
    
    private func cakeBannerCompositionalLayout() -> NSCollectionLayoutSection {
        
        // header 구현 -> 기존 헤더 사용
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        collectionView.register(MyFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MyFooterView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.13))
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.13))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)

        
        section.boundarySupplementaryItems = [header, footer]
        return section
    }
    
}


// MARK: extension
extension MainCakeViewController: UICollectionViewDelegate {
    
}

extension MainCakeViewController: UICollectionViewDataSource {
    
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
            let borderLayer = CALayer()
            borderLayer.frame = CGRect(x: 0, y: header.frame.size.height - 1, width: self.view.frame.size.width, height: 1)
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
