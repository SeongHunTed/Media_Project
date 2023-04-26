//
//  OptionViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/24.
//

import UIKit
import FSCalendar
import DropDown

class MainOptionViewController: UIViewController {
    
    // MARK: - Models Var
    
    // cake option Reqeust, Response Model
    var cakeOptionResponse: CakeOptionResponse?
    var cakeOptionRequest: CakeOptionRequest?
    
    // time option Request, Response Model
    var orderResponse: TimeInfoResponse?
    var orderRequest: TimeInfoRequest?
    
    var cakePrice: Int
    
    // imagePicker에서 가져온 사진의 이름을 위한 변수
    var selectedCell: OptionButtonCollectionViewCell?
    
    init(cakeOptionRequest: CakeOptionRequest, orderRequest: TimeInfoRequest, cakePrice: Int) {
        self.cakeOptionRequest = cakeOptionRequest
        self.orderRequest = orderRequest
        self.cakePrice = cakePrice
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
        configure()
        setCalendarUI()
        setCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: calendarLabel.frame.size.height - 1, width: calendarLabel.frame.size.width - 10, height: 1)
        borderLayer.backgroundColor = UIColor.gray.withAlphaComponent(0.75).cgColor
        calendarLabel.layer.addSublayer(borderLayer)
    }
    
    // MARK: - API Call
    
    private var basicDropDownButtonTitle: [String] = []
    private var addtionalDropDownButtonTitle: [String] = []
    
    private var basicDropDownDataSource: [[CakeOption]] = []
    private var additionalDropDownDataSource: [[CakeOption]] = []
    
    private var timeDataSource: [(String, Bool)] = []
    
    private var availableCalendar: [(String, Bool)] = []
    
    private func apiCall() {
        
        guard let cakeOptionRequest = self.cakeOptionRequest else {
            print("Error: cakeOptionRequest is nil")
            return
        }
        
        // Available Date Call
        APIClient.shared.cake.fetchCalendar(self.cakeOptionRequest?.storeName ?? "") { [weak self] result in
            
            switch result {
            case .success(let calendarResponses):
                for calendarResponse in calendarResponses {
                    self?.availableCalendar.append((String(calendarResponse.date), calendarResponse.closed))
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        // Option Call
        APIClient.shared.cake.fetchCakeOption(cakeOptionRequest) { [weak self] result in
            switch result {
            case .success(let cakeOptions):
                self?.cakeOptionResponse = cakeOptions
                self?.updateView()
                self?.collectionView.reloadData()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                print("Here")
            }
        }
        
        guard let orderRequest = self.orderRequest else {
            print("Error: cakeOptionRequest is nil")
            return
        }
        
        // Available TIme Call
        APIClient.shared.cake.fetchTime(orderRequest) { [weak self] result in
            
            self?.timeDataSource.removeAll()
            
            switch result {
            case .success(let orderResponse):
                for group in orderResponse.group {
                    for time in group.time {
                        let timeString = time.pickupTime.prefix(5) // "10:00:00"을 "10:00"으로 변환
                        self?.timeDataSource.append((String(timeString), time.isAvailable))
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }
                    }
                }
            case .failure(let error):
                if error.localizedDescription == "204" {
                    let errorMessage = error.localizedDescription
                    print(errorMessage)
                } else {
                    print("Error: \(error.localizedDescription)")
                    print("Or")
                }
            }
        }
    }
    
    // Function That works when user click a date
    private func calendarApiCall(_ orderRequest: TimeInfoRequest) {
        APIClient.shared.cake.fetchTime(orderRequest) { [weak self] result in
            self?.timeDataSource.removeAll()
            switch result {
            case .success(let orderResponse):
                
                for group in orderResponse.group {
                    for time in group.time {
                        let timeString = time.pickupTime.prefix(5) // "10:00:00"을 "10:00"으로 변환
                        self?.timeDataSource.append((String(timeString), time.isAvailable))
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }
                    }
                }
            case .failure(let error):
                if error.localizedDescription == "204" {
                    let errorMessage = error.localizedDescription
                    print(errorMessage)
                } else {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func updateView() {
        guard let cakeOptions = cakeOptionResponse else { return }
        
        let basicOptionTitles = [
            (key: \CakeOptionResponse.size, title: "사이즈"),
            (key: \CakeOptionResponse.flavor, title: "맛"),
            (key: \CakeOptionResponse.color, title: "컬러"),
            (key: \CakeOptionResponse.design, title: "디자인"),
            (key: \CakeOptionResponse.package, title: "포장"),
        ]
        
        let additionalOptionTitles = [
            (key: \CakeOptionResponse.lettering, title: "레터링"),
            (key: \CakeOptionResponse.font, title: "폰트"),
            (key: \CakeOptionResponse.side_deco, title: "하판레터링"),
            (key: \CakeOptionResponse.deco, title: "데코"),
            (key: \CakeOptionResponse.picture, title: "디자인첨부"),
            (key: \CakeOptionResponse.design, title: "초")
        ]
        // 예제: 각 옵션의 개수를 출력합니다.
        for basicOptionTitle in basicOptionTitles {
            if let optionArray = cakeOptions[keyPath: basicOptionTitle.key], !optionArray.isEmpty {
                basicDropDownButtonTitle.append(basicOptionTitle.title)
                basicDropDownDataSource.append(optionArray.map { CakeOption(optionName: $0.optionName, price: $0.price) })
            }
        }
        
        for additionalOptionTitle in additionalOptionTitles {
            if let optionArray = cakeOptions[keyPath: additionalOptionTitle.key], !optionArray.isEmpty {
                addtionalDropDownButtonTitle.append(additionalOptionTitle.title)
                additionalDropDownDataSource.append(optionArray.map { CakeOption(optionName: $0.optionName, price: $0.price) })
            }
        }
    }
    
    //MARK: - Components
    lazy var today = calendar.today!
    // timebutton
    var selectedButton: UIButton?
    
    private let calendarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.myFontB.withSize(15.5)
        label.text = "📅 날짜 선택"
        label.textColor = .black.withAlphaComponent(0.8)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.placeholderType = .none
        calendar.appearance.titleFont = UIFont.myFontR.withSize(12)
        calendar.appearance.weekdayFont = UIFont.myFontM.withSize(14)
        calendar.appearance.headerTitleFont = UIFont.myFontM
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .white
        collectionView.register(TimeButtonCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TimeButtonCollectionViewCell.self))
        collectionView.register(OptionButtonCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: OptionButtonCollectionViewCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // Button 하단 뷰
    private let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("장바구니", for: .normal)
        button.titleLabel?.font = UIFont.myFontM.withSize(14.0)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        button.tintColor = .systemRed.withAlphaComponent(0.9)
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func cartButtonTapped() {
        
        let pickUpTime: String = selectedButton?.titleLabel?.text ?? ""
        let cakeName = cakeOptionRequest?.cakeName ?? ""
        let storeName = cakeOptionRequest?.storeName ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let pickUpDate = dateFormatter.string(from: calendar.selectedDate ?? today)
        let option = getOrderDetails().0.joined(separator: "\n") + "\n"
        
        let orderRequest = OrderRequest(storeName: storeName, cakeName: cakeName, cakePrice: cakePrice, pickupDate: pickUpDate, pickupTime: pickUpTime, option: option)
        
        APIClient.shared.order.registerCart(orderRequest) { [weak self] result in
            switch result {
            case .success(let message):
                print(message)
                let alertController = UIAlertController(title: "확인", message: "장바구니에 상품을 담았습니다!", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true)
                    guard let presentingViewController = self?.presentingViewController else { return }
                    presentingViewController.dismiss(animated: true) {
                        presentingViewController.presentingViewController?.dismiss(animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "확인", message: "로그인을 먼저 해주세요!", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true)
                }
            }
        }
    }
    
    private lazy var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.myFontM.withSize(14.0)
        button.setTitle("주문하기", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemRed.withAlphaComponent(0.9)
        button.tintColor = .white
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func orderButtonTapped() {
        
        if APIClient.shared.authToken == nil {
            let alertController = UIAlertController(title: "확인", message: "로그인을 먼저 해주세요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
        
        if areAllOptionSelected() {
            let selectedTime: String = selectedButton?.titleLabel?.text ?? ""
            let cake = cakeOptionRequest?.cakeName ?? ""
            let store = cakeOptionRequest?.storeName ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.string(from: calendar.selectedDate ?? today)
            let rootOption: [String] = [cake, store, date, selectedTime]
            
            let orderDetails = getOrderDetails()
            print(orderDetails)
            let orderVC = OrderDetailViewController(orderDetails: orderDetails, rootDetails: rootOption)
            present(orderVC, animated: true)
        } else {
            let alertController = UIAlertController(title: "확인", message: "모든 옵션을 선택해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
    
    //MARK: - Configure
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(calendarLabel)
        view.addSubview(calendar)
        view.addSubview(buttonView)
        buttonView.addSubview(cartButton)
        buttonView.addSubview(orderButton)
        view.addSubview(collectionView)
        
        calendarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        calendarLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        calendarLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        calendarLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        calendar.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor).isActive = true
        calendar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        calendar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        buttonView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        buttonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let buttonLayer = CALayer()
        buttonLayer.frame = CGRect(x: 0, y: buttonView.frame.origin.y, width: view.frame.width, height: 0.7)
        buttonLayer.backgroundColor = UIColor.black.cgColor
        buttonView.layer.addSublayer(buttonLayer)
        
        cartButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 15).isActive = true
        cartButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 15).isActive = true
        cartButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -15).isActive = true
        cartButton.widthAnchor.constraint(equalTo: buttonView.widthAnchor, multiplier: 0.45).isActive = true
        
        orderButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -15).isActive = true
        orderButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 15).isActive = true
        orderButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -15).isActive = true
        orderButton.widthAnchor.constraint(equalTo: buttonView.widthAnchor, multiplier: 0.45).isActive = true
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.topAnchor.constraint(equalTo: self.calendar.bottomAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.buttonView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

}


// MARK: - Calendar UI/Action SetUp
extension MainOptionViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func setCalendarUI() {
        self.calendar.delegate = self
        self.calendar.dataSource = self
        
        self.calendar.appearance.headerDateFormat = "M월"
        self.calendar.appearance.headerTitleColor = UIColor.systemRed
        self.calendar.appearance.weekdayTextColor = UIColor.systemRed
        
        self.calendar.select(today)
    }
    
    // 선택 가능여부 처리
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if date < today {
            return false
        }
        
        let dateString = dateFormatter.string(from: date)
        if let index = availableCalendar.firstIndex(where: { $0.0 == dateString}) {
            return !availableCalendar[index].1
        }
        return false
    }
    
    // 가능한 날짜는
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if date == today {
            return UIColor.systemRed.withAlphaComponent(0.7)
        } else if date < today {
            return UIColor.systemGray5
        } else if let index = availableCalendar.firstIndex(where: { $0.0 == dateString}) {
            if availableCalendar[index].1 {
                return UIColor.systemGray5
            } else {
                return UIColor.white
            }
        } else {
            return UIColor.systemGray5
        }
        
    }
    
    // 선택 날짜 처리
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor.systemRed.withAlphaComponent(0.95)
    }
    
    // 날짜 선택할 때 api 호출 하도록
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let currentDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: currentDate)
        let storeName = self.cakeOptionRequest?.storeName ?? ""
        
        let orderRequest = TimeInfoRequest(storeName: storeName, date: formattedDate)
        calendarApiCall(orderRequest)
    }
}


