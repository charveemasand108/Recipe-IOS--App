import Foundation
import Combine

@MainActor
class RecipeViewModel: ObservableObject {

    @Published var selectedRecipe: Recipe?
    @Published var isLoading = false
    @Published var favorites: [Recipe] = []
    @Published var suggestions: [String] = []

    let ingredientSuggestions = [
        "paneer",
        "tomato",
        "cheese",
        "pasta",
        "milk",
        "egg",
        "onion",
        "butter",
        "potato"
    ]

    func generateRecipe(from ingredients: String) async {

        guard !ingredients.isEmpty else {
            return
        }

        isLoading = true

        try? await Task.sleep(nanoseconds: 1_000_000_000)

        let inputIngredients = ingredients
            .lowercased()
            .split(separator: ",")
            .map {
                $0.trimmingCharacters(in: .whitespaces)
            }

        var bestRecipe: Recipe?
        var bestScore = 0

        for recipe in RecipeDatabase.recipes {

            let score = inputIngredients.filter {
                recipe.ingredients.contains($0)
            }.count

            if score > bestScore {

                bestScore = score
                bestRecipe = recipe
            }
        }

        if let recipe = bestRecipe {

            selectedRecipe = recipe

        } else {

            selectedRecipe = Recipe(
                name: "Custom Recipe",
                ingredients: inputIngredients,
                instructions:
                """
                1. Heat oil in a pan.
                2. Add ingredients.
                3. Cook for 10 minutes.
                4. Add spices and serve hot.
                """,
                category: "Custom",
                calories: 300,
                protein: 10,
                cookingTime: "15 mins",
                difficulty: "Easy",
                imageName: "food"
            )
        }

        isLoading = false
    }

    func surpriseMe() {

        selectedRecipe = RecipeDatabase.recipes.randomElement()
    }

    func toggleFavorite(recipe: Recipe) {

        if favorites.contains(where: {$0.id == recipe.id}) {

            favorites.removeAll(where: {$0.id == recipe.id})

        } else {

            favorites.append(recipe)
        }
    }

    func isFavorite(recipe: Recipe) -> Bool {

        favorites.contains(where: {$0.id == recipe.id})
    }

    func updateSuggestions(text: String) {

        suggestions = ingredientSuggestions.filter {

            $0.contains(text.lowercased())
        }
    }
}
