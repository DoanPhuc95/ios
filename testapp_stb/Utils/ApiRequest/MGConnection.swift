//
//  MGConnection.swift
//  testapp_stb
//
//  Created by ゾアン ミン・フック on 2020/10/26.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class MGConnection {
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func request<T: Mappable>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: T?, _ error: BaseResponseError?) -> Void) {
    
        if !isConnectedToInternet() { return }
        
        Alamofire.request(apiRouter).responseJSON { (res) in
            switch res.result {
            case .success:
                print(res.result.value)
                let result = Mapper<T>().map(JSONObject:res.result.value)
                completion(result, nil)
                break
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error")
                    completion(nil, err)
                }
                break
            }
        }
//        Alamofire.request(apiRouter).responseObject {(response: DataResponse<BaseResponse<T>>) in
//            switch response.result{
//            case .success:
//                if response.response?.statusCode == 200 {
//                    print(response.result.value)
//                    if (response.result.value?.isSuccessCode())! {
//                        completion((response.result.value?.data)!, nil)
//                    } else {
//                        let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.API_ERROR, (response.result.value?.code)!, (response.result.value?.message)!)
//                        completion(nil, err)
//                    }
//                } else {
//                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is error!")
//                    completion(nil, err)
//                }
//                break
//
//            case .failure(let error):
//                if error is AFError {
//                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
//                    completion(nil, err)
//                }
//
//                break
//            }
//        }
    }
}
