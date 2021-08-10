//
//  RecipeDetailsProtocols.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 10/08/2021.
//

import Foundation
import UIKit

protocol RecipeDetailsViewProtocol:AnyObject {
    //MARK: - PROPERTY
    var presenter:RecipeDetailsPresenterProtocol! {get set}
    
    //MARK: - PRESENTER -> VIEW
    func displayRecipeDetails(recipe:RecipeViewModel)
}

protocol RecipeDetailsPresenterProtocol:AnyObject {
    //MARK: - PROPERTY
    var view:RecipeDetailsViewProtocol! {get set}
    var interactor:RecipeDetailsInteractorInputProtocol {get set}
    var router:RecipeDetailsRouterProtocol {get set}
    
    //MARK: - VIEW -> PRESENTER
    func viewDidLoad()
   
    
}

protocol RecipeDetailsInteractorInputProtocol:AnyObject{
    //MARK: - PROPERTY
    var presenter:RecipeDetailsInteractorOutputProtocol? {get set}
    var recipe:RecipeViewModel? {get set}
    
}

protocol RecipeDetailsInteractorOutputProtocol:AnyObject {
    
}

protocol RecipeDetailsRouterProtocol {
    static func createModule(withRecipe recipe:RecipeViewModel)->UIViewController
}
