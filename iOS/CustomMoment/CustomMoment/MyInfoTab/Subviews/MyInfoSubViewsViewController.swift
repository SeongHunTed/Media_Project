//
//  MyInfoSubViewsViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/05.
//

import UIKit

class MyInfoSubViewsViewController: UIViewController {
    
    var titleName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configure()
        
    }
    
    init(_ title: String) {
        self.titleName = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //super.init(coder: coder) 이것도 됨
    }
    
    // MARK: - Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.titleName
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .systemRed.withAlphaComponent(0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backButton: UIStackView = {
        let stackView = UIStackView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        stackView.addGestureRecognizer(tapGesture)
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    @objc func backButtonTapped() {
        self.dismiss(animated: false)
    }
    
    private let backImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.backward")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let backLabel: UILabel = {
        let label = UILabel()
        label.text = "뒤로"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottomBoarder = UIImageView(frame: CGRect(x: 0, y: 96.6, width: self.view.frame.width, height: 0.5))
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                self.dismiss(animated: true, completion: nil)
            default: break
            }
        }
    }

    private func configure() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        self.view.addSubview(bottomBoarder)
        
        bottomBoarder.backgroundColor = .black.withAlphaComponent(0.6)
        bottomBoarder.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        self.view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomBoarder.topAnchor, constant: -10).isActive = true
        
        self.view.addSubview(backButton)
        self.backButton.addArrangedSubview(backImage)
        self.backButton.addArrangedSubview(backLabel)
        
        backButton.bottomAnchor.constraint(equalTo: bottomBoarder.topAnchor, constant: -10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        
        backImage.leadingAnchor.constraint(equalTo: backButton.leadingAnchor).isActive = true
        backLabel.leadingAnchor.constraint(equalTo: backImage.trailingAnchor).isActive = true
        
        
    }

}
