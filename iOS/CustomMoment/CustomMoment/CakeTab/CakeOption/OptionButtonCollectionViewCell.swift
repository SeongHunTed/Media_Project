//
//  OptionButtonCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/28.
//

import UIKit
import DropDown

struct CakeOption {
    let optionName: String
    let price: Int
}

class OptionButtonCollectionViewCell: UICollectionViewCell {
    
    var selectedOption: CakeOption?
    var category: String?
    var isLetteringOptionSelected = false
    
    // 케이크 상세 옵션들 선택한 것들
    var onOptionSelected: ((Int, String) -> Void)?
    
    // 케이크 상세 옵션 -> String
    var selectedOptionTitle: String?
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let optionButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.tintColor = .systemGray2
        button.titleLabel?.font = UIFont.myFontB.withSize(14)
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
        dropDown.textFont = UIFont.myFontB.withSize(14)
        dropDown.cornerRadius = 4
        dropDown.selectionBackgroundColor = UIColor.systemRed.withAlphaComponent(0.8)
        dropDown.backgroundColor = .white
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        return dropDown
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(optionButton)
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            optionButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            optionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            optionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            optionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.topAnchor.constraint(equalTo: optionButton.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30)
        ])
        optionButton.addTarget(self, action: #selector(optionButtonTapped), for: .touchUpInside)
        // 버튼에 할당
        dropDown.anchorView = optionButton
        
        // 버튼을 가리지 않고 내려옴
        dropDown.bottomOffset = CGPoint(x: 0, y:optionButton.bounds.height+30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func optionButtonTapped(_ sender: UIButton) {
        print("OptionVC :   Option Tapped")
        dropDown.show()
    }
}
