//
//  RecipeDetailsRouter.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 10/08/2021.
//

import Foundation
import UIKit

class RecipeDetailsRouter:RecipeDetailsRouterProtocol{
    
    static func createModule(withRecipe recipe:RecipeViewModel) -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "\(RecipeDetailsViewController.self)") as! RecipeDetailsViewController
        let interactor = RecipeDetailsInteractor()
        let router = RecipeDetailsRouter()
        interactor.recipe = recipe
        let presenter = RecipeDetailsPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        return view;
    }
    
    
}
