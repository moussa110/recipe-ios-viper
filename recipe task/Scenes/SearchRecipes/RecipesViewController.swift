//
//  ViewController.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import UIKit

class RecipesViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , RecipesViewProtocol , UISearchBarDelegate{
    
    var presenter: RecipesPresenterProtocol!
    private var query:String? = nil
    private var filterIndex = 0
  
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var recipesTableView: UITableView!
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        loading.hidesWhenStopped = true
        recipesTableView.tableFooterView = UIView(frame: .zero)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = ["ALL","Low Sugar","Keto","Vegan"]
        searchController.searchBar.showsScopeBar = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
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
    
    func showLoadingIndicator() {
        print("show loading indicator")
        
        //recipesTableView.isHidden = true
        loading.startAnimating()
    }
    
    func hideLoadingIndicator() {
        print("hide loading indicator")
        
        //recipesTableView.isHidden = false
        loading.stopAnimating()
    }
    
    func reloadData() {
        recipesTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        query = searchBar.text!
        presenter.searchRecipe(query: self.query! ,health:searchBar.selectedScopeButtonIndex ,from: 0 , to: 10)
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
        presenter.searchRecipe(query: query!, health: selectedScope ,from: 0 , to: 10)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.showsScopeBar = true
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if searchBar.text!.isEmpty && text == " " {return false}
        return searchTextIsValidate(text: text)
    }
    func searchTextIsValidate(text:String)->Bool{
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
                       let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
                       let typedCharacterSet = CharacterSet(charactersIn: text)
                       let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
                       return alphabet
    }
}

