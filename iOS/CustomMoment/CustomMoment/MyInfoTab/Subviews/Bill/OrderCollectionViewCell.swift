//
//  OrderCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/09.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let optionLabel: UILabel = {
        let label = UILabel()
        label.text = "옵션 : [케이크 사이즈 : 도시락, 케이크 맛 : 바닐라, 케이크 색상 : 기본, 케이크 디자인 : 동물, 케이크 사이드 데코레이션 : 사이드 데코', 케이크 데코레이션 : 악세시리, 케이크 레터링 : 케이크, 케이크 폰트 : 궁서체, 케이크 사진 : 예, 케이크 포장 : 기본, 초 : 숫자초 ]"
        label.font = UIFont.myFontR.withSize(12.0)
        label.textColor = .black
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let storeName: UILabel = {
        let label = UILabel()
        label.text = "딥 다이브"
        label.font = UIFont.myFontM.withSize(16.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cakeName: UILabel = {
        let label = UILabel()
        label.text = "반쪽 레터링 케이크"
        label.font = UIFont.myFontB.withSize(14.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pickUpDate: UILabel = {
        let label = UILabel()
        label.text = "픽업 날짜 : " + "2023-04-26"
        label.font = UIFont.myFontR.withSize(12.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pickUpTime: UILabel = {
        let label = UILabel()
        label.text = "픽업 시간 : " + "17:30"
        label.font = UIFont.myFontR.withSize(12.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "픽업완료"
        label.font = UIFont.myFontM.withSize(16.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("상세보기", for: .normal)
        button.titleLabel?.font = UIFont.myFontR.withSize(14.0)
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemGray2
        button.tintColor = .white
        button.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func detailButtonTapped() {
        
        guard let vc = self.findViewController() else { return }
        
        let billVC = BillViewController()
        vc.present(billVC, animated: true, completion: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepare() {
        
    }
    
    func orderLayout() {
        self.contentView.addSubview(stackView)
        
        stackView.addSubview(cellImage)
        stackView.addSubview(storeName)
        stackView.addSubview(cakeName)
        stackView.addSubview(pickUpDate)
        stackView.addSubview(pickUpTime)
        stackView.addSubview(detailButton)
        stackView.addSubview(statusLabel)
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        cellImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
        cellImage.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3).isActive = true
        cellImage.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10).isActive = true
        
        storeName.bottomAnchor.constraint(equalTo: cakeName.topAnchor, constant: -3).isActive = true
        storeName.heightAnchor.constraint(equalToConstant: 18).isActive = true
        storeName.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        cakeName.bottomAnchor.constraint(equalTo: pickUpDate.topAnchor, constant: -2).isActive = true
        cakeName.heightAnchor.constraint(equalToConstant: 16).isActive = true
        cakeName.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        pickUpDate.bottomAnchor.constraint(equalTo: pickUpTime.topAnchor).isActive = true
        pickUpDate.heightAnchor.constraint(equalToConstant: 14).isActive = true
        pickUpDate.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        pickUpTime.bottomAnchor.constraint(equalTo: detailButton.topAnchor, constant: -5).isActive = true
        pickUpTime.heightAnchor.constraint(equalToConstant: 14).isActive = true
        pickUpTime.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        let buttonWidth = (self.contentView.frame.width * 0.7 - 40)/2
        
        statusLabel.topAnchor.constraint(equalTo: pickUpTime.bottomAnchor, constant: 10).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        statusLabel.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        statusLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10).isActive = true
        
        detailButton.topAnchor.constraint(equalTo: statusLabel.topAnchor).isActive = true
        detailButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        detailButton.heightAnchor.constraint(equalTo: statusLabel.heightAnchor).isActive = true
        detailButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10).isActive = true
        
    }
    

    
}
