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
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray6
        pageControl.currentPageIndicatorTintColor = .systemGray
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func storePopUpLayout() {
        self.contentView.addSubview(cellImage)
        self.contentView.addSubview(pageControl)
        
        cellImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        cellImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        cellImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        cellImage.contentMode = .scaleAspectFill
        
        pageControl.topAnchor.constraint(equalTo: cellImage.bottomAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func configure(with store: MainStorePopUpRequest, item: Int) {
        let url = store.fullImageURLs[item]
        cellImage.loadImage(from: url)
    }
    
}
