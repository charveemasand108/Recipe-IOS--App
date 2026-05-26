import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = RecipeViewModel()
    @State private var ingredients = ""

    var body: some View {

        NavigationStack {

            ZStack {

                // BEAUTIFUL LIGHT BACKGROUND
                LinearGradient(
                    colors: [

                        Color(
                            red: 1.0,
                            green: 0.96,
                            blue: 0.96
                        ),

                        Color(
                            red: 0.98,
                            green: 0.94,
                            blue: 0.98
                        ),

                        Color(
                            red: 0.95,
                            green: 0.96,
                            blue: 1.0
                        )
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 24) {

                        // HEADER
                        HStack {

                            Text("🍳")
                                .font(.system(size: 42))

                            Text("AI Recipe Generator")
                                .font(
                                    .system(
                                        size: 34,
                                        weight: .bold
                                    )
                                )

                            Spacer()

                            Circle()
                                .fill(Color.white)
                                .frame(width: 55, height: 55)
                                .shadow(
                                    color: .black.opacity(0.05),
                                    radius: 10
                                )
                                .overlay(

                                    Image(
                                        systemName: "heart.fill"
                                    )
                                    .foregroundColor(.pink)
                                )
                        }
                        .padding(.horizontal)
                        .padding(.top)

                        // SEARCH BAR
                        HStack(spacing: 14) {

                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)

                            TextField(
                                "Enter ingredients...",
                                text: $ingredients
                            )
                            .font(.title3)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(24)
                        .shadow(
                            color: .black.opacity(0.05),
                            radius: 12
                        )
                        .padding(.horizontal)

                        // GENERATE BUTTON
                        Button {

                            Task {

                                await viewModel.generateRecipe(
                                    from: ingredients
                                )
                            }

                        } label: {

                            HStack(spacing: 10) {

                                Image(systemName: "sparkles")

                                Text("Generate Recipe")
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(

                                LinearGradient(
                                    colors: [
                                        .orange,
                                        .pink
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(24)
                            .shadow(
                                color: .orange.opacity(0.3),
                                radius: 12
                            )
                        }
                        .padding(.horizontal)

                        // SURPRISE BUTTON
                        Button {

                            viewModel.surpriseMe()

                        } label: {

                            HStack(spacing: 10) {

                                Text("🎲")

                                Text("Surprise Me")
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(24)
                            .shadow(
                                color: .orange.opacity(0.25),
                                radius: 10
                            )
                        }
                        .padding(.horizontal)

                        // LOADING
                        if viewModel.isLoading {

                            VStack(spacing: 14) {

                                ProgressView()

                                Text(
                                    "Analyzing ingredients..."
                                )
                                .foregroundColor(.gray)
                            }
                        }

                        // RECIPE CARD
                        if let recipe = viewModel.selectedRecipe {

                            VStack(
                                alignment: .leading,
                                spacing: 24
                            ) {

                                // TITLE
                                HStack {

                                    Text(recipe.name)
                                        .font(
                                            .system(
                                                size: 34,
                                                weight: .bold
                                            )
                                        )

                                    Spacer()

                                    Button {

                                        viewModel.toggleFavorite(
                                            recipe: recipe
                                        )

                                    } label: {

                                        Image(
                                            systemName:
                                                viewModel.isFavorite(
                                                    recipe: recipe
                                                )
                                                ? "heart.fill"
                                                : "heart"
                                        )
                                        .font(.title)
                                        .foregroundColor(.red)
                                    }
                                }

                                // INFO CARDS
                                HStack(spacing: 12) {

                                    miniCard(
                                        emoji: "🔥",
                                        title: "Calories",
                                        value:
                                            "\(recipe.calories)"
                                    )

                                    miniCard(
                                        emoji: "💪",
                                        title: "Protein",
                                        value:
                                            "\(recipe.protein)g"
                                    )

                                    miniCard(
                                        emoji: "⏱",
                                        title: "Time",
                                        value:
                                            recipe.cookingTime
                                    )

                                    miniCard(
                                        emoji: "📊",
                                        title: "Difficulty",
                                        value:
                                            recipe.difficulty
                                    )
                                }

                                Divider()

                                // CATEGORY
                                VStack(
                                    alignment: .leading,
                                    spacing: 10
                                ) {

                                    Text("Category")
                                        .font(.title3)
                                        .fontWeight(.semibold)

                                    Text(recipe.category)
                                        .foregroundColor(.orange)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 10)
                                        .background(

                                            Color.orange.opacity(0.1)
                                        )
                                        .cornerRadius(18)
                                }

                                Divider()

                                // INGREDIENTS
                                VStack(
                                    alignment: .leading,
                                    spacing: 14
                                ) {

                                    HStack {

                                        Image(systemName:
                                                "list.bullet"
                                        )
                                        .foregroundColor(.orange)

                                        Text("Ingredients")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                    }

                                    ForEach(
                                        recipe.ingredients,
                                        id: \.self
                                    ) { ingredient in

                                        HStack(spacing: 12) {

                                            Circle()
                                                .fill(Color.orange)
                                                .frame(
                                                    width: 8,
                                                    height: 8
                                                )

                                            Text(ingredient)
                                                .font(.body)
                                        }
                                    }
                                }

                                Divider()

                                // INSTRUCTIONS
                                VStack(
                                    alignment: .leading,
                                    spacing: 16
                                ) {

                                    HStack {

                                        Image(systemName:
                                                "list.number"
                                        )
                                        .foregroundColor(.purple)

                                        Text("Instructions")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                    }

                                    Text(recipe.instructions)
                                        .foregroundColor(
                                            .black.opacity(0.75)
                                        )
                                        .lineSpacing(8)
                                }

                                // SHARE BUTTON
                                ShareLink(
                                    item: recipe.instructions
                                ) {

                                    HStack(spacing: 10) {

                                        Image(
                                            systemName:
                                                "square.and.arrow.up"
                                        )

                                        Text("Share Recipe")
                                            .fontWeight(.bold)
                                    }
                                    .foregroundColor(.orange)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .overlay(

                                        RoundedRectangle(
                                            cornerRadius: 24
                                        )
                                        .stroke(
                                            Color.orange,
                                            lineWidth: 2
                                        )
                                    )
                                }
                            }
                            .padding(28)
                            .background(Color.white)
                            .cornerRadius(34)
                            .padding()
                            .shadow(
                                color: .black.opacity(0.08),
                                radius: 20,
                                x: 0,
                                y: 10
                            )
                        }

                        Spacer(minLength: 50)
                    }
                }
            }
        }
    }

    // MINI CARD
    func miniCard(
        emoji: String,
        title: String,
        value: String
    ) -> some View {

        VStack(spacing: 10) {

            Text(emoji)
                .font(.title3)

            Text(title)
                .font(.caption)

            Text(value)
                .fontWeight(.bold)
        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            Color.orange.opacity(0.08)
        )
        .cornerRadius(20)
    }
}

#Preview {

    ContentView()
}
