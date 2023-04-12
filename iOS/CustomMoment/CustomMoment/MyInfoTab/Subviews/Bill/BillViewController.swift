//
//  BillViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/09.
//

import UIKit

class BillViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        configure()
    }
    
    //MARK: - Variables
    
    private let tableModel = [["🍰 케이크","테스트 케이크"], ["🏠 스토어","테스트 가게"], ["📅 픽업날짜", "0000-00-00"], ["⏰ 픽업시간","00:00"], ["🍴 옵션","케이크 사이즈 : 도시락\n케이크 맛 : 바닐라\n케이크 색상 : 기본\n케이크 디자인 : 동물\n케이크 사이드 데코레이션 : 사이드 데코\n케이크 데코레이션 : 악세시리\n케이크 레터링 : 케이크\n케이크 폰트 : 궁서체\n케이크 사진 : 예\n케이크 포장 : 기본\n초 : 숫자초 "]]
    
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


extension BillViewController: UITableViewDelegate {
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
        titleLabel.font = UIFont.myFontM.withSize(18.0)
        titleLabel.textColor = .black
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60.0))
        footerView.backgroundColor = .white
        
        let totalPriceLabel = UILabel(frame: CGRect(x: 16.0, y: 0, width: tableView.frame.width - 32.0, height: 30.0))
        totalPriceLabel.text = "총 가격: 38,000원"
        totalPriceLabel.font = UIFont.myFontM.withSize(16.0)
        totalPriceLabel.textColor = .black
        footerView.addSubview(totalPriceLabel)
        
        return footerView
    }

}



extension BillViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderDetailTableViewCell.self), for: indexPath) as? OrderDetailTableViewCell else {
                return UITableViewCell()
            }
        switch indexPath.row {
            case 0:
                cell.configure(tableModel[0][0], tableModel[0][1])
            case 1:
                cell.configure(tableModel[1][0], tableModel[1][1])
            case 2:
                cell.configure(tableModel[2][0], tableModel[2][1])
            case 3:
                cell.configure(tableModel[3][0], tableModel[3][1])
            case 4:
                cell.configure(tableModel[4][0], tableModel[4][1])
            default:
                break
            }
        return cell
    }
    
}

extension BillViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first , touch.view == self.view {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