//MARK: - CollectioView SetUp, Action

extension MainOptionViewController {

    private func setCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutenvironment -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return self.pickUpTimeLayout()
            } else if sectionIndex == 1 {
                return self.basicOptionLayout()
            } else {
                return self.addtionalOptionLayout()
            }
        }
    }

    private func pickUpTimeLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(90), heightDimension: .fractionalHeight(0.8))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: .fractionalHeight(0.2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30.0))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }

    private func basicOptionLayout() -> NSCollectionLayoutSection {
        
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30.0))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func addtionalOptionLayout() -> NSCollectionLayoutSection {
        collectionView.register(MyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderView")
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30.0))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}


extension MainOptionViewController: UICollectionViewDelegate {
    
}

extension MainOptionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return timeDataSource.count
        } else if section == 1 {
            return basicDropDownButtonTitle.count
        } else {
            return addtionalDropDownButtonTitle.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeButtonCollectionViewCell.self), for: indexPath) as? TimeButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.onButtonTapped = { [weak self] button in
                self?.optionButtonTapped(button)
            }
            cell.timeButton.setTitle(timeDataSource[indexPath.item].0, for: .normal)
            cell.prepare(timeDataSource[indexPath.item].1)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OptionButtonCollectionViewCell.self), for: indexPath) as? OptionButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.optionButton.setTitle(basicDropDownButtonTitle[indexPath.item], for: .normal)
            cell.category = basicDropDownButtonTitle[indexPath.item]
            cell.dropDown.dataSource = basicDropDownDataSource[indexPath.item].map { "\($0.optionName) + \($0.price)원" }
            cell.onOptionSelected = { [weak self] index, title in
                cell.optionButton.setTitle(title, for: .normal)
                cell.optionButton.titleLabel?.font = UIFont.myFontB.withSize(14)
                cell.optionButton.backgroundColor = .systemRed.withAlphaComponent(0.8)
                cell.optionButton.tintColor = .white
                cell.optionButton.layer.borderColor = UIColor.systemRed.cgColor
                cell.selectedOption = self?.basicDropDownDataSource[indexPath.item][index]
            }
            cell.dropDown.selectionAction = cell.onOptionSelected
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OptionButtonCollectionViewCell.self), for: indexPath) as? OptionButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.optionButton.setTitle(addtionalDropDownButtonTitle[indexPath.item], for: .normal)
            cell.category = addtionalDropDownButtonTitle[indexPath.item]
            cell.dropDown.dataSource = additionalDropDownDataSource[indexPath.item].map { "\($0.optionName) + \($0.price)원" }
            cell.onOptionSelected = { [weak self] index, title in
                cell.optionButton.setTitle(title, for: .normal)
                cell.optionButton.titleLabel?.font = UIFont.myFontB.withSize(14)
                cell.optionButton.backgroundColor = .systemRed.withAlphaComponent(0.8)
                cell.optionButton.tintColor = .white
                cell.optionButton.layer.borderColor = UIColor.systemRed.cgColor
                cell.selectedOptionTitle = title
                cell.selectedOption = self?.additionalDropDownDataSource[indexPath.item][index]
                
                if (cell.category == "레터링" || cell.category == "하판레터링") && (title != "선택 안함 + 0원" && title != "선택안함 + 0원" ){
                    let alertController = UIAlertController(title: "레터링 입력", message: "레터링 내용을 입력하세요.", preferredStyle: .alert)
                    
                    alertController.addTextField { textField in
                        textField.placeholder = "레터링 내용"
                    }

                    let submitAction = UIAlertAction(title: "확인", style: .default) { _ in
                        if let inputText = alertController.textFields?.first?.text {
                            // 사용자가 입력한 레터링 내용을 처리합니다.
                            cell.selectedOptionTitle = inputText
                            cell.optionButton.setTitle("레터링 : " + inputText, for: .normal)
                        }
                    }
                    alertController.addAction(submitAction)

                    let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)

                    self?.present(alertController, animated: true, completion: nil)
                }
                
                if cell.category == "디자인첨부" {
                    self?.selectedCell = cell
                    let imagePickerController = UIImagePickerController()
                    imagePickerController.delegate = self
                    imagePickerController.sourceType = .photoLibrary

                    self?.present(imagePickerController, animated: true, completion: nil)
                }
            }
            cell.dropDown.selectionAction = cell.onOptionSelected
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderView", for: indexPath) as! MyHeaderView
            if indexPath.section == 0 {
                header.prepare(text: "⏱️ 픽업 시간")
            } else if indexPath.section == 1 {
                header.prepare(text: "🍰 기본 옵션")
            } else {
                header.prepare(text: "🍴 추가 옵션")
            }
            let borderLayer = CALayer()
            borderLayer.frame = CGRect(x: 10, y: header.frame.size.height - 1, width: header.frame.size.width - 20, height: 1)
            borderLayer.backgroundColor = UIColor.gray.withAlphaComponent(0.75).cgColor
            header.layer.addSublayer(borderLayer)
            
            return header
        }
        return UICollectionReusableView()
    }
}

