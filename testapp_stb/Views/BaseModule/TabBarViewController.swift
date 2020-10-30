//
//  TabBarView.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/21.
//

import Foundation
import UIKit

enum TabItem {
    case home, history
    
    var title: String {
        switch self {
            case .home:
                return "Poker"
            case .history:
                return "履歴"
        }
    }
    
    var tag: Int {
        switch self {
            case .home:
                return 0
            case .history:
                return 1
        }
    }
    
    var tabController: UINavigationController {
        let navController = UINavigationController()
        switch self {
        case .home:
            let vc = HomeViewController()
            navController.setViewControllers([vc], animated: true)
        case .history:
            let vc = HistoryViewController()
            navController.setViewControllers([vc], animated: true)
        }
        navController.setNavigationBarHidden(true, animated: true)
        navController.title = self.title
        navController.tabBarItem.tag = self.tag
        navController.tabBarItem.image = #imageLiteral(resourceName: "icon-unselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "icon-selected")
        return navController
    }
}

class TabBarViewController: UITabBarController {
    var subviewControllers:[UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let subviewControllers = [TabItem.home.tabController, TabItem.history.tabController]
        setViewControllers(subviewControllers, animated: true)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    }
}
