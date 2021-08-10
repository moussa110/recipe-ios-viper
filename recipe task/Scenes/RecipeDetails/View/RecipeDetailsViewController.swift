//
//  RecipeDetailsViewController.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 10/08/2021.
//

import UIKit
import SDWebImage

class RecipeDetailsViewController: UIViewController , RecipeDetailsViewProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingradientLabel: UILabel!
    
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
    var presenter: RecipeDetailsPresenterProtocol!
    
    func displayRecipeDetails(recipe: RecipeViewModel) {
        var ingradientLines = ""
        recipeImage.sd_setImage(with: URL(string: recipe.image))
        titleLabel.text = recipe.title
        for i in recipe.ingredientLines {
            ingradientLines = "\(ingradientLines + i).\n"
        }
        ingradientLabel.text = ingradientLines
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

