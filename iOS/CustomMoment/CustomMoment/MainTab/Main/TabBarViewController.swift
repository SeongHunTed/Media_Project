//
//  TapBarViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/29.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let homeVC = HomeViewController()
    let cakeVC = CakeViewController()
    let storeVC = StoreViewController()
    let drawVC = DrawViewController()
    let myInfoVC = MyInfoViewController()
    
    private lazy var topBoarder: CALayer = {
        let boarder = CALayer()
        boarder.frame = CGRect(x:0, y:0, width: self.view.frame.width, height: 0.5)
        boarder.backgroundColor = UIColor.black.cgColor
        return boarder
    }()
    
    // 차후 변경 방향
    // homeVC.tabBarItem.image = UIImage.init(systemName: "house")
    func setTapBar() {
        
        self.tabBar.barTintColor = .white
        
        let redHome = UIImage(systemName: "house")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        let redCake = UIImage(systemName: "birthday.cake")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        let redStore = UIImage(systemName: "door.french.open")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        let redPencil = UIImage(systemName: "pencil.and.outline")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        let redInfo = UIImage(systemName: "person")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: redHome, tag: 0)
        cakeVC.tabBarItem = UITabBarItem(title: "Cake", image: redCake, tag: 1)
        storeVC.tabBarItem = UITabBarItem(title: "Store", image: redStore, tag: 2)
        drawVC.tabBarItem = UITabBarItem(title: "A.I", image: redPencil, tag: 3)
        myInfoVC.tabBarItem = UITabBarItem(title: "My Info", image: redInfo, tag: 4)
        
        
        setViewControllers([homeVC, cakeVC, storeVC, drawVC, myInfoVC], animated: false)
        
        self.tabBar.tintColor = .systemRed.withAlphaComponent(1.0)
        self.tabBar.backgroundColor = .white
        self.tabBar.layer.addSublayer(topBoarder)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
            
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapBar()
        // selectedIndex = 0
    }
    
}
