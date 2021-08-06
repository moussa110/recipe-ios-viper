//
//  ViewController.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import UIKit

class RecipesViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , RecipesViewProtocol{
    
    var presenter: RecipesPresenterProtocol!
    
    @IBOutlet weak var recipesTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.recipesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeCell
        presenter.configureRecipesCell(cell: cell, indexPath: indexPath)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showLoadingIndicator() {
        print("show loading indicator")
    }
    
    func hideLoadingIndicator() {
        print("hide loading indicator")
    }
    
    func reloadData() {
        recipesTableView.reloadData()
    }


}

