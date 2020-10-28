//
//  TabBarView.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/21.
//

import Foundation
import UIKit

//enum TabBarItem: Int {
//    case home, history
//
//    var viewController: UIViewController {
//        let viewController: UIViewController
//        switch self {
//            case .home:
//                let homeController = HomeViewController()
//                homeController.tabBarItem.image = #imageLiteral(resourceName: "bell")
//                homeController.tabBarItem.selectedImage = #imageLiteral(resourceName: "bellselected")
//                homeController.title = "Poker"
//                viewController = homeController
//            case .history:
//                let resultController = ResultViewController()
//                resultController.tabBarItem.image = #imageLiteral(resourceName: "bell")
//                resultController.tabBarItem.selectedImage = #imageLiteral(resourceName: "bellselected")
//                resultController.title = "結果"
//                viewController = resultController
//        }
//        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
//        viewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
//        return viewController
//    }
//}

class TabBarViewController: UITabBarController {
    var subviewControllers:[UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeController = generateNavController(vc: HomeViewController(), title: "Poker")
        let historyController = generateNavController(vc: HistoryViewController(), title: "履歴")
        
        let subviewControllers = [homeController, historyController]
        
        homeController.tabBarItem.image = #imageLiteral(resourceName: "icon-unselected")
        homeController.tabBarItem.selectedImage = #imageLiteral(resourceName: "icon-selected")
        homeController.tabBarItem.tag = 0
        historyController.tabBarItem.image = #imageLiteral(resourceName: "icon-unselected")
        historyController.tabBarItem.selectedImage = #imageLiteral(resourceName: "icon-selected")
        historyController.tabBarItem.tag = 1
        setViewControllers(subviewControllers, animated: true)
//        selectedIndex = 0
//        selectedViewController = homeController
        
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        navigationController?.tabBarItem.title = self.selectedViewController?.title
    }
    
    fileprivate func generateNavController(vc: UIViewController, title: String) -> UINavigationController {
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        return navController
    }
    
}
