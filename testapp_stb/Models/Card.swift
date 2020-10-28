//
//  Card.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/26.
//

import Foundation
import ObjectMapper
import RealmSwift

class Card: Object {
    @objc dynamic var card: String?
    @objc dynamic var hand: String?
    @objc dynamic let date = NSDate()
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    
}
extension Card: Mappable {
    func mapping(map: Map) {
        card <- map["card"]
        hand <- map["hand"]
    }
}

class ErrorCard: Mappable {
    var card: String?
    var msg: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        card <- map["card"]
        msg <- map["msg"]
    }
}
