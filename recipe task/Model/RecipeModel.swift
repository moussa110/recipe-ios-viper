import Foundation

// MARK: - RecipeResponse
struct RecipeModel:Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit:Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe:Codable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let dietLabels: [String]
    let healthLabels: [String]
    let ingredientLines:[String]
}

struct RecipeViewModel {
    var image:String
    var title:String
    var source:String
    var healthLabels:[String]
    let ingredientLines:[String]
    let url:String
    
    init(recipe:Recipe) {
        image = recipe.image
        title = recipe.label
        source = recipe.source
        healthLabels = recipe.healthLabels
        ingredientLines = recipe.ingredientLines
        url = recipe.url
    }
}
