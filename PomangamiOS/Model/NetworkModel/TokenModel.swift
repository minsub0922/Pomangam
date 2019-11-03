//
//  TokenModel.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

struct TokenModel: Codable {
    var accessToken: String
    var tokenType: String
    var refreshToken: String? = nil
    var expireDate: Int
    var authScope: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case expireDate = "expires_in"
        case authScope = "scope"
    }
}
