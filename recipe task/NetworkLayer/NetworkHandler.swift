//
//  NetworkHandler.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import Foundation
import Alamofire

class NetworkHandler{
    
    func getRecipes(query q:String , health:String,from:Int=0,to:Int=10, compilation:@escaping(RecipeModel? ,String?)->Void) {
        
        var parameters:Parameters?=nil
        if(health.isEmpty){
            parameters = ["q":"\(q)",
                          "app_id":"\(Constants.appId)",
                          "app_key":"\(Constants.appKey)",
                          "from":from,
                          "to":to]
        }else{
            parameters = ["q":"\(q)" ,
                          "app_id":"\(Constants.appId)" ,
                          "app_key":"\(Constants.appKey)" ,
                          "health":"\(health)",
                          "from":from,
                          "to":to]
        }
        
        AF.request(Constants.baseURL+Constants.endpoint, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: nil, interceptor: nil, requestModifier: nil)
            .validate()
            .responseDecodable(of: RecipeModel.self) { (response) in
                switch response.result{
                case .success(let data):
                    if data.count == 0 {
                        compilation(nil,"no data found!")
                    }
                    compilation(data,nil)
                case .failure(let error):
                    if error.responseCode != 429{
                        compilation(nil,"search failed!")
                    }
                    
                }
                
            }
    }
}
