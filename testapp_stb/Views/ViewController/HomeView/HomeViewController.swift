//
//  HomeViewController.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/12.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet private weak var formsStackView: UIStackView!
    @IBOutlet private weak var resultButton: UIButton!
    @IBOutlet weak var navBarview: UIView!
    
    
    private lazy var db: RealmManager = {
        let realm = RealmManager()
        realm.delegate = self
        return realm
    }()
    
    override func viewDidLoad() {
        // init bar
        navBarview.addBorder(vBorder: .bottom, color: Colors.border, width: 0.5)
        // init view
        view.backgroundColor = Colors.background
        resultButton.layer.cornerRadius = 8        
        // set keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillClose), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @IBAction func resultButtonClick(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        if !isValidHand() {
            sender.isUserInteractionEnabled = true
            return
        }
        
        showIndicator()
        var hands:[String] = []
        for view in formsStackView.subviews {
            let form = view as? HandInputView
            hands.append((form?.getHandString())!)
        }
        var cards = RequestCards()
        cards.cards = hands
            
        MGConnection.request(APIRouter.check(body: cards), ResultResponse.self, completion: {(res, err) in
            if let e = err {
                let message = e.mErrorMessage ?? "エラーが発生した"
                self.showAnnounceDialog(message: message)
                return
            }
            // save to db
            if let result = res {
                if let cards = result.result {
                    for card in cards {
                        self.db.saveRecord(card: card)
                    }
                }
            }
            // redirect to result view
            self.dismissIndicator()
            let resultViewController = ResultViewController()
            resultViewController.result = res
            self.navigationController?.pushViewController(resultViewController, animated: true)
            self.formsStackView.removeAllSubviews()
            self.formsStackView.addArrangedSubview(HandInputView())
            
            sender.isUserInteractionEnabled = true
        })
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        formsStackView.addArrangedSubview(HandInputView())
    }
    
    fileprivate func isValidHand() -> Bool {
        var isValid = true
        for view in formsStackView.subviews {
            let form = view as? HandInputView
            for card in form!.cards! {
                let cardInputCheck = card.getCardName().checkCardValidate()
                card.error(isErr: !cardInputCheck.isValid, textErr: cardInputCheck.errorText)
                isValid = isValid && cardInputCheck.isValid
            }
        }
        return isValid
    }
}
extension HomeViewController: RealmDelegate {
    func recordSaved() {}
    
    func RecordSavingFailed(error: NSError) {}
}
