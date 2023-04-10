//
//  EventViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/08.
//

import UIKit

class EventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bubble.left.and.exclamationmark.bubble.right")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemRed.withAlphaComponent(0.8)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트 서비스 준비 중 입니다. 추후 업데이트 예정입니다."
        label.font = UIFont.myFontM.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

}
