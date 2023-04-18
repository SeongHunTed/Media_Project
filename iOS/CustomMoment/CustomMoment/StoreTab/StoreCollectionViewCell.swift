//
//  StoreCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/31.
//

import UIKit

class StoreCollectionViewCell: UICollectionViewCell {
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let storeLabel: UILabel = {
        let label = UILabel()
        label.text = "딥 다이브"
        label.font = UIFont.myFontM.withSize(13.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "서울 서초구 방배동 534-2"
        label.font = UIFont.myFontR.withSize(11.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "딥다이브는 서초구에서 졸라 잘나가는 케이크 집이지요."
        label.font = UIFont.myFontB.withSize(15.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
        storeLayout()
        // 그림자 추가
        cellImage.layer.shadowColor = UIColor.gray.cgColor
        cellImage.layer.shadowRadius = 20.0
        cellImage.layer.shadowOpacity = 0.6
        cellImage.layer.shadowOffset = CGSize(width: 0, height: 20)
        cellImage.layer.cornerRadius = 12.0
        cellImage.layer.shadowPath = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare()
    }
    
    private func prepare() {
        
    }
    
    func storeLayout() {
        self.contentView.addSubview(self.cellImage)
        self.contentView.addSubview(self.stackView)
        
        stackView.addSubview(storeLabel)
        stackView.addSubview(infoLabel)
        stackView.addSubview(addressLabel)
        
        cellImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        cellImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.7).isActive = true
        
        stackView.topAnchor.constraint(equalTo: cellImage.bottomAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        storeLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 5).isActive = true
        storeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 2).isActive = true
        
        infoLabel.topAnchor.constraint(equalTo: storeLabel.bottomAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 2).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -2).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 5).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 2).isActive = true
    }
    
    func configure(with store: MainStoreRequest) {
        storeLabel.text = store.name
        infoLabel.text = store.intro
        addressLabel.text = store.address
        
        let storeImageURL = store.fullImageURL
        cellImage.loadImage(from: storeImageURL)
    }
}
