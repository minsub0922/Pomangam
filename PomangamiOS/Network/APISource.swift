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
    
    lazy var headers: HTTPHeaders? = {
        guard let model: TokenModel = UserDefaults.standard.getCustomObject(key: .accessToken) else {
            return nil
        }
        print(model.accessToken)
        return ["Authorization": "Bearer \(model.accessToken)"]
    }()
    
//    private func responseBody<T: Codable>(completion: @escaping (T) -> Void) -> (NetworkResult<(Int, T)>) {
//        return { (res: NetworkResult<(Int, T)>) in
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
    
    func getMainall(params: Parameters, completion: @escaping (ListAllMainResponse) -> Void) {
        get("/views/main", params: params, headers: headers) { (res: NetworkResult<(Int, ListAllMainResponse)>) in
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
    
    func getTokenGuest(completion: @escaping (TokenModel) -> Void) {
        let headers = [
            "Authorization": "Basic Z3Vlc3Q6c1pFSl45RV1la2pqLnt2Yw=="
        ]
        let params = [
            "grant_type": "client_credentials"
        ]
        
        post("/oauth/token", params: params, headers: headers) { (res: NetworkResult<(Int, TokenModel)>) in
            switch res {
            case .networkSuccess(let date):
                completion(date.1)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail")
            }
        }
    }
    
    func getDeliverySite(deliverySiteIndex: String, type: StoreType, orderBy: StoreOrderType? = nil, size: String? = nil, page: String? = nil, completion: @escaping ([Store]) -> Void) {
        //deliverySiteIdx=&type=&orderBy=&size=&page=
        let params = [
            "deliverySiteIdx": deliverySiteIndex,
            "type": type.rawValue,
            "orderBy": orderBy?.rawValue,
            "size": size,
            "page": page
            ] as [String : Any]
        
        //get("/stores/search/findByType", params: params, headers: headers, completion: responseBody(completion: completion))
    }
}
