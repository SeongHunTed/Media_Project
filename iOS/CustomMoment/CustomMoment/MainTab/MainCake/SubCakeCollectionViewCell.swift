//
//  SubCakeCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/22.
//

import UIKit

class SubCakeCollectionViewCell: UICollectionViewCell {
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    func configure() {
        self.contentView.addSubview(cellImage)
        cellImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        cellImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        cellImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -25).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -25).isActive = true
        cellImage.contentMode = .scaleAspectFill
        
    }
    
}
