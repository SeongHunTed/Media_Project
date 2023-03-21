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
        return stackView
    }()
    
    private let storeLabel: UILabel = {
        let label = UILabel()
        label.text = "유니아 케이크"
        label.font = .systemFont(ofSize: 10)
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cakeLabel: UILabel = {
        let label = UILabel()
        label.text = "체커보드케이크"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
//        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "28,000원 ~"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰 0"
        label.font = .systemFont(ofSize: 10)
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = CGColor(red: 0.0, green: 0, blue: 0, alpha: 0.1)
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
        print("Main-CakeCell :      prepareForReuse(), prepare() called")
    }

    func cakeLayout() {
        self.contentView.addSubview(self.stackView)
        
        stackView.addSubview(cellImage)
        stackView.addSubview(storeLabel)
        stackView.addSubview(reviewLabel)
        stackView.addSubview(cakeLabel)
        stackView.addSubview(priceLabel)
        
        cellImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -60).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        storeLabel.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 2).isActive = true
        storeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3).isActive = true
        storeLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -3).isActive = true
        
        reviewLabel.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 2).isActive = true
        reviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3).isActive = true
        
        cakeLabel.topAnchor.constraint(equalTo: storeLabel.bottomAnchor, constant: 2).isActive = true
        cakeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3).isActive = true
        cakeLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -3).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: cakeLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3).isActive = true
        priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -3).isActive = true
        
    }
    
}
