//
//  MemberInfoViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/05.
//

import UIKit

class MemberInfoViewController: SignUpViewController {
    
    let email = "4047ksh@naver.com"
    let name = "Ted"
    let digit = "01025526374"
    let address = "경기도 고양시 일산동구 백석로 151 804동 1006호"
    let dateFormatter = DateFormatter()
    let birth = "1997-01-22"

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        super.signUpButton.setTitle("변경사항 저장", for: .normal)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        super.emailField.text = email
        super.emailField.textColor = .systemGray
        super.emailField.isEnabled = false
        super.emailField.clearButtonMode = .never
        super.nameField.text = name
        super.nameField.isEnabled = false
        super.nameField.textColor = .systemGray
        super.digitField.text = digit
        super.addressField.text = address
        super.birthField.date = dateFormatter.date(from: birth)!
        
    }
    
    
}

