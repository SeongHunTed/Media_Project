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
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 5),
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
    
    weak var homeVC: HomeViewController?
    
    let bannerPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .systemGray5
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(delegate: UIScrollViewDelegate) {
        self.addSubview(bannerPageControl)
        bannerPageControl.currentPage = 0
        bannerPageControl.numberOfPages = 4
        
        if let homeVC = delegate as? HomeViewController {
            self.homeVC = homeVC
        }
        NSLayoutConstraint.activate([
            bannerPageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bannerPageControl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            bannerPageControl.widthAnchor.constraint(equalToConstant: 200), // 원하는 크기로 지정해주세요
            bannerPageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


extension MyFooterView {
    func updateCurrentPage(_ page: Int) {
        bannerPageControl.currentPage = page
    }
}
