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
    
    private lazy var db: RealmManager = {
        let realm = RealmManager()
        realm.delegate = self
        return realm
    }()
    
    override func viewDidLoad() {
        // init bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: ".SFUIText-Medium", size:17)!]
        let addButton = UIBarButtonItem(title: "追加", style: .plain, target: self, action: #selector(addButtonAction))
        addButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: ".SFUIText-Medium", size:17)!], for: .normal)
        self.navigationItem.rightBarButtonItems = [addButton]
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
    
    
    @IBAction func resultButtonClick(_ sender: Any) {
        if !isValidHand() { return }
        
        var hands:[String] = []
        for view in formsStackView.subviews {
            let form = view as? HandInputView
            hands.append((form?.getHandString())!)
        }
        
        var cards = RequestCards()
        cards.cards = hands
            
        MGConnection.request(APIRouter.check(body: cards), ResultResponse.self, completion: {(res, err) in
            guard err == nil else { return }
            // save to db
            for card in res!.result! {
                self.db.saveRecord(card: card)
            }
            // redirect to result view
            let resultViewController = ResultViewController()
            resultViewController.result = res
            self.navigationController?.pushViewController(resultViewController, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            self.title = ""
            self.formsStackView.removeAllSubviews()
            self.formsStackView.addArrangedSubview(HandInputView())
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Poker"
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func addButtonAction() {
        formsStackView.addArrangedSubview(HandInputView())
    }
    
    fileprivate func isValidHand() -> Bool {
        var isValid = true
        for view in formsStackView.subviews {
            let form = view as? HandInputView
            for card in form!.cards! {
                let isValidCard = card.getCardName().checkCardValidate()
                card.error(isErr: !isValidCard)
                isValid = isValid && isValidCard
            }
        }
        return isValid
    }
}
extension HomeViewController: RealmDelegate {
    func recordSaved() {}
    
    func RecordSavingFailed(error: NSError) {}
}
