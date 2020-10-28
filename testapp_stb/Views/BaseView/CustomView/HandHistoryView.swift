//
//  HandHistoryView.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/22.
//

import Foundation
import UIKit

class HandHistoryView: BaseViewXib {
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var handLb: UILabel!
    @IBOutlet weak var resultLb: UILabel!
    @IBOutlet private weak var view: UIView!
    
    override func initView() {
        self.heightAnchor.constraint(equalToConstant: 62).isActive = true
        setBackground(color: .white)
        view.addBorder(vBorder: .bottom, color: Colors.border, width: 0.5)
    }
    
    func setData(hand: String, card: String, date: String) {
        resultLb.text = hand
        handLb.text = card
        timeLb.text = date
    }
}
