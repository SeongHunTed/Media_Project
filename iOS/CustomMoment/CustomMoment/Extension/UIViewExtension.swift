//
//  UIViewExtension.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/20.
//

import UIKit

extension UIView {
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}
