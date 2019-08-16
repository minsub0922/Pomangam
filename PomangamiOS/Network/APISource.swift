//
//  APISource.swift
//  PomangamiOS
//
//  Created by 최민섭 on 15/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
import Alamofire



class APISource: APISourceProtocol {
    static let shared = APISource()
    
    lazy var headers: HTTPHeaders = {
        return ["Authorization": "Bearer 7e67d67d-df31-4373-b6dc-1a60d2cbce7f"]
    }()
    
    func getListallMain(params: Parameters, completion: @escaping (ListAllMainResponse) -> Void) {
        get("/v1/views/main/", params: params, headers: headers) { (res: NetworkResult<(Int, ListAllMainResponse)>) in
            switch res {
            case .networkSuccess(let data):
                completion(data.1)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail")
            }
        }
    }
    
    
    
    
    
//    func getPicturesPixay(params: Parameters, completion : @escaping (PixaPictures) -> Void) {
//        get(API.getPictures(), params: params) { (res: NetworkResult<(Int, PixaPictures)>) in
//            switch res {
//            case .networkSuccess(let data):
//                completion(data.1)
//            case .networkError(let error):
//                print(error)
//            case .networkFail:
//                print("Network Fail")
//            }
//        }
//    }
}
