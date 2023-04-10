//
//  CakeCollectionReusableView.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/30.
//

import UIKit
import DropDown
import FSCalendar

protocol CakeHeaderViewDelegate: AnyObject {
    func calendarButtonTapped()
}

public class CakeHeaderView: UICollectionReusableView {
    
    weak var delegate: CakeHeaderViewDelegate?
    
    private let dropDownDataSource = ["인기순", "최신순", "높은가격순", "낮은가격순"]
    
    let filterButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.tintColor = .black
        button.backgroundColor = .systemGray6
        button.titleLabel?.font = UIFont.myFontM.withSize(15.0)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let filterDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.textColor = UIColor.black
        dropDown.cornerRadius = 4
        dropDown.textFont = UIFont.myFontM.withSize(15)
        return dropDown
    }()
    
    public var calendarButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.tintColor = .black
        button.backgroundColor = .systemGray6
        button.titleLabel?.font = UIFont.myFontM.withSize(15.0)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func updateButtonTitle(withTitle title: String) {
        print("working \(title)")
        calendarButton.setTitle(title, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        filterButtonSetUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func filterButtonSetUp() {
        self.addSubview(filterButton)
        self.addSubview(filterDropDown)
        self.addSubview(calendarButton)
        
        filterButton.setTitle("인기순", for: .normal)
        calendarButton.setTitle("날짜 검색", for: .normal)
        
        filterDropDown.dataSource = dropDownDataSource
        filterDropDown.anchorView = filterButton
        filterDropDown.bottomOffset = CGPoint(x: 0, y: filterButton.bounds.height+30)
        filterDropDown.selectionAction = { [weak self] (index, item) in
            self!.filterButton.setTitle(item, for: .normal)
        }
        
        filterButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        filterButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        filterButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        calendarButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        calendarButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        calendarButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true

        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
    }
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        print("CakeVC :     Filter Option Tapped")
        filterDropDown.show()
    }
    
    @objc func calendarButtonTapped() {
        print("CakeVC :     Calendar Button Tapped")
        delegate?.calendarButtonTapped()
    }
    
    
}
