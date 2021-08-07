//
//  NetworkHandler.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import Foundation
import Alamofire

class NetworkHandler{
    
    func getRecipes(query q:String , health:String, compilation:@escaping(RecipeModel? ,Error?)->Void) {
        
        var parameters:Parameters?=nil
        if(health.isEmpty){
            parameters = ["q":"\(q)",
                          "app_id":"\(Constants.appId)",
                          "app_key":"\(Constants.appKey)"]
        }else{
                parameters = ["q":"\(q)" ,
                              "app_id":"\(Constants.appId)" ,
                              "app_key":"\(Constants.appKey)" ,
                              "health":"\(health)"]
        }

        AF.request(Constants.baseURL+Constants.endpoint, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: nil, interceptor: nil, requestModifier: nil)
            .validate()
            .responseDecodable(of: RecipeModel.self) { (response) in
                switch response.result{
                case .success(let data):
                    compilation(data,nil)
                    print(data)
                case .failure(let error):
                    compilation(nil,error)
                    print(error)
                }

            }
    }
}
