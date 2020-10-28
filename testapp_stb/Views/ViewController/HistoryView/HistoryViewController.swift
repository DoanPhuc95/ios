//
//  HistoryViewController.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/21.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var stackHistoryView: UIStackView!
    
    private lazy var db: RealmManager = {
            let realm = RealmManager()
            realm.delegate = self
            return realm
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        db.getAllRecords()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stackHistoryView.removeAllSubviews()
    }
    
    func initView() {
        view.backgroundColor = Colors.background
    }
}
extension HistoryViewController: RealmDelegate {
    func recordFetched(cards: [Card]) {
        for card in cards {
            let cardView = HandHistoryView()
            cardView.setData(hand: card.hand!, card: card.card!, date: card.date.stringValue())
            stackHistoryView.addArrangedSubview(cardView)
        }
    }
}
