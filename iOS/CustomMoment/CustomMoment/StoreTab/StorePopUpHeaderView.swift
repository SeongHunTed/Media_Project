//
//  StorePopUpHeaderFooterView.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/02.
//

import UIKit

class StorePopUpHeaderView: UICollectionReusableView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
//        NSLayoutConstraint.activate([
////            self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//        ])
        addBottomBorder()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBottomBorder() {
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1)
        borderLayer.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(borderLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        label.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: nil)
    }
    
    func prepare(text: String?) {
        self.label.text = text
    }
}
