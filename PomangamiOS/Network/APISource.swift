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
        print("access token is \(model.accessToken)")
        return ["Authorization": "Bearer \(model.accessToken)"]
    }()
    
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
    
    func getDeliveryMarkets(arrivalDate: String, detailForDeliverySiteIndex: String, completion: @escaping ([DeliveryMarket]) -> Void) {
        let params = [
            "arrivalDate": arrivalDate,
            "detailForDeliverySiteIdx": detailForDeliverySiteIndex
        ] as [String: Any]
        
        get("/stores/search/getInquiryResult", params: params, headers: headers) { (res: NetworkResult<(Int, [DeliveryMarket])>) in
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
    
    func getAffiliateMarkets(deliverySiteIndex: String, type: StoreType, orderBy: StoreOrderType? = nil, size: String? = nil, page: String? = nil, completion: @escaping ([Market]) -> Void) {
        //deliverySiteIdx=&type=&orderBy=&size=&page=
//        let params = [
//            "deliverySiteIdx": deliverySiteIndex,
//            "type": type.rawValue,
//            "orderBy": orderBy?.rawValue ?? "",
//            "size": size ?? "",
//            "page": page ?? ""
//            ] as [String : Any]
        
        let params = [
            "deliverySiteIdx": deliverySiteIndex,
            "type": type.rawValue
            ] as [String : Any]
        
        //need to make struct or object for params !!!
        
        get("/stores/search/findByType", params: params, headers: headers) { (res: NetworkResult<(Int, [Market])>) in
            switch res {
            case .networkSuccess(let data):
                completion(data.1)
            case .networkError(let error):
                print(error)
            case .networkFail:
                print("Network Fail")
            }
        }
        
        //get("/stores/search/findByType", params: params, headers: headers, completion: responseBody(completion: completion))
    }
}
