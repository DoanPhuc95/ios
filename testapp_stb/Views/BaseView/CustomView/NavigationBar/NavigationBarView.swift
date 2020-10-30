//
//  NavigationBarView.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/29.
//

import Foundation
import UIKit

class NavigationBarView: BaseViewXib {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    override func initView() {
        navBar.topItem?.title = "Pk"
        navBar.backgroundColor = .red
//        let addButton = UIButton(title: "追加", style: .plain, target: self, action: #selector(addButtonAction))
//        let addButton = UIButton()
//        addButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: ".SFUIText-Medium", size:17)!], for: .normal)
//        navigationBar.topItem?.rightBarButtonItem = [addButton]
    }
    
    func setTitle(title: String) {
        navBar?.topItem!.title = title
//        navigationBar.topItem?.setT
    }
    
    @objc func addButtonAction() {}
}
