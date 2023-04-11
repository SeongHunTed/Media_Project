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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupContentSize()
        print(storeLabel.frame.size)
        
        let storeBottomLayer = CALayer()
        storeBottomLayer.frame = CGRect(x: 0, y: 39, width: self.view.frame.size.width, height: 1)
        storeBottomLayer.backgroundColor = UIColor.gray.withAlphaComponent(0.75).cgColor
        storeLabel.layer.addSublayer(storeBottomLayer)
        
        let cakeTopLayer = CALayer()
        cakeTopLayer.frame = CGRect(x:-20, y: nameLabel.frame.height - 10, width: view.frame.size.width, height: 2)
        cakeTopLayer.backgroundColor = UIColor.systemGray4.cgColor
        nameLabel.layer.addSublayer(cakeTopLayer)
        
        let buttonBottomLayer = CALayer()
        buttonBottomLayer.frame = CGRect(x: 0, y: 32, width: view.frame.size.width-40, height: 1)
        buttonBottomLayer.backgroundColor = UIColor.systemRed.cgColor
        infoButton.layer.addSublayer(buttonBottomLayer)
    }
    
    private func setupContentSize() {
        infoImage.widthAnchor.constraint(equalToConstant: scrollView.frame.width-40).isActive = true
        guard let image = infoImage.image else { return }
        let aspectRatio = image.size.height / image.size.width
        print("infoImage : \(infoImage.frame.width)")
        let contentHeight = 350 * aspectRatio + infoImage.frame.origin.y
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight)
        
        infoImage.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
    }
    
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
    
    private let storeLabel: UILabel = {
        let label = UILabel()
        label.text = "   ⭐️ 모율샵 > 컬러직사각케이크"
        label.font = UIFont.myFontB.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray5
        pageControl.currentPageIndicatorTintColor = .systemGray
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = 0
        pageControl.numberOfPages = 4
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "컬러직사각케이크"
        label.font = UIFont.myFontR.withSize(18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "20,000원"
        label.font = UIFont.myFontB.withSize(18.0)
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
//        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        
        scrollView.addSubview(storeLabel)
        scrollView.addSubview(pageControl)
        
        storeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        storeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        storeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        storeLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10).isActive = true

        collectionView.topAnchor.constraint(equalTo: self.storeLabel.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.8).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -10).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(infoButton)
        scrollView.addSubview(reviewButton)
        
        nameLabel.topAnchor.constraint(
            equalTo: pageControl.bottomAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        priceLabel.topAnchor.constraint(
            equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
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
        print("scrollView : \(scrollView.frame.width)")
        infoImage.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 40).isActive = true
        infoImage.topAnchor.constraint(equalTo: infoButton.bottomAnchor, constant: 20).isActive = true
        infoImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        infoImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
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
        orderButton.centerYAnchor.constraint(equalTo: orderView.centerYAnchor).isActive = true
        
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
    
    // 현 뷰에서는 해당 헤더 푸터를 사용할 수 없음
    // Why? 전체가 스크롤뷰이고 그안에 콜렉션뷰인데, 상품설명 jpg가 꽤나 길다
    // 해당 비율을 맞추는게 쉽지 않은데 지금이 최선으로써 느껴진다.
    // 따라서 컬렉션 뷰는 정말 쎌 이미지만 보여주는 역할로 써 정의됨
    private func cakeBannerCompositionalLayout() -> NSCollectionLayoutSection {
        
        // header 구현 -> 기존 헤더 사용
//        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
//        collectionView.register(MyFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MyFooterView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.13))
//        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.13))
        
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)

        
//        section.boundarySupplementaryItems = [header]
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
        cell.layer.cornerRadius = 12.0
        cell.clipsToBounds = true
        
        return cell
    }
    
    // dataSource Header, Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderView", for: indexPath) as! MyHeaderView
            header.prepare(text: " 🏡 월선화 > 강릉바다떡케이크")
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

//
//extension MainCakeViewController: UIScrollViewDelegate {
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("Hi")
//        let pageWidth = collectionView.frame.width
//        let currentPage = Int(collectionView.contentOffset.x / pageWidth)
//        pageControl.currentPage = currentPage
//    }
//}
