//
//  CardInputView.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/21.
//

import Foundation
import UIKit

class CardInputView: BaseViewXib {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet private weak var errorIcon: UIImageView!
    @IBOutlet private weak var errorText: UILabel!
    
    func setTitle(title: String) {
        self.title.text = title
    }
    
    func error(isErr: Bool) {
        errorIcon.isHidden = !isErr
        errorText.isHidden = !isErr
    }
    
    func clearContent() {
        error(isErr: false)
        cardName.text = ""
    }
    
    func getCardName() -> String {
        return cardName!.text ?? ""
    }
    
    @IBAction func textChanged(_ sender: Any) {
        error(isErr: false)
    }
}