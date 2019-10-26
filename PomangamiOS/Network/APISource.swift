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
    
    var headers: HTTPHeaders? {
        guard let model: TokenModel = UserDefaults.standard.getCustomObject(key: .accessToken) else {
            return nil
        }
        print("access token is \(model.accessToken)")
        return ["Authorization": "Bearer \(model.accessToken)"]
    }
    
    private func commonResponseHandler<T>(completion: @escaping (T) -> Void) -> (NetworkResult<(Int, T)>) -> Void {
        return { (res: NetworkResult<(Int, T)>) in
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
    
    func getMainall(params: Parameters, completion: @escaping (ListAllMainResponse) -> Void) {
        get("/views/main",
            params: params,
            headers: headers,
            completion: commonResponseHandler(completion: completion))
    }
    
    func getTokenGuest(completion: @escaping (TokenModel) -> Void) {
        let headers = [
            "Authorization": "Basic Z3Vlc3Q6c1pFSl45RV1la2pqLnt2Yw=="
        ]
        let params = [
            "grant_type": "client_credentials"
        ]
        
        post("/oauth/token",
             params: params,
             headers: headers,
             completion: commonResponseHandler(completion: completion))
    }
    
    func getDeliveryMarkets(arrivalDate: String, detailForDeliverySiteIndex: Int, completion: @escaping ([DeliveryMarket]) -> Void) {
        let params = [
            "arrivalDate": arrivalDate,
            "detailForDeliverySiteIdx": detailForDeliverySiteIndex
        ] as [String: Any]
        
        get("/stores/search/getInquiryResult",
            params: params,
            headers: headers,
            completion: commonResponseHandler(completion: completion))
    }
    
    func getMarketDetail(storeIndex: Int, completion: @escaping (MarketDetailResponse) -> Void) {
        let params = [
            "storeIdx": storeIndex,
            ] as [String : Any]
        
        get("/stores/search/findWithCategory",
            params: params,
            headers: headers,
            completion: commonResponseHandler(completion: completion))
    }
    
    func getMarketComments(storeIndex: Int, orderBy: StoreOrderType?, size: String?, page: String?, completion: @escaping ([MarketCommentResponse]) -> Void) {
        var params = [
            "storeIdx": storeIndex,
            ] as [String : Any]
        
        if let orderBy = orderBy { params["orderBy"] = orderBy.rawValue }
        if let size = size { params["size"] = size }
        if let page = page { params["page"] = page }
        
        get("/commentStores/search/findByStoreIdx",
            params: params,
            headers: headers,
            completion: commonResponseHandler(completion: completion))
    }
    
    func getMenuList(storeIndex: Int, categoryId: Int? = nil, type: MenuType? = nil, orderBy: MenuOrder? = nil, size: Int? = nil, page: Int? = nil, completion: @escaping ([MenuResponse]) -> Void) {
        var params = [
            "storeIdx": storeIndex,
        ] as [String: Any]
        
        if let categoryId = categoryId { params["categoryId"] = categoryId }
        if let type = type { params["type"] = type }
        if let orderBy = orderBy { params["orderBy"] = orderBy.rawValue }
        if let size = size { params["size"] = size }
        if let page = page { params["page"] = page }
        
        get("/products/search/findByStoreIdx",
            params: params,
            headers: headers,
            completion: commonResponseHandler(completion: completion))
    }
    
    func getMenuDetail(productIndex: Int, completion: @escaping (MenuDetailResponse) -> Void) {
        let params = [
            "productIdx": productIndex
        ] as [String: Any]
        
        get("/products/search/getDetailOrder",
            params: params,
            headers: headers,
            completion: commonResponseHandler(completion: completion))
    }
    
    func getDeliveryArrivalPlaces(deliverySiteIdx: Int, completion: @escaping ([ArrivalPlaceResponse]) -> Void) {
        let params = ["deliverySiteIdx": deliverySiteIdx] as [String: Any]
        
        get("/detailForDeliverySites/search/findByDeliverySiteIdxOrderBySequence",
            params: params,
            headers: headers,
            completion: commonResponseHandler(completion: completion))
    }
    
//    func getAffiliateMarkets(deliverySiteIndex: String, type: StoreType, orderBy: StoreOrderType? = nil, size: String? = nil, page: String? = nil, completion: @escaping ([Market]) -> Void) {
//        //deliverySiteIdx=&type=&orderBy=&size=&page=
////        let params = [
////            "deliverySiteIdx": deliverySiteIndex,
////            "type": type.rawValue,
////            "orderBy": orderBy?.rawValue ?? "",
////            "size": size ?? "",
////            "page": page ?? ""
////            ] as [String : Any]
//
//        let params = [
//            "deliverySiteIdx": deliverySiteIndex,
//            "type": type.rawValue
//            ] as [String : Any]
//
//        //need to make struct or object for params !!!
//
//        get("/stores/search/findByType", params: params, headers: headers) { (res: NetworkResult<(Int, [Market])>) in
//            switch res {
//            case .networkSuccess(let data):
//                completion(data.1)
//            case .networkError(let error):
//                print(error)
//            case .networkFail:
//                print("Network Fail")
//            }
//        }
//
//        //get("/stores/search/findByType", params: params, headers: headers, completion: responseBody(completion: completion))
//    }
}


/////good example for send parameters
//
//struct NewUserParams: DictionaryEncodable {
//    var login_provider: LoginType
//    var access_token: String?
//    var email: String?
//    var password: String?
//    var name: String
//    var phone_number: String
//    var user_social_profile_image: Bool?
//    var birthday: String?
//    var gender: Gender?
//    var bjdong_code: String?
//    var referral: String?
//    var push_id: String?
//}
//
//func postUsers(_ params: NewUserParams, profileImage: UIImage?) -> Process<JSON, APIError> {
//    return multipartCall("/users", parameters: params.dictionary(), images: profileImage?.dictionary(withKey: "profile_image")).on(value: { json in
//        self.session.token = json["access_token"].string
//    })
//}
