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
        return ["Authorization": "Bearer 4ed25807-593a-4cd6-9832-0dd197d4252a"]
    }()
    
    func getMainall(params: Parameters, completion: @escaping (ListAllMainResponse) -> Void) {
        get("/views/main/", params: params, headers: headers) { (res: NetworkResult<(Int, ListAllMainResponse)>) in
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
    
    func getAdvertiseForPopupDto(params: Parameters, completion: @escaping ([AdvertiseDto]) -> Void) {
        get("/advertises/popup/", params: params, headers: headers) { (res: NetworkResult<(Int, [AdvertiseDto])>) in
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
