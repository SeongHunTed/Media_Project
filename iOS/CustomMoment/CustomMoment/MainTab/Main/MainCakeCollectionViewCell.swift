//
//  MainCakeCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/20.
//

import UIKit

class MainCakeCollectionViewCell: UICollectionViewCell {
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let storeLabel: UILabel = {
        let label = UILabel()
        label.text = "유니아 케이크"
        label.font = UIFont.myFontM.withSize(9)
        label.textColor = .black
        label.numberOfLines = 1
//        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cakeLabel: UILabel = {
        let label = UILabel()
        label.text = "체커보드케이크"
        label.font = UIFont.myFontM.withSize(12.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "28,000원 ~"
        label.font = UIFont.myFontB.withSize(14.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰 0"
        label.font = UIFont.myFontR.withSize(8)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
        cakeLayout()
        
        // 그림자 추가
        self.containerView.layer.shadowColor = UIColor.gray.cgColor
        self.containerView.layer.shadowRadius = 2.0
        self.containerView.layer.shadowOpacity = 0.6
        self.containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.containerView.layer.cornerRadius = 12.0
        self.containerView.clipsToBounds = true
        self.containerView.layer.masksToBounds = false
        self.containerView.layer.shadowPath = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare()
    }
    
    private func prepare() {
        // 아마도 케이크 정보를 받는 text 들을 초기화 해주어야할 것 같음
//        print("Main-CakeCell :      prepareForReuse(), prepare() called")
    }

    func cakeLayout() {
        self.contentView.addSubview(self.containerView)
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
       
        // stackView 추가
        containerView.addSubview(self.stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 12.0
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        stackView.addSubview(cellImage)
        stackView.addSubview(storeLabel)
        stackView.addSubview(reviewLabel)
        stackView.addSubview(cakeLabel)
        stackView.addSubview(priceLabel)
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        cellImage.topAnchor.constraint(equalTo: self.stackView.topAnchor).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: -60).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor).isActive = true
        
        storeLabel.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 2).isActive = true
        storeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8).isActive = true
        storeLabel.trailingAnchor.constraint(lessThanOrEqualTo: stackView.trailingAnchor, constant: -3).isActive = true
        
        reviewLabel.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 2).isActive = true
        reviewLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        
        cakeLabel.topAnchor.constraint(equalTo: storeLabel.bottomAnchor, constant: -2).isActive = true
        cakeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8).isActive = true
        cakeLabel.trailingAnchor.constraint(lessThanOrEqualTo: stackView.trailingAnchor, constant: -3).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: cakeLabel.bottomAnchor, constant: 4).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8).isActive = true
        priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: stackView.trailingAnchor, constant: -3).isActive = true
        
    }
    
}
