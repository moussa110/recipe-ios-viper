//
//  RecipeDetailsViewController.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 10/08/2021.
//

import UIKit
import SDWebImage

//MARK: - VIEW CONTROLLER
class RecipeDetailsViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingradientLabel: UILabel!
    
    var presenter: RecipeDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func visitWebsite(_ sender: Any) {
        UIApplication.shared.open(URL(string: presenter.interactor.recipe!.url)!)
    }
    @IBAction func shareWithOtherApps(_ sender: UIBarButtonItem) {
        if let url = URL(string: presenter.interactor.recipe!.url), !url.absoluteString.isEmpty {
            let objectsToShare = [url]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}

//MARK: - VIEW PROTOCOL
extension RecipeDetailsViewController:RecipeDetailsViewProtocol{
    func displayRecipeDetails(recipe: RecipeViewModel) {
        var ingradientLines = ""
        recipeImage.sd_setImage(with: URL(string: recipe.image))
        titleLabel.text = recipe.title
        for i in recipe.ingredientLines {
            ingradientLines = "\(ingradientLines + i).\n"
        }
        ingradientLabel.text = ingradientLines
    }
}

