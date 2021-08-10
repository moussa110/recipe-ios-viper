//
//  RecipeDetailsPresenter.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 10/08/2021.
//

import Foundation
class RecipeDetailsPresenter : RecipeDetailsPresenterProtocol , RecipeDetailsInteractorOutputProtocol{
    
    weak var view: RecipeDetailsViewProtocol!
    var interactor: RecipeDetailsInteractorInputProtocol
    var router: RecipeDetailsRouterProtocol
    
    init(view:RecipeDetailsViewProtocol ,
         interactor:RecipeDetailsInteractorInputProtocol,
         router:RecipeDetailsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        if let recipe = interactor.recipe{
            view.displayRecipeDetails(recipe: recipe)
        }
    }
    
}

