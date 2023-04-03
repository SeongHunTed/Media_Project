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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setDelegate()
        configure()
        belowConfigure()
    }
    
    // delegate 설정
    private func setDelegate() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    // MARK: - Components
    
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
        label.text = "Cake Name"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "0원"
        label.font = .boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("상품 정보", for: .normal)
        button.titleLabel?.textColor = .white
        button.tintColor = .systemRed
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let reviewButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("구매 후기", for: .normal)
        button.titleLabel?.text = "구매 후기"
        button.setTitleColor(.systemRed, for: .normal)
        button.tintColor = .white
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 상품정보 스크롤뷰
    private let infoView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // 상품 정보
    private let infoLabel: UILabel = {
        let textField = UILabel()
        textField.text = "케이크에 대한 설명이 들어갈 부분입니다만 일단을 졸라길게 한번 써보겠습니다. 이게 넘어가는지 확인해야죠"
        textField.numberOfLines = 0
        textField.textAlignment = .natural
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // 주문 버튼 View
    private let orderView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: -10)
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 주문버튼
    private let orderButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("주문 하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.tintColor = .systemRed
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - 하단 뷰 Layout
    private func belowConfigure() {
        self.view.addSubview(stackView)
        self.view.addSubview(orderView)
        
        stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        stackView.addSubview(nameLabel)
        stackView.addSubview(priceLabel)
        stackView.addSubview(infoButton)
        stackView.addSubview(reviewButton)
        stackView.addSubview(infoView)
        
        nameLabel.topAnchor.constraint(
            equalTo: stackView.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(
            equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        priceLabel.topAnchor.constraint(
            equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        priceLabel.leadingAnchor.constraint(
            equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        infoButton.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
        infoButton.leadingAnchor.constraint(
            equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        reviewButton.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
        reviewButton.leadingAnchor.constraint(
            equalTo: infoButton.trailingAnchor).isActive = true
        
        
        // InfoView Layout
        infoView.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor).isActive = true
        infoView.topAnchor.constraint(
            equalTo: infoButton.bottomAnchor, constant: 10).isActive = true
        infoView.leadingAnchor.constraint(
            equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        infoView.trailingAnchor.constraint(
            equalTo: stackView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        infoView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        
        
        infoView.addSubview(infoLabel)
        
        infoLabel.widthAnchor.constraint(equalTo: infoView.widthAnchor).isActive = true
        infoLabel.topAnchor.constraint(equalTo: infoView.topAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor).isActive = true
        
        // OrderView Layout
        orderView.addSubview(orderButton)
        
        orderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        orderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        orderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        orderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        orderView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08).isActive = true
        
        // OrderButton
        orderButton.leadingAnchor.constraint(equalTo: orderView.leadingAnchor).isActive = true
        orderButton.trailingAnchor.constraint(equalTo: orderView.trailingAnchor).isActive = true
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
        
        if sender.tintColor == .white && reviewButton.tintColor == .systemRed {
            sender.tintColor = .systemRed
            sender.setTitleColor(.white, for: .normal)
            reviewButton.tintColor = .white
            reviewButton.setTitleColor(.systemRed, for: .normal)
        } else if sender.tintColor == .systemRed && reviewButton.tintColor == .white {
            print("nothing happened")
        }
    }
    
    @objc func reviewButtonTapped(_ sender: UIButton) {
        print("CakeVC :     reviewButtonTapped")
        
        if sender.tintColor == .white && infoButton.tintColor == .systemRed {
            sender.tintColor = .systemRed
            sender.setTitleColor(.white, for: .normal)
            infoButton.tintColor = .white
            infoButton.setTitleColor(.systemRed, for: .normal)
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
    private func configure() {
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutenvironment -> NSCollectionLayoutSection? in
            return self.cakeBannerCompositionalLayout()
        }
    }
    
    private func cakeBannerCompositionalLayout() -> NSCollectionLayoutSection {
        
        // header 구현 -> 기존 헤더 사용
        
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
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
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyFooterView", for: indexPath) as! MyFooterView
            footer.prepare(cakeImages.count, indexPath.item)
            return footer
        default:
            return UICollectionReusableView()
        }
    }

}
