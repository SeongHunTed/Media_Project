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
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "서울 서초구 방배동 534-2"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
//        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "딥다이브는 서초구에서 졸라 잘나가는 케이크 집이지요."
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
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
        self.contentView.addSubview(self.stackView)
        
        stackView.addSubview(cellImage)
        stackView.addSubview(storeLabel)
        stackView.addSubview(infoLabel)
        stackView.addSubview(addressLabel)
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        cellImage.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        cellImage.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.7).isActive = true
        
        storeLabel.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 5).isActive = true
        storeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 2).isActive = true
        
        infoLabel.topAnchor.constraint(equalTo: storeLabel.bottomAnchor, constant: 5).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 2).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -2).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 5).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 2).isActive = true
        
    }
}
