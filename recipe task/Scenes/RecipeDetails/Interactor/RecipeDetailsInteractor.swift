//
//  RecipeDetailsInteractor.swift
//  recipe task
//
//  Created by Mahmoud Mousa on 10/08/2021.
//

import Foundation
class RecipeDetailsInteractor:RecipeDetailsInteractorInputProtocol{
    weak var presenter: RecipeDetailsInteractorOutputProtocol?
    var recipe: RecipeViewModel?
}
