//
//  StoreViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/03/29.
//

import UIKit

class StoreViewController: UIViewController {
    
    private lazy var logo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cake1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logo)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
