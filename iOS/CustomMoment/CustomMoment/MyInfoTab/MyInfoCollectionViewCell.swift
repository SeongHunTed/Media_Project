//
//  MyInfoCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/08.
//

import UIKit

class MyInfoCollectionViewCell: UICollectionViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let cellTitle: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textAlignment = .center
        label.font = UIFont.myFontR.withSize(10.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
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
    
    func infoLayout() {
        self.contentView.addSubview(cellView)
        
        cellView.addSubview(cellImage)
        cellView.addSubview(cellTitle)
        
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        cellImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20).isActive = true
        cellImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cellImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cellImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        cellTitle.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 10).isActive = true
        cellTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
}
