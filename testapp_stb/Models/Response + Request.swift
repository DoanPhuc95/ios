//
//  Result.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/26.
//

import Foundation
import ObjectMapper

class ResultResponse: Mappable {
    var result: [Card]?
    var error: [ErrorCard]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        result <- map["result"]
        error <- map["error"]
    }
}

struct RequestCards: Codable{
    var cards: [String]?
}
