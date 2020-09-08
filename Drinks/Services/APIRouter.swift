//
//  APIRouter.swift
//  Drinks
//
//  Created by Philip on 08.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case drinksCategories
    case drinksByCategory(_ category: String)
    
    private var method: HTTPMethod {
        switch self {
        case .drinksCategories:
            return .get
        case .drinksByCategory:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .drinksCategories:
            return APIConstants.list
        case .drinksByCategory:
            return APIConstants.filter
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .drinksCategories:
            return [APIParameterKey.drinkCategory: "list"]
        case .drinksByCategory(let category):
            return [APIParameterKey.drinkCategory: category]
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIConstants.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.httpMethod = method.rawValue

        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
       
        print(urlRequest)
        return urlRequest
    }
}
