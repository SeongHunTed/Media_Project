//
//  CalendarCollectionViewCell.swift
//  CustomMoment
//
//  Created by Hoon on 2023/05/17.
//

import UIKit
import FSCalendar

class CalendarCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CalendarCellDelegate?
    
    lazy var today: Date = {
        let today = calendar.today!
        delegate?.calendarCellToday(self, getToday: today)
        return today
    }()
    
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.placeholderType = .none
        calendar.appearance.titleFont = UIFont.myFontR.withSize(12)
        calendar.appearance.weekdayFont = UIFont.myFontR.withSize(12)
        calendar.appearance.headerTitleFont = UIFont.myFontM
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: contentView.topAnchor),
            calendar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            calendar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CalendarCollectionViewCell: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func setCalendarUI() {
        self.calendar.delegate = self
        self.calendar.dataSource = self
        
        self.calendar.appearance.headerDateFormat = "M월"
        self.calendar.appearance.headerTitleColor = UIColor.black
        self.calendar.appearance.weekdayTextColor = UIColor.black
        
        self.calendar.select(today)
    }
    
    
    // 선택 날짜 처리
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor.systemRed.withAlphaComponent(0.95)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate?.calendarCell(self, didSelect: date)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return ((delegate?.calendarCell(self, shouldSelect: date, at: monthPosition)) != nil)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return delegate?.calendarCell(self, appearance: appearance, fillDefaultColorFor: date)
    }
    
    
}
