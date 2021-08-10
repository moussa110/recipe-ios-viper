//
//  RecipeCell.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 05/08/2021.
//

import UIKit
import SDWebImage

class RecipeCell: UITableViewCell , ConfigureRecipesCellProtocol {
    //MARK: - OUTLET
    @IBOutlet weak var healthLabels: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
        
    }
    
    func configure(viewModel: RecipeViewModel) {
        
        recipeImage.sd_setImage(with: URL(string: viewModel.image))
        recipeTitle.text = viewModel.title
        recipeSource.text = viewModel.source
        var labels = ""
        for i in viewModel.healthLabels {
            labels.append("\(i) - ")
        }
        healthLabels.text = labels
    }
    
    
    func setupImageView() {
        recipeImage.layer.cornerRadius = recipeImage.frame.height/2
        recipeImage.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
    
}
