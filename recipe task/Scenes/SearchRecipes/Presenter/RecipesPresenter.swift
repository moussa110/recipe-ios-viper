//
//  RecipePresenter.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import Foundation

class RecipesPresenter : RecipesPresenterProtocol , RecipesInteractorOutputProtocol{
    func displayDetails(withIndex i:Int) {
        guard let view = view else { return }
        router.presentRecipeDetailScreen(from: view, for: RecipeViewModel(recipe: recipesData[i]))
    }
    
    var from: Int = 0
    
    var to: Int = 10
    
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
    
    weak var view: RecipesViewProtocol?
    private let interactor:RecipesInteractorInputProtocol
    private let router:RecipesRouterProtocol
    private var response:RecipeModel? = nil
    private var recipesData:[Recipe] = []
    
    
    init(view:RecipesViewProtocol , router:RecipesRouterProtocol , interactor:RecipesInteractorInputProtocol) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    var recipesCount: Int{
        return recipesData.count
    }
    
    
    func viewDidLoad() {
        print("view did load !!")
        
    }
    
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
    
    func configureRecipesCell(cell: RecipeCell, indexPath: IndexPath) {
        
        let viewModel = RecipeViewModel(recipe: recipesData[indexPath.row])
            cell.configure(viewModel: viewModel)
        
    }
    
    func searchRecipe(query q: String , health:Int , from:Int = 0 , to:Int = 10) {
        view?.showLoadingIndicator()
        recipesData = []
        view?.reloadData()
        self.from = 0
        self.to = 10
        interactor.getRecipes(query:q , health:health,from:from , to:to)
    }
    
    
}
