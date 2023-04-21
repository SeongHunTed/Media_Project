//
//  OrderDetailViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/06.
//

import UIKit

class OrderDetailViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        configure()
    }
    
    // MARK: - init
    var rootDetails: [String]
    var orderDetails: ([String] ,Int)

    init(orderDetails: ([String] ,Int), rootDetails: [String]) {
        self.rootDetails = rootDetails
        self.orderDetails = orderDetails
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Variables
    
    private let tableTitle = ["🍰 케이크", "🏠 스토어", "📅 픽업날짜", "⏰ 픽업시간", "🍴 옵션"]
    
    private var option: String = ""
    
    //MARK: - Components
    
    let optionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(OrderDetailTableViewCell.self, forCellReuseIdentifier: String(describing: OrderDetailTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func configure() {
        self.view.addSubview(optionView)
        self.optionView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        optionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        optionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7).isActive = true
        optionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        optionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        
        tableView.topAnchor.constraint(equalTo: optionView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: optionView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: optionView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: optionView.trailingAnchor).isActive = true
    }
    
}

extension OrderDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40.0))
        headerView.backgroundColor = .white
        
        let separatorView = UIView(frame: CGRect(x: 0, y: 39.0, width: tableView.frame.width, height: 1.0))
        separatorView.backgroundColor = .lightGray
        headerView.addSubview(separatorView)
        
        let titleLabel = UILabel(frame: CGRect(x: 16.0, y: 0, width: tableView.frame.width - 32.0, height: 40.0))
        titleLabel.text = "주문 정보"
        titleLabel.font = .systemFont(ofSize: 18.0, weight: .semibold)
        titleLabel.textColor = .black
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60.0))
        footerView.backgroundColor = .white
        
        let totalPriceLabel = UILabel(frame: CGRect(x: 16.0, y: 0, width: tableView.frame.width - 32.0, height: 30.0))
        totalPriceLabel.text = "총 가격: \(orderDetails.1)"
        totalPriceLabel.font = .systemFont(ofSize: 16.0, weight: .medium)
        totalPriceLabel.textColor = .black
        footerView.addSubview(totalPriceLabel)
        
        let orderButton = UIButton(type: .system)
        orderButton.frame = CGRect(x: 16.0, y: 30.0, width: tableView.frame.width - 32.0, height: 30.0)
        orderButton.setTitle("주문 신청하기", for: .normal)
        orderButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        orderButton.setTitleColor(.white, for: .normal)
        orderButton.backgroundColor = .systemRed.withAlphaComponent(0.8)
        orderButton.layer.cornerRadius = 8.0
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        footerView.addSubview(orderButton)
        return footerView
    }

    @objc private func orderButtonTapped() {
        print("Final Order Tapped")
        // 주문 정보 서버에 전송
        // 주문 완료 화면으로 이동
        self.dismiss(animated: true)
    }
}



extension OrderDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderDetailTableViewCell.self), for: indexPath) as? OrderDetailTableViewCell else {
                return UITableViewCell()
            }
        switch indexPath.row {
            case 0:
            cell.configure(tableTitle[0], rootDetails[0])
            case 1:
                cell.configure(tableTitle[1], rootDetails[1])
            case 2:
                cell.configure(tableTitle[2], rootDetails[2])
            case 3:
                cell.configure(tableTitle[3], rootDetails[3])
            case 4:
                cell.configure(tableTitle[4], optionParsing())
            default:
                break
            }
        return cell
    }
    
    func optionParsing() -> String {
        let optionString = orderDetails.0.joined(separator: "\n") + "\n"
        return optionString
    }
    
}

extension OrderDetailViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first , touch.view == self.view {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
