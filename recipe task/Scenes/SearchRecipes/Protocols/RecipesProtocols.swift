//
//  RecipesProtocols.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import Foundation
import UIKit

protocol RecipesViewProtocol : AnyObject {
    var presenter:RecipesPresenterProtocol! { get set }
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func reloadData()
    func searchFailed(error:String)
    
}

protocol RecipesRouterProtocol {
    static func createModule()->UIViewController
    func presentRecipeDetailScreen(from view: RecipesViewProtocol, for recipe: RecipeViewModel)
}

protocol RecipesPresenterProtocol : AnyObject {
    var view:RecipesViewProtocol? { get set }
    var interactor:RecipesInteractorInputProtocol {get set}
    var router:RecipesRouterProtocol {get set}
    var from:Int {get}
    var to:Int {get}
    var recipesCount:Int{get}
    
    func searchRecipe(query q:String , health:Int)
    func getNextRecipesPage(query q:String , health:Int)
    func configureRecipesCell(cell:RecipeCell , indexPath:IndexPath)
    func displayDetails(withIndex i:Int)
    
}

protocol RecipesInteractorInputProtocol {
    var presenter:RecipesInteractorOutputProtocol? { get set }
    func getRecipes(query:String,health:Int,from:Int , to:Int)
}

protocol RecipesInteractorOutputProtocol:AnyObject {
    func recipesFetchedSuccessfully(recipes:RecipeModel)
    func recipesFetchedFailed(withError error:String)
}

protocol ConfigureRecipesCellProtocol {
    func configure(viewModel:RecipeViewModel)
}
