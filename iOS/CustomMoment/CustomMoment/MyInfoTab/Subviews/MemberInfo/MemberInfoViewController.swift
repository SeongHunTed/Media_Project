//
//  MemberInfoViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/05.
//

import UIKit

class MemberInfoViewController: SignUpViewController {
    
    private var myInfo: MyInfoResponse?
    
    private var email = "4047ksh@naver.com"
    private var name = "Ted"
    private var digit = "01025526374"
    private var address = "경기도 고양시 일산동구 백석로 151 804동 1006호"
    private var dateFormatter = DateFormatter()
    private var birth = "1997-01-22"
    
    init(_ info: MyInfoResponse) {
        self.myInfo = info
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        super.signUpButton.setTitle("변경사항 저장", for: .normal)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        super.emailField.text = myInfo?.email
        super.emailField.textColor = .systemGray
        super.emailField.isEnabled = false
        super.emailField.clearButtonMode = .never
        super.nameField.text = myInfo?.name
        super.nameField.isEnabled = false
        super.nameField.textColor = .systemGray
        super.digitField.text = myInfo?.digit
        super.addressField.text = myInfo?.address
        super.birthField.date = dateFormatter.date(from: myInfo?.birth ?? "1997-01-22")!
        
    }
    
    
}

