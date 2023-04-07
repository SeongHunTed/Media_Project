//
//  CartCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/05.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    
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
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let storeName: UILabel = {
        let label = UILabel()
        label.text = "딥 다이브"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cakeName: UILabel = {
        let label = UILabel()
        label.text = "반쪽 레터링 케이크"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pickUpDate: UILabel = {
        let label = UILabel()
        label.text = "픽업 날짜 : " + "2023-04-26"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pickUpTime: UILabel = {
        let label = UILabel()
        label.text = "픽업 시간 : " + "17:30"
        label.font = .systemFont(ofSize: 15)
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
    
    private lazy var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("주문하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemRed.withAlphaComponent(0.9)
        button.tintColor = .white
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func orderButtonTapped() {
        
        let orderDetailVC = OrderDetailViewController()
        
        self.window?.rootViewController?.presentedViewController?.present(orderDetailVC, animated: true, completion: nil)
    }
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemGray2
        button.tintColor = .white
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func deleteButtonTapped() {
        let alertController = UIAlertController(title: "삭제", message: "해당 상품을 삭제하시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive)
//        { [weak self] (action) in
//            self?.deleteCell()}
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.window?.rootViewController?.presentedViewController?.present(alertController, animated: true, completion: nil)
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
    
    func cartLayout() {
        self.contentView.addSubview(stackView)
        
        stackView.addSubview(cellImage)
        stackView.addSubview(storeName)
        stackView.addSubview(cakeName)
        stackView.addSubview(pickUpDate)
        stackView.addSubview(pickUpTime)
        stackView.addSubview(orderButton)
        stackView.addSubview(deleteButton)
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        cellImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10).isActive = true
        cellImage.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3).isActive = true
        cellImage.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10).isActive = true
        
        storeName.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        storeName.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        cakeName.topAnchor.constraint(equalTo: storeName.bottomAnchor).isActive = true
        cakeName.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        pickUpDate.topAnchor.constraint(equalTo: cakeName.bottomAnchor, constant: 5).isActive = true
        pickUpDate.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        pickUpTime.topAnchor.constraint(equalTo: pickUpDate.bottomAnchor).isActive = true
        pickUpTime.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        let buttonWidth = (self.contentView.frame.width * 0.7 - 40)/2
        
        print(self.contentView.frame.width)
        print(buttonWidth)
        
        orderButton.topAnchor.constraint(equalTo: pickUpTime.bottomAnchor, constant: 10).isActive = true
        orderButton.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        orderButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        orderButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: orderButton.topAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: orderButton.heightAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10).isActive = true
        
    }
}
