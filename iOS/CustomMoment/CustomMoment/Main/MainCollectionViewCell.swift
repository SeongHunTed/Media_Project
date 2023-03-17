//
//  MainCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/15.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
//        self.contentView.layer.borderWidth = 1
//        self.contentView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.contentView.addSubview(self.bannerImage)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        bannerImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        bannerImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        bannerImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        bannerImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        bannerImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        bannerImage.contentMode = .scaleAspectFit
    }
    
}
