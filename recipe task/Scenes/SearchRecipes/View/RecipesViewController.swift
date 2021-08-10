//
//  ViewController.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import UIKit

//MARK: - VIEW CONTROLLER
class RecipesViewController: UIViewController {

  
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var recipesTableView: UITableView!
    @IBOutlet weak var exploreView: UIStackView!
    @IBOutlet weak var searchFailedView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    

    var presenter: RecipesPresenterProtocol!
    private var query:String? = nil
    private var filterIndex = 0
    private let searchController = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewes()
        initTableView()
        initSearchView()

    }

    private func initViewes(){
        searchFailedView.isHidden = true
        loading.hidesWhenStopped = true
    }
}


//MARK: - TABLE VIEW
extension RecipesViewController : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.recipesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeCell
        presenter.configureRecipesCell(cell: cell, indexPath: indexPath)
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.recipesCount - 1{
            presenter.getNextRecipesPage(query: query!, health: filterIndex)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.displayDetails(withIndex: indexPath.row)
    }
    
    private func initTableView(){
        recipesTableView.tableFooterView = UIView(frame: .zero)
    }
    
}

//MARK: - SEARCH VIEW
extension RecipesViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        query = searchBar.text!
        presenter.searchRecipe(query: self.query! ,health:searchBar.selectedScopeButtonIndex)
        searchController.searchBar.showsScopeBar = true
        searchController.isActive = false
        searchController.searchBar.text = query!
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchController.searchBar.showsScopeBar = false
        return true
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterIndex = selectedScope
        presenter.searchRecipe(query: query!, health: selectedScope )
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.showsScopeBar = true
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if searchBar.text!.isEmpty && text == " " {return false}
        return searchTextIsValidate(text: text)
    }
    
    private func searchTextIsValidate(text:String)->Bool{
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \n"
                       let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
                       let typedCharacterSet = CharacterSet(charactersIn: text)
                       let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
                       return alphabet
    }
    
    private func initSearchView(){
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = ["ALL","Low Sugar","Keto","Vegan"]
        searchController.searchBar.showsScopeBar = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    

}
//MARK: - VIEW PROTOCOL
extension RecipesViewController:RecipesViewProtocol{
    
    func showLoadingIndicator() {
        exploreView.isHidden = true
        searchFailedView.isHidden = true
        loading.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loading.stopAnimating()
    }
    
    func searchFailed(error: String) {
        searchFailedView.isHidden = false
        errorLabel.text = error
    }
    
    func reloadData() {
        if presenter.recipesCount != 0 {
            exploreView.isHidden = true
        }
        recipesTableView.reloadData()
    }
}
