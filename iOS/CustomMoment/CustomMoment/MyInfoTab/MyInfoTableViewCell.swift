//
//  MyInfoTableViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/03.
//

import UIKit

class MyInfoTableViewCell: UITableViewCell {
    
    static let identifier = "MyInfoTableViewCell"
        
    lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(cellImageView)
        self.addSubview(label)
        
        NSLayoutConstraint.activate([

            cellImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cellImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            cellImageView.widthAnchor.constraint(equalTo: self.cellImageView.heightAnchor),

            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
