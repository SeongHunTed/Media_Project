//
//  DrawCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/24.
//

import UIKit

protocol DrawCollectionViewCellDelegate: AnyObject {
    func buttonTapped(cell: DrawCollectionViewCell)
}

class DrawCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: DrawCollectionViewCellDelegate?
    
    var isSelectedCell: Bool = false {
        didSet {
            button.isSelected = isSelectedCell
            button.tintColor = isSelectedCell ? UIColor.systemRed : UIColor.white
        }
    }
    
    lazy var button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.myFontM.withSize(14.0)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
    
    @objc func buttonTapped() {
        isSelectedCell.toggle()
        delegate?.buttonTapped(cell: self)
    }
}
