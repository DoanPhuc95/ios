//
//  Api.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/26.
//

import Foundation
import Alamofire

struct Production {
    static let BASE_URL: String = "http://p0kerhands.herokuapp.com/api/"
}

enum NetworkErrorType {
    case API_ERROR
    case HTTP_ERROR
}

enum APIRouter: URLRequestConvertible {
    case check(body: RequestCards)
    
    private var method: HTTPMethod {
        switch self {
        case .check:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .check:
            return "v1/cards/check"
        }
    }
    
    private var headers: HTTPHeaders {
        switch self {
        case .check:
            return ["Content-Type": "application/json"]
        }
    }
    
    private var httpBody: String? {
        do {
            switch self {
            case .check(let body):
                let jsonData = try JSONEncoder().encode(body)
                let json = String(data: jsonData, encoding: String.Encoding.utf8)
                return json
            }
        } catch { return nil }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try Production.BASE_URL.asURL()
        
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.httpBody = httpBody?.data(using: .utf8)
        
        for (k,v) in headers {
            urlRequest.addValue(v, forHTTPHeaderField: k)
        }
        
        return urlRequest
    }
}
