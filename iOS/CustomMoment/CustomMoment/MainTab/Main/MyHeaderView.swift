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
        label.font = UIFont.myFontB.withSize(15.5)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor ),
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
    
    let bannerPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray5
        pageControl.currentPageIndicatorTintColor = .systemGray
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
    
    func configure() {
        self.addSubview(bannerPageControl)
        bannerPageControl.currentPage = 0
        bannerPageControl.numberOfPages = 4
        
        NSLayoutConstraint.activate([
            bannerPageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bannerPageControl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            bannerPageControl.widthAnchor.constraint(equalToConstant: 200), // 원하는 크기로 지정해주세요
            bannerPageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func updatePageControl(numberOfPages: Int, currentPage: Int) {
        bannerPageControl.numberOfPages = numberOfPages
        bannerPageControl.currentPage = currentPage
    }
}

