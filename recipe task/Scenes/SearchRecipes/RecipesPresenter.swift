//
//  RecipePresenter.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import Foundation

class RecipesPresenter : RecipesPresenterProtocol , RecipesInteractorOutputProtocol{
    weak var view: RecipesViewProtocol?
    private let interactor:RecipesInteractorInputProtocol
    private let router:RecipesRouterProtocol
    private var data:RecipeModel? = nil
    
    init(view:RecipesViewProtocol , router:RecipesRouterProtocol , interactor:RecipesInteractorInputProtocol) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    var recipesCount: Int{
        if let data = data{
            return data.hits.count
        }else{
            return 0
        }
    }
    
    
    func viewDidLoad() {
        print("view did load !!")
        
    }
    
    func recipesFetchedSuccessfully(recipes: RecipeModel) {
        view?.hideLoadingIndicator()
        data = recipes
        view?.reloadData()
    }
    
    func recipesFetchedFailed(withError error: Error) {
        view?.hideLoadingIndicator()
    }
    
    func configureRecipesCell(cell: RecipeCell, indexPath: IndexPath) {
        if let recipe = data?.hits[indexPath.row].recipe{
        let viewModel = RecipeViewModel(recipe: recipe)
            cell.configure(viewModel: viewModel)
        }
    }
    
    func searchRecipe(query q: String , health:Int) {
        view?.showLoadingIndicator()
        interactor.getRecipes(query:q , health:health)
    }
    
    
}
