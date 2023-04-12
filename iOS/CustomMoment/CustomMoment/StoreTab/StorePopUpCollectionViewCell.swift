//
//  StorePopUpCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/01.
//

import UIKit

class StorePopUpCollectionViewCell: UICollectionViewCell {
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
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

    }
    
    func configure() {
        self.contentView.addSubview(cellImage)
        cellImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        cellImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        cellImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        cellImage.contentMode = .scaleAspectFill
    }
    
}
