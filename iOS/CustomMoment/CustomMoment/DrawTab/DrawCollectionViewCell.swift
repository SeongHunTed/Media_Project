//
//  DrawCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/24.
//

import UIKit

class DrawCollectionViewCell: UICollectionViewCell {
    
    var isSelectedCell: Bool = false {
        didSet {
            button.isSelected = isSelectedCell
            button.tintColor = isSelectedCell ? UIColor.systemRed : UIColor.white
        }
    }
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.myFontR.withSize(16.0)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        button.setTitle(title, for: .normal)
    }
}
