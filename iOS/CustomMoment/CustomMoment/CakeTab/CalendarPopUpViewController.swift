//
//  CalendarPopUpViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/31.
//

import UIKit
import FSCalendar

protocol CalendarPopUpDelegate: AnyObject {
    func didSelectDate(_ data: Date)
}


class CalendarPopUpViewController: UIViewController {
    
    weak var delegate: CalendarPopUpDelegate?
    
    lazy var today = calendar.today!
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.placeholderType = .none
        calendar.backgroundColor = .white
        calendar.layer.cornerRadius = 10
        calendar.tintColor = .systemRed.withAlphaComponent(0.8)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        configure()
        setCalendarUI()
    }
    
    private func configure() {
        self.view.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: self.view.bounds.width/1.5).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/2).isActive = true
        
        containerView.addSubview(calendar)
        
        calendar.widthAnchor.constraint(equalToConstant: self.view.bounds.width/1.5).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: self.view.bounds.height/2).isActive = true
        calendar.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        calendar.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        calendar.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        calendar.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first , touch.view == self.view {
            self.dismiss(animated: true, completion: nil)
        }
    }

}

// MARK: - Calendar UI/Action SetUp
extension CalendarPopUpViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
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
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate?.didSelectDate(date)
        dismiss(animated: true, completion: nil)
        
        
    }
}


