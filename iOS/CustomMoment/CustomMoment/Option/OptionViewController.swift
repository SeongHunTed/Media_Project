//
//  OptionViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/24.
//

import UIKit
import FSCalendar

class OptionViewController: UIViewController {
    
    //MARK: - Variables
    lazy var today = calendar.today!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        setCalendarUI()
    }
    
    //MARK: - Configure
    
    private func configure() {
        
        view.addSubview(calendarLabel)
        view.addSubview(calendar)
        self.view.addSubview(scrollView)
        
        calendarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        calendarLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        calendarLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        calendarLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.09).isActive = true
        
        calendar.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor).isActive = true
        calendar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        calendar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        
        
        
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        
        
    }

}


// MARK: - Calendar UI/Action SetUp
extension OptionViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
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
