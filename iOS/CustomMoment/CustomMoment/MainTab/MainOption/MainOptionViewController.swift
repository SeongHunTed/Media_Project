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
    
    //MARK: - Variables
    lazy var today = calendar.today!
    
    private let calendarLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "날짜 선택"
        label.textColor = .black.withAlphaComponent(0.8)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.placeholderType = .none
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
    
    //MARK: - Temperally DataSource (Change When API connect)
    
    private var dataSource = [
        ["10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00"],
        ["Section2"]
    ]
    
    private var dropDownButtonTitle = [
        "사이즈", "맛(시트+크림)", "레터링(케이크)", "포장(보냉백)", "포장(쇼핑백)"
    ]
    
    private var dropDownDataSource = [
        ["미니(+0원)", "1호(+0원)", "2호(0원)", "3호(+0원)"],
        ["바닐라(+0원)", "초코(+0원)", "블루베리(+500원)"],
        ["선택안함(+0원)", "프린트 최대 25자 입력(+0원)", "손글씨 최대 20자 입력(+0)"],
        ["선택안함(+0원)", "보냉포장(+500원)"],
        ["선택안함(+0원)", "선물포장(+1,500원)"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setCalendarUI()
        setCollectionView()
        
    }
    
    //MARK: - Configure
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(calendarLabel)
        view.addSubview(calendar)
        view.addSubview(collectionView)
        
        calendarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        calendarLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        calendarLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        calendarLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07).isActive = true
        
        calendar.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor).isActive = true
        calendar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        calendar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.topAnchor.constraint(equalTo: self.calendar.bottomAnchor, constant: 30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
            } else {
                return self.optionLayout()
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

    private func optionLayout() -> NSCollectionLayoutSection {
        
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
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return dataSource[0].count
        } else {
            return dropDownDataSource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeButtonCollectionViewCell.self), for: indexPath) as? TimeButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.timeButton.setTitle(dataSource[0][indexPath.item], for: .normal)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OptionButtonCollectionViewCell.self), for: indexPath) as? OptionButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.optionButton.setTitle(dropDownButtonTitle[indexPath.item], for: .normal)
            cell.dropDown.dataSource = dropDownDataSource[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeaderView", for: indexPath) as! MyHeaderView
            if indexPath.section == 0 {
                header.prepare(text: "픽업 시간")
            } else if indexPath.section == 1 {
                header.prepare(text: "옵션")
            }
            return header
        }
        return UICollectionReusableView()
    }
}
