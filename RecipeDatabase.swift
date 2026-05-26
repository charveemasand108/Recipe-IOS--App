import Foundation

struct RecipeDatabase {

    static let recipes: [Recipe] = [

        Recipe(
            name: "Paneer Butter Masala",
            ingredients: ["paneer", "tomato", "butter", "cream"],
            instructions:
            """
            1. Heat butter in a pan.
            2. Add onions and tomatoes.
            3. Add spices.
            4. Add paneer cubes.
            5. Add cream and cook.
            """,
            category: "Indian",
            calories: 420,
            protein: 18,
            cookingTime: "25 mins",
            difficulty: "Medium",
            imageName: "paneer"
        ),

        Recipe(
            name: "Veg Pasta",
            ingredients: ["pasta", "cheese", "tomato"],
            instructions:
            """
            1. Boil pasta.
            2. Prepare tomato sauce.
            3. Mix pasta with sauce.
            4. Add cheese.
            """,
            category: "Italian",
            calories: 350,
            protein: 12,
            cookingTime: "20 mins",
            difficulty: "Easy",
            imageName: "pasta"
        ),

        Recipe(
            name: "Healthy Salad",
            ingredients: ["lettuce", "cucumber", "tomato"],
            instructions:
            """
            1. Chop vegetables.
            2. Mix everything.
            3. Add dressing.
            """,
            category: "Healthy",
            calories: 180,
            protein: 5,
            cookingTime: "10 mins",
            difficulty: "Easy",
            imageName: "salad"
        ),

        Recipe(
            name: "Cheese Omelette",
            ingredients: ["egg", "cheese", "onion"],
            instructions:
            """
            1. Beat eggs.
            2. Add onion and cheese.
            3. Cook on pan.
            """,
            category: "Breakfast",
            calories: 250,
            protein: 15,
            cookingTime: "8 mins",
            difficulty: "Easy",
            imageName: "omelette"
        )
    ]
}
