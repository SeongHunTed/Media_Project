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
    
    var cakeOptionResponse: CakeOptionResponse?
    var cakeOptionRequest: CakeOptionRequest?
    
    init(cakeOptionRequest: CakeOptionRequest) {
        self.cakeOptionRequest = cakeOptionRequest
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func apiCall() {
        
        guard let cakeOptionRequest = self.cakeOptionRequest else {
            print("Error: cakeOptionRequest is nil")
            return
        }
        
        APIClient.shared.cake.fetchCakeOption(cakeOptionRequest) { [weak self] result in
            switch result {
            case .success(let cakeOptions):
                self?.cakeOptionResponse = cakeOptions
                self?.updateView()
                self?.collectionView.reloadData()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
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
            (key: \CakeOptionResponse.side_deco, title: "사이드데코"),
            (key: \CakeOptionResponse.deco, title: "데코"),
            (key: \CakeOptionResponse.picture, title: "디자인첨부"),
            (key: \CakeOptionResponse.design, title: "초")
        ]
        // 예제: 각 옵션의 개수를 출력합니다.
        for basicOptionTitle in basicOptionTitles {
            if let optionArray = cakeOptions[keyPath: basicOptionTitle.key], !optionArray.isEmpty {
                basicDropDownButtonTitle.append(basicOptionTitle.title)
                basicDropDownDataSource.append(optionArray.map { "\($0.optionName) + \($0.price)원" })
            }
        }
        
        for additionalOptionTitle in additionalOptionTitles {
            if let optionArray = cakeOptions[keyPath: additionalOptionTitle.key], !optionArray.isEmpty {
                addtionalDropDownButtonTitle.append(additionalOptionTitle.title)
                additionalDropDownDataSource.append(optionArray.map { $0.optionName })
            }
        }
    }
    
    private var basicDropDownButtonTitle: [String] = []
    private var addtionalDropDownButtonTitle: [String] = []
    
    private var basicDropDownDataSource: [[String]] = []
    private var additionalDropDownDataSource: [[String]] = []
    
    //MARK: - Temperally DataSource (Change When API connect)
    
    private var dataSource: [(String, Bool)] = [
        ("10:00", false), ("11:00", false), ("12:00", true), ("13:00", true), ("14:00", true), ("15:00", false), ("16:00", true)
    ]
    
    

    private var dropDownDataSource = [
        ["미니(+0원)", "1호(+0원)", "2호(0원)", "3호(+0원)"],
        ["바닐라(+0원)", "초코(+0원)", "블루베리(+500원)"],
        ["선택안함(+0원)", "프린트 최대 25자 입력(+0원)", "손글씨 최대 20자 입력(+0)"],
        ["선택안함(+0원)", "보냉포장(+500원)"],
        ["선택안함(+0원)", "선물포장(+1,500원)"]
    ]

    //MARK: - Variables
    lazy var today = calendar.today!
    
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
        let alertController = UIAlertController(title: "확인", message: "장바구니에 상품을 담았습니다!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
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
        let orderVC = OrderDetailViewController()
        present(orderVC, animated: true)
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
    
    //
    func setCalendarUI() {
        self.calendar.delegate = self
        self.calendar.dataSource = self
        
        self.calendar.appearance.headerDateFormat = "M월"
        self.calendar.appearance.headerTitleColor = UIColor.systemRed
        self.calendar.appearance.weekdayTextColor = UIColor.systemRed
        
        self.calendar.select(today)
    }
    
    // 이전 날짜 처리
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if (date < today) {
            return UIColor.systemGray5
        } else if date == today {
            return UIColor.systemRed.withAlphaComponent(0.45)
        }
        return UIColor.white
    }
    
    // 선택 날짜 처리
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor.systemRed.withAlphaComponent(0.95)
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
            return dataSource.count
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
            cell.timeButton.setTitle(dataSource[indexPath.item].0, for: .normal)
            cell.prepare(dataSource[indexPath.item].1)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OptionButtonCollectionViewCell.self), for: indexPath) as? OptionButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.optionButton.setTitle(basicDropDownButtonTitle[indexPath.item], for: .normal)
            cell.dropDown.dataSource = basicDropDownDataSource[indexPath.item]
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OptionButtonCollectionViewCell.self), for: indexPath) as? OptionButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.optionButton.setTitle(addtionalDropDownButtonTitle[indexPath.item], for: .normal)
            cell.dropDown.dataSource = additionalDropDownDataSource[indexPath.item]
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
