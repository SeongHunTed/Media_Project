//
//  MyheaderFooterView.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/17.
//

import UIKit

class MyHeaderView: UICollectionReusableView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize:20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        NSLayoutConstraint.activate([
//            self.label.topAnchor.constraint(equalTo: self..bottomAnchor, constant: 10),
            self.label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: nil)
    }
    
    func prepare(text: String?) {
        self.label.text = text
    }
        
}

class MyFooterView: UICollectionReusableView {
    
    private let bannerPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(bannerPageControl)
        NSLayoutConstraint.activate([
            bannerPageControl.topAnchor.constraint(equalTo: topAnchor),
            bannerPageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            bannerPageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerPageControl.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare()
    }
    
    func prepare() {
        
    }
}
