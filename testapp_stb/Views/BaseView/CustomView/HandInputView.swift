//
//  HandInputView.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/21.
//

import Foundation

class HandInputView: BaseViewXib {
    
    @IBOutlet private weak var card1: CardInputView!
    @IBOutlet private weak var card2: CardInputView!
    @IBOutlet private weak var card3: CardInputView!
    @IBOutlet private weak var card4: CardInputView!
    @IBOutlet private weak var card5: CardInputView!
    var cards: [CardInputView]?
    
    func clearForm() {
        for card in cards! {
            card.clearContent()
        }
    }
    
    override func initView() {
        cards = [card1, card2, card3, card4, card5]
        for (i, card) in cards!.enumerated() {
            card.setTitle(title: "値\(i+1)")
        }
    }
    
    func getHandString() -> String {
        let cardValue1 = card1.cardName.text ?? ""
        let cardValue2 = card2.cardName.text ?? ""
        let cardValue3 = card3.cardName.text ?? ""
        let cardValue4 = card4.cardName.text ?? ""
        let cardValue5 = card5.cardName.text ?? ""
        return "\(cardValue1) \(cardValue2) \(cardValue3) \(cardValue4) \(cardValue5)"
    }
}
