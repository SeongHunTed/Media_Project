//
//  OptionButtonCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/25.
//

import UIKit

class TimeButtonCollectionViewCell: UICollectionViewCell {
    
    let timeButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = UIFont.myFontR.withSize(15.0)
        button.tintColor = .white
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(timeButton)
        NSLayoutConstraint.activate([
            timeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            timeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            timeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
