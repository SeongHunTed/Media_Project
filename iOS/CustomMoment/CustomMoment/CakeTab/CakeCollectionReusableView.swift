//
//  CakeCollectionReusableView.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/30.
//

import UIKit
import DropDown

class CakeCollectionReusableView: UICollectionReusableView {
    
    private let dropDownDataSource = ["인기순", "최신순", "높은가격순", "낮은가격순"]
    
    let filterButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.tintColor = .black
        button.backgroundColor = .systemGray4
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let filterDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.textColor = UIColor.black
        dropDown.cornerRadius = 4
        return dropDown
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        filterButtonSetUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func filterButtonSetUp() {
        self.addSubview(filterButton)
        self.addSubview(filterDropDown)
        
        filterButton.setTitle("필터 옵션", for: .normal)
        
        filterDropDown.dataSource = dropDownDataSource
        filterDropDown.anchorView = filterButton
        filterDropDown.bottomOffset = CGPoint(x: 0, y: filterButton.bounds.height+30)
        filterDropDown.selectionAction = { [weak self] (index, item) in
            self!.filterButton.setTitle(item, for: .normal)
        }
        
        filterButton.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 20).isActive = true
        filterButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        filterButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true

        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        print("CakeVC :   Option Tapped")
        filterDropDown.show()
    }
}
