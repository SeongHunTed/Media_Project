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

extension UIView {
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UICollectionViewDelegate {
    func currentItem(_ collectioView: UICollectionView, _ indexPath: IndexPath) -> Int {
        if indexPath.section == 0 {
            return indexPath.item
        }
        return 0
    }
}
