import Foundation

struct Recipe: Identifiable, Codable {

    let id = UUID()

    let name: String
    let ingredients: [String]
    let instructions: String
    let category: String
    let calories: Int
    let protein: Int
    let cookingTime: String
    let difficulty: String
    let imageName: String
}
