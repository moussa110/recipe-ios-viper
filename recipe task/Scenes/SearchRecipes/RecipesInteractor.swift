//
//  RecipesInteractor.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import Foundation
class RecipesInteractor : RecipesInteractorInputProtocol {
    weak var interactorOutput: RecipesInteractorOutputProtocol?
    
    private let networkHandler = NetworkHandler()
    
    func getRecipes(query:String,health:Int) {
        var healthParams:String=""
        
        switch health {
        case 1: healthParams = "low-sugar"
        case 2: healthParams = "keto-friendly"
        case 3: healthParams = "vegan"
        default:
            healthParams=""
        }
        networkHandler.getRecipes(query: query, health: healthParams) { [weak self] data, error in
            guard let self = self else{return}
            if let error = error{
                self.interactorOutput?.recipesFetchedFailed(withError: error)
            }else{
                self.interactorOutput?.recipesFetchedSuccessfully(recipes: data!)
            }
        }
    }
    
}


