//
//  RecipesProtocols.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import Foundation

protocol RecipesViewProtocol : AnyObject {
    var presenter:RecipesPresenterProtocol! { get set }
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func reloadData()
    
}

protocol RecipesRouterProtocol {
    
}

protocol RecipesPresenterProtocol : AnyObject {
    var view:RecipesViewProtocol? { get set }
    func viewDidLoad()
    func searchRecipe(query q:String , health:Int)
    func configureRecipesCell(cell:RecipeCell , indexPath:IndexPath)
    var recipesCount:Int{get}
}

protocol RecipesInteractorInputProtocol {
    var interactorOutput:RecipesInteractorOutputProtocol? { get set }
    func getRecipes(query:String,health:Int)
}

protocol RecipesInteractorOutputProtocol:AnyObject {
    func recipesFetchedSuccessfully(recipes:RecipeModel)
    func recipesFetchedFailed(withError error:Error)
}

protocol ConfigureRecipesCellProtocol {
    func configure(viewModel:RecipeViewModel)
}