extension MainOptionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            print("사용자가 선택한 이미지\(image)")
            selectedCell?.optionButton.setTitle("이미지 첨부완료", for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - 다음 주문내역을 이동시킬 정보를 위한 함수

extension MainOptionViewController {
    
    // 시간 선택 되었는지 체크
    // 나중에 처리
    
    // 모든 옵션이 선택 되었는지 체크
    private func areAllOptionSelected()-> Bool {
        for cell in collectionView.visibleCells {
            guard let optionCell = cell as? OptionButtonCollectionViewCell else { continue }
            if optionCell.selectedOption == nil {
                return false
            }
        }
        return true
    }
    
    // 모든 옵션을 가져오는 함수
    private func getOrderDetails() -> ([String], Int) {
        var orderDetails: [String] = []
        var totalPrice = cakePrice

        for cell in collectionView.visibleCells {
            guard let optionCell = cell as? OptionButtonCollectionViewCell else { continue }
            if let selectedOption = optionCell.selectedOption {
                
                if let selectedOptionTitle = optionCell.selectedOptionTitle {
                    if optionCell.category == "레터링" || optionCell.category == "하판레터링" {
                        orderDetails.append("\(optionCell.category ?? "") : \(selectedOptionTitle) + \(selectedOption.price)원")
                    }
                } else {
                    orderDetails.append("\(optionCell.category ?? "") : \(selectedOption.optionName) + \(selectedOption.price)원")
                }
                totalPrice += selectedOption.price
            }
        }
        return (orderDetails, totalPrice)
    }


    // 시간 옵션에 관련된 함수
    func optionButtonTapped(_ sender: UIButton) {
        if let previousSelectedButton = selectedButton {
            // 이전에 선택된 버튼의 상태 업데이트
            previousSelectedButton.backgroundColor = .white
            previousSelectedButton.tintColor = .systemRed.withAlphaComponent(0.8)
        }
        
        // 새로 선택된 버튼의 상태를 변경하고 selectedButton을 업데이트
        sender.backgroundColor = .systemRed
        sender.tintColor = .white
        selectedButton = sender
    }
}

