//
//  DatabaseManager.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/27.
//

import Foundation
import RealmSwift

protocol RealmDelegate {
    func recordSaved()
    func recordSavingFailed(error: NSError)
    func recordFetched(cards: [Card])
}
extension RealmDelegate {
    func recordSaved(){}
    func recordSavingFailed(error: NSError){}
    func recordFetched(cards: [Card]){}
}

class RealmManager: NSObject {
    let realm = try! Realm()
    var delegate: RealmDelegate?
    
    func saveRecord(card: Card) {
        try! realm.write {
            realm.add(card)
            delegate?.recordSaved()
        }
    }
    
    func getAllRecords() {
        let cards = realm.objects(Card.self)
        var cards_ = [Card]()
        for card in cards {
            cards_.append(card)
        }
        delegate?.recordFetched(cards: cards_)
    }
    
    func deleteAllRecords() {
        let cards = realm.objects(Card.self)
        print(cards.count)
        for card in cards {
            try! realm.write {
               realm.delete(card)
            }
        }
    }
}
