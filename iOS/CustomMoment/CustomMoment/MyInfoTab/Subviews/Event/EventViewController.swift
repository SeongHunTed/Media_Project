//
//  EventViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/08.
//

import UIKit

class EventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

}
