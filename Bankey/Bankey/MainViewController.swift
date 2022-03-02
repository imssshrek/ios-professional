//
//  MainViewController.swift
//  Bankey
//
//  Created by Hanori on 2022/03/02.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupTabBar()
    }
    
    private func setupViews() {
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()
        
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        summaryNC.navigationBar.barTintColor = appColor
        self.hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC, moneyNC, moreNC]
        
        self.viewControllers = tabBarList
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    
    private func setupTabBar() {
        self.tabBar.tintColor = appColor
        self.tabBar.isTranslucent = false
    }
}

class AccountSummaryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
    }
}

class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemOrange
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPurple
    }
}

