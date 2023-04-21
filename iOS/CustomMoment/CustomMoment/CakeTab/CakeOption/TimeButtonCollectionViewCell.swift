//
//  OptionButtonCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/25.
//

import UIKit

class TimeButtonCollectionViewCell: UICollectionViewCell {
    
    var onButtonTapped: ((UIButton) -> Void)?
    
    let timeButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = UIFont.myFontB.withSize(13.0)
        button.tintColor = .white
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var valid: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(timeButton)
        NSLayoutConstraint.activate([
            timeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            timeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            timeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        timeButton.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func prepare(_ valid: Bool) {
        
        self.valid = valid
        if valid {
            timeButton.backgroundColor = .white
            timeButton.tintColor = .systemRed
            timeButton.layer.borderWidth = 0.5
            timeButton.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            timeButton.backgroundColor = .systemGray4
            timeButton.tintColor = .white
        }
    }
    
    func setSelected(_ selected: Bool) {
        timeButton.isSelected = selected
        if selected {
            timeButton.backgroundColor = .systemRed.withAlphaComponent(0.8)
            timeButton.tintColor = .white
            timeButton.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            timeButton.backgroundColor = .white
            timeButton.tintColor = .systemRed.withAlphaComponent(0.8)
            timeButton.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.8).cgColor
        }
    }
    
    
    @objc func timeButtonTapped(_ sender: UIButton) {
        onButtonTapped?(sender)
    }
}
