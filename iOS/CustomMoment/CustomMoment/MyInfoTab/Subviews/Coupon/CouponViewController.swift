//
//  CouponViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/08.
//

import UIKit

//class CouponViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        view.addSubview(titleLabel)
//        view.addSubview(imageView)
//
//        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
//        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//    }
//
//    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "bubble.left.and.exclamationmark.bubble.right")
//        imageView.contentMode = .scaleAspectFill
//        imageView.tintColor = .systemRed.withAlphaComponent(0.8)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "쿠폰 서비스 준비 중 입니다. 추후 업데이트 예정입니다."
//        label.font = UIFont.myFontM.withSize(14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//}

class CouponViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.view.addSubview(scrollView)
        self.scrollView.delegate = self
        scrollView.backgroundColor = .blue
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        scrollView.addSubview(infoImage)
        infoImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        infoImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        infoImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        infoImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        infoImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupContentSize()
    }
    
    private func setupContentSize() {
        guard let image = infoImage.image else { return }
        let aspectRatio = image.size.height / image.size.width
        let contentHeight = scrollView.frame.width * aspectRatio
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight)
        
        infoImage.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
    }

    // scrollView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        imageView.image = UIImage(named: "infoview")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

