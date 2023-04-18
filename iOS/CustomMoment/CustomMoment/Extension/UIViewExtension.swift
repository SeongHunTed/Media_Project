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

extension UIFont {
    static let myFontM = UIFont(name: "NotoSansKR-Medium", size: 16.0)!
    static let myFontR = UIFont(name: "NotoSansKR-Regular", size: 10.0)!
    static let myFontB = UIFont(name: "NotoSansKR-Bold", size: 20.0)!
    static let myFontL = UIFont(name: "NotoSansKR-Light", size: 20.0)!
}

extension Notification.Name {
    static let didLoginSuccess = Notification.Name("didLoginSuccess")
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(from urlString: String) {
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to download image:", error)
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: urlString as NSString)
                self.image = image
            }
        }.resume()
    }
}
