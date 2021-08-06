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
}

struct RecipeViewModel {
    var image:String
    var title:String
    var source:String
    var healthLabels:[String]
    
    init(recipe:Recipe) {
        image = recipe.image
        title = recipe.label
        source = recipe.source
        healthLabels = recipe.healthLabels
    }
}

/*

// MARK: - Digest
struct Digest:Codable {
    let label, tag: String
    let schemaOrgTag: String?
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: String
    let sub: [Digest]?
}

// MARK: - Ingredient
struct Ingredient:Codable {
    let text: String
    let weight: Double
    let foodCategory: String?
    let foodID: String
    let image: String?
}

// MARK: - Total
struct Total:Codable {
    let label: String
    let quantity: Double
    let unit: String
}

struct RecipeViewModel {
    var image:String
    var title:String
    var source:String
    var healthLabels:[String]
    
    init(recipe:Recipe) {
        image = recipe.image
        title = recipe.label
        source = recipe.source
        healthLabels = recipe.healthLabels
    }
}
*/
