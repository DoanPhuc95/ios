//
//  HandResultView.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/22.
//

import Foundation
import UIKit

class HandResultView: BaseViewXib {
    @IBOutlet weak var handLb: UILabel!
    @IBOutlet weak var cardLb: UILabel!
    
    override func initView() {
        heightAnchor.constraint(equalToConstant: 62).isActive = true
        layer.borderWidth = 0.5
        layer.borderColor = Colors.border.cgColor
    }
    
    func setData(hand: String, card: String) {
        handLb.text = hand
        cardLb.text = card
    }
}
