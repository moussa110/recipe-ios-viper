//
//  RecipePresenter.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import Foundation

//MARK: - PRESENTER PROTOCOL
class RecipesPresenter : RecipesPresenterProtocol{
    
    weak var view: RecipesViewProtocol?
    var interactor:RecipesInteractorInputProtocol
    var router:RecipesRouterProtocol
    var from: Int = 0
    var to: Int = 10
    private var response:RecipeModel? = nil
    private var recipesData:[Recipe] = []
    
    init(view:RecipesViewProtocol , router:RecipesRouterProtocol , interactor:RecipesInteractorInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func displayDetails(withIndex i:Int) {
        guard let view = view else { return }
        router.presentRecipeDetailScreen(from: view, for: RecipeViewModel(recipe: recipesData[i]))
    }
    
    func getNextRecipesPage(query q:String , health:Int) {
        if let data = response{
            if data.more{
                from = to
                to = to + 10
                view?.showLoadingIndicator()
                interactor.getRecipes(query:q , health:health,from:from , to:to)
            }
        }
    }
    
    var recipesCount: Int{
        return recipesData.count
    }
    
    func configureRecipesCell(cell: RecipeCell, indexPath: IndexPath) {
        let viewModel = RecipeViewModel(recipe: recipesData[indexPath.row])
            cell.configure(viewModel: viewModel)
    }
    
    func searchRecipe(query q: String , health:Int) {
        view?.showLoadingIndicator()
        recipesData = []
        view?.reloadData()
        from = 0
        to = 10
        interactor.getRecipes(query:q , health:health,from:from , to:to)
    }
    
    
}

//MARK: - INTERACTOR OUTPUT
extension RecipesPresenter:RecipesInteractorOutputProtocol{
    func recipesFetchedSuccessfully(recipes: RecipeModel) {
        view?.hideLoadingIndicator()
        response = recipes
        for i in recipes.hits {
            recipesData.append(i.recipe)
        }
        view?.reloadData()
    }
    
    func recipesFetchedFailed(withError error: String) {
        view?.hideLoadingIndicator()
        view?.searchFailed(error: error)
        recipesData = []
        view?.reloadData()
    }
    

}
