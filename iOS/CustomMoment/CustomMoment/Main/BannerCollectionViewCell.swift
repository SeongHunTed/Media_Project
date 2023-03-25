//
//  MainCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/15.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = CGColor(red: 0.0, green: 0, blue: 0, alpha: 0.1)
        self.contentView.addSubview(self.cellImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare()
    }
    
    func prepare() {
//        print("Banner Cell :    prepareForReuse(), prepare() called")
    }
    
    func bannerLayout() {
        cellImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        cellImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        cellImage.contentMode = .scaleAspectFit
    }
}

