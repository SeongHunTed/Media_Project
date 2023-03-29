//
//  OptionButtonCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/28.
//

import UIKit
import DropDown

class OptionButtonCollectionViewCell: UICollectionViewCell {
    
    let optionButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.tintColor = .systemGray2
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.systemGray2.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.textColor = UIColor.black
        dropDown.cornerRadius = 4
        dropDown.selectionBackgroundColor = UIColor.systemRed.withAlphaComponent(0.8)
        dropDown.backgroundColor = .white
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        return dropDown
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(optionButton)
        NSLayoutConstraint.activate([
            optionButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            optionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            optionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            optionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        optionButton.addTarget(self, action: #selector(optionButtonTapped), for: .touchUpInside)
        // 버튼에 할당
        dropDown.anchorView = optionButton
        
        // 버튼을 가리지 않고 내려옴
        dropDown.bottomOffset = CGPoint(x: 0, y:optionButton.bounds.height+40)

        dropDown.selectionAction = { [weak self] (index, item) in
            self!.optionButton.setTitle(item, for: .normal)
            self!.optionButton.backgroundColor = .systemRed.withAlphaComponent(0.8)
            self!.optionButton.tintColor = .white
            self!.optionButton.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func optionButtonTapped(_ sender: UIButton) {
        print("OptionVC :   Option Tapped")
        dropDown.show()
    }
}
