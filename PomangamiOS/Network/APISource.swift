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
        return ["Authorization": "Bearer 9e65a842-8c2c-43dd-b6e7-a5cc33fa4b85)"]
    }()
    
    func getListallMain(params: Parameters, completion: @escaping (ListAllMainResponse) -> Void) {
        print(headers)
        get(API.getListallMain(), params: params, headers: headers) { (res: NetworkResult<(Int, ListAllMainResponse)>) in
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
