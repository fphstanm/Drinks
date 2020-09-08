//
//  ApiService.swift
//  Drinks
//
//  Created by Philip on 07.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import Alamofire

class ApiService {
    
    static func getDrinks(byCategory: String, completion: @escaping (Result<Drinks, AFError>) -> Void) {
        AF.request(APIRouter.drinksByCategory(byCategory))
            .responseDecodable { (response: DataResponse<Drinks,AFError>) in
                completion(response.result)
        }
    }
    
    static func getDrinksCategories(completion: @escaping (Result<DrinkCategories, AFError>) -> Void) {
        AF.request(APIRouter.drinksCategories)
            .responseDecodable { (response: DataResponse<DrinkCategories,AFError>) in
                completion(response.result)
        }
    }
    
}
