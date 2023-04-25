//
//  CartCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/05.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CartCellDelegate?
    
    private var rootOption: [String]?
    private var detailOption: ([String], Int)?
    
    private var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var storeName: UILabel = {
        let label = UILabel()
        label.text = "딥 다이브"
        label.font = UIFont.myFontM.withSize(16.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cakeName: UILabel = {
        let label = UILabel()
        label.text = "반쪽 레터링 케이크"
        label.font = UIFont.myFontB.withSize(14.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pickUpDate: UILabel = {
        let label = UILabel()
        label.text = "픽업 날짜 : " + "2023-04-26"
        label.font = UIFont.myFontR.withSize(12.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pickUpTime: UILabel = {
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
    
    private lazy var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("주문하기", for: .normal)
        button.titleLabel?.font = UIFont.myFontR.withSize(14.0)
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemRed.withAlphaComponent(0.9)
        button.tintColor = .white
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func orderButtonTapped() {
        let orderDetailVC = OrderDetailViewController(orderDetails: self.detailOption ?? (["nil"], 0) , rootDetails: self.rootOption ?? ["nil"])
        self.window?.rootViewController?.present(orderDetailVC, animated: true)
    }
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제하기", for: .normal)
        button.titleLabel?.font = UIFont.myFontR.withSize(14.0)
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemGray2
        button.tintColor = .white
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func deleteApiCall(completion: @escaping () -> Void) {
        if let rootOption = rootOption {
            let deleteRequest = OrderRequest(storeName: rootOption[1], cakeName: rootOption[0], cakePrice: 0, pickupDate: rootOption[2], pickupTime: rootOption[3], option: "")
            APIClient.shared.order.deleteCart(deleteRequest) { result in
                switch result {
                case .success(let message):
                    print(message)
                    completion()
                case . failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion()
                }
            }
        }
    }
    
    @objc func deleteButtonTapped() {
        let alertController = UIAlertController(title: "삭제", message: "해당 상품을 삭제하시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            self?.deleteApiCall {
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        strongSelf.delegate?.cartCollectionViewCellDidDeleteItem(strongSelf)
                        strongSelf.delegate?.reloadData()
                    }
                }
            }
        }
//        { [weak self] (action) in
//            self?.deleteCell()}
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        // 여기 이후에 이 쏄을 소유하고 있는 collectionView.reloadData()
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
        
        storeName.bottomAnchor.constraint(equalTo: cakeName.topAnchor, constant: -3).isActive = true
        storeName.heightAnchor.constraint(equalToConstant: 18).isActive = true
        storeName.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        cakeName.bottomAnchor.constraint(equalTo: pickUpDate.topAnchor, constant: -2).isActive = true
        cakeName.heightAnchor.constraint(equalToConstant: 16).isActive = true
        cakeName.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        pickUpDate.bottomAnchor.constraint(equalTo: pickUpTime.topAnchor).isActive = true
        pickUpDate.heightAnchor.constraint(equalToConstant: 14).isActive = true
        pickUpDate.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        pickUpTime.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -5).isActive = true
        pickUpTime.heightAnchor.constraint(equalToConstant: 14).isActive = true
        pickUpTime.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        
        let buttonWidth = (self.contentView.frame.width * 0.7 - 40)/2
        
//        orderButton.topAnchor.constraint(equalTo: pickUpTime.bottomAnchor, constant: 10).isActive = true
        orderButton.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        orderButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        orderButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: orderButton.topAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: orderButton.heightAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10).isActive = true
        
    }
    
    func configure(with cart: CartResponse) {
        let url = cart.fullImageURL
        self.storeName.text = cart.storeName
        self.cakeName.text = cart.cakeName
        self.pickUpDate.text = "픽업 날짜 : " + cart.pickUpDate
        self.pickUpTime.text = "픽업 시간 : " + cart.pickUpTime
        cellImage.loadImage(from: url)
        
        self.rootOption = [cart.cakeName, cart.storeName, cart.pickUpDate, cart.pickUpTime]
        self.detailOption = ([cart.option], cart.price)
    }
}

protocol CartCellDelegate: AnyObject {
    func reloadData()
    
    func cartCollectionViewCellDidDeleteItem(_ cell: CartCollectionViewCell)
}
