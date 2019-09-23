//
//  APISourceProtocol.swift
//  PomangamiOS
//
//  Created by 최민섭 on 15/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

//
//  Requestable.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
import Alamofire

struct API {
    static let baseURL = "https://www.pomangam.com:9530/api/v1"
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
}

enum NetworkResult<T> {
    case networkSuccess(T)
    case networkError((resCode: Int, msg: String))
    case networkFail
}

protocol APISourceProtocol {
    func get<T: Codable>(_ URL: String,
                         params: Parameters?,
                         headers: HTTPHeaders?,
                         completion: @escaping (NetworkResult<(Int, [T])>) -> Void)
    
    func post<T: Codable>(_ URL: String,
                          params: [String: Any]?,
                          headers: HTTPHeaders?,
                          completion: @escaping (NetworkResult<(Int, T)>) -> Void)
}

extension APISourceProtocol {
    /**
     Alamofire GET Method, NetworkResult에 따른 처리와 디코딩 작업
     
     - Parameters:
         - URL: Api endPoint
         - params: Query로 들어갈 파라미터
         - completion: NetworkResult reponse에 대한 결과 처리
     - Throws: If 'who' already dead, it throws some exception
     
     - Returns: Returns false if not available skill
     */
    func get<T: Codable>(_ URL: String,
                         params: Parameters? = nil,
                         headers: HTTPHeaders? = nil,
                         completion: @escaping (NetworkResult<(Int, T)>) -> Void) {
        guard let encodedUrl = (API.baseURL+URL).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("networking - invalid url")
            return
        }
        
        Alamofire.request(encodedUrl,
                          method: .get,
                          parameters: params,
                          headers: headers).responseData { (res) in
                            switch res.result {
                            case .success:
                                if let value = res.result.value {
                                    let decoder = JSONDecoder()
                                    do {
                                        let resCode = res.response?.statusCode ?? 0
                                        print(value)
                                        let datas = try decoder.decode(T.self, from: value)
                                        let result = (resCode, datas)
                                        completion(.networkSuccess(result))
                                    } catch {
                                        print("Decoding Err")
                                        print(res.response)
                                    }
                                }
                            case .failure(let err):
                                if let error = err as NSError?, error.code == -1009 {
                                    completion(.networkFail)
                                } else {
                                    let resCode = res.response?.statusCode ?? 0
                                    completion(.networkError((resCode, err.localizedDescription)))
                                }
                            }
        }
    }
    
    func get<T: Codable>(_ URL: String,
                         params: Parameters? = nil,
                         headers: HTTPHeaders? = nil,
                         completion: @escaping (NetworkResult<(Int, [T])>) -> Void) {
        guard let encodedUrl = (API.baseURL+URL).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("networking - invalid url")
            return
        }
        
        Alamofire.request(encodedUrl,
                          method: .get,
                          parameters: params,
                          headers: headers).responseData { (res) in
                            switch res.result {
                            case .success:
                                if let value = res.result.value {
                                    let decoder = JSONDecoder()
                                    do {
                                        let resCode = res.response?.statusCode ?? 0
                                        print(value)
                                        let datas = try decoder.decode([T].self, from: value)
                                        let result = (resCode, datas)
                                        completion(.networkSuccess(result))
                                    } catch {
                                        print("Decoding Err")
                                        print(res.response)
                                    }
                                }
                            case .failure(let err):
                                if let error = err as NSError?, error.code == -1009 {
                                    completion(.networkFail)
                                } else {
                                    let resCode = res.response?.statusCode ?? 0
                                    completion(.networkError((resCode, err.localizedDescription)))
                                }
                            }
        }
    }
    
    func post<T: Codable>(_ URL: String,
                          params: [String: Any]? = nil,
                          headers: HTTPHeaders? = nil,
                          completion: @escaping (NetworkResult<(Int, T)>) -> Void) {
        guard let encodedUrl = (API.baseURL+URL).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("networking - invalid url")
            return
        }
        
        Alamofire.request(encodedUrl,
                          method: .post,
                          parameters: params,
                          headers: headers).responseData { (res) in
                            switch res.result {
                            case .success:
                                if let value = res.result.value {
                                    let decoder = JSONDecoder()
                                    do {
                                        let resCode = res.response?.statusCode ?? 0
                                        print(resCode)
                                        let datas = try decoder.decode(T.self, from: value)
                                        let result = (resCode, datas)
                                        completion(.networkSuccess(result))
                                    } catch {
                                        print("Decoding Err")
                                    }
                                }
                            case .failure(let err):
                                if let error = err as NSError?, error.code == -1009 {
                                    completion(.networkFail)
                                } else {
                                    let resCode = res.response?.statusCode ?? 0
                                    completion(.networkError((resCode, err.localizedDescription)))
                                }
                            }
        }
        
    }
    
}


