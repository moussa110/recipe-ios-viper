//
//  RecipesRouter.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import UIKit

class RecipesRouter : RecipesRouterProtocol{
    
    weak var viewController:UIViewController?
    
    static func createModule()->UIViewController{
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "\(RecipesViewController.self)") as! RecipesViewController
        let interactor = RecipesInteractor()
        let router = RecipesRouter()
        let presenter = RecipesPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.interactorOutput = presenter
        print("doneee")
        router.viewController = view
        return view;
    }
    
}
