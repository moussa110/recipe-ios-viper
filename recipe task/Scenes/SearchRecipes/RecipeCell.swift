//
//  RecipeCell.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import UIKit

class RecipeCell: UITableViewCell , ConfigureRecipesCellProtocol {

    @IBOutlet weak var healthLabels: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
        
    }
    
    func configure(viewModel: RecipeViewModel) {
        recipeTitle.text = viewModel.title
        recipeSource.text = viewModel.source
        healthLabels.text = viewModel.healthLabels[0]
    }

  
    func setupImageView() {
        recipeImage.layer.cornerRadius = recipeImage.frame.height/2
        recipeImage.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }

}
