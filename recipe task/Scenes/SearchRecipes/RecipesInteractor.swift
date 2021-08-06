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
    
    func getRecipes() {
        networkHandler.getRecipes(query: "fish", health: "low-sugar") { [weak self] data, error in
            guard let self = self else{return}
            if let error = error{
                self.interactorOutput?.recipesFetchedFailed(withError: error)
            }else{
                self.interactorOutput?.recipesFetchedSuccessfully(recipes: data!)
            }
        }
    }
    
  
    
}
