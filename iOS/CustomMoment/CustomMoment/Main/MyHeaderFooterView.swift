//
//  MyheaderFooterView.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/17.
//

import UIKit

class MyHeaderFooterView: UICollectionReusableView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize:20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        NSLayoutConstraint.activate([
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10)
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
