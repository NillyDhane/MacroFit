import Foundation

struct MockData {
    static let meals = [
        // High Protein Breakfast Options
        Meal(
            name: "Protein Power Bowl",
            imageName: "breakfast1",
            calories: 450,
            protein: 35,
            carbs: 40,
            fats: 15,
            mealType: .breakfast,
            ingredients: [
                "3 egg whites",
                "1 whole egg",
                "1/2 cup oatmeal",
                "1 cup spinach",
                "1/4 avocado",
                "Hot sauce"
            ],
            instructions: [
                "Cook oatmeal according to package directions",
                "Scramble eggs with spinach",
                "Top oatmeal with eggs",
                "Add sliced avocado",
                "Season with hot sauce"
            ],
            prepTime: 15,
            restrictions: [.vegetarian, .glutenFree, .nutFree]
        ),
        
        Meal(
            name: "Greek Yogurt Parfait",
            imageName: "breakfast2",
            calories: 380,
            protein: 30,
            carbs: 45,
            fats: 8,
            mealType: .breakfast,
            ingredients: [
                "1 cup Greek yogurt (non-fat)",
                "1/2 cup mixed berries",
                "2 tbsp granola",
                "1 tbsp honey",
                "1 scoop protein powder"
            ],
            instructions: [
                "Mix protein powder into Greek yogurt",
                "Layer yogurt and berries in a glass",
                "Top with granola",
                "Drizzle with honey"
            ],
            prepTime: 5,
            restrictions: [.vegetarian, .glutenFree, .nutFree]
        ),
        
        // Lunch Options
        Meal(
            name: "Grilled Chicken Caesar Salad",
            imageName: "lunch1",
            calories: 520,
            protein: 45,
            carbs: 25,
            fats: 22,
            mealType: .lunch,
            ingredients: [
                "6 oz grilled chicken breast",
                "2 cups romaine lettuce",
                "2 tbsp Caesar dressing",
                "1/4 cup parmesan cheese",
                "Croutons"
            ],
            instructions: [
                "Grill chicken breast with seasoning",
                "Chop romaine lettuce",
                "Slice grilled chicken",
                "Toss lettuce with dressing",
                "Top with chicken, cheese, and croutons"
            ],
            prepTime: 20,
            restrictions: []
        ),
        
        Meal(
            name: "Tuna Poke Bowl",
            imageName: "lunch2",
            calories: 485,
            protein: 38,
            carbs: 52,
            fats: 12,
            mealType: .lunch,
            ingredients: [
                "5 oz sushi-grade tuna",
                "1 cup cooked brown rice",
                "1/2 avocado",
                "Edamame",
                "Cucumber",
                "Soy sauce",
                "Sesame seeds"
            ],
            instructions: [
                "Cook brown rice and let cool",
                "Cube tuna into bite-sized pieces",
                "Slice avocado and cucumber",
                "Arrange everything in a bowl",
                "Drizzle with soy sauce and sesame seeds"
            ],
            prepTime: 25,
            restrictions: [.dairyFree, .nutFree]
        ),
        
        // Dinner Options
        Meal(
            name: "Lean Beef Stir-Fry",
            imageName: "dinner1",
            calories: 580,
            protein: 42,
            carbs: 48,
            fats: 18,
            mealType: .dinner,
            ingredients: [
                "6 oz lean beef sirloin",
                "Mixed vegetables",
                "1 cup jasmine rice",
                "2 tbsp teriyaki sauce",
                "1 tsp sesame oil",
                "Garlic and ginger"
            ],
            instructions: [
                "Cook rice according to package",
                "Slice beef into thin strips",
                "Stir-fry beef until browned",
                "Add vegetables and cook until tender",
                "Add sauce and serve over rice"
            ],
            prepTime: 30,
            restrictions: [.dairyFree, .nutFree]
        ),
        
        Meal(
            name: "Baked Salmon with Quinoa",
            imageName: "dinner2",
            calories: 550,
            protein: 40,
            carbs: 45,
            fats: 20,
            mealType: .dinner,
            ingredients: [
                "6 oz salmon fillet",
                "1 cup cooked quinoa",
                "Asparagus spears",
                "Lemon",
                "Olive oil",
                "Herbs and spices"
            ],
            instructions: [
                "Preheat oven to 400°F",
                "Season salmon with herbs",
                "Bake salmon for 15-18 minutes",
                "Steam asparagus",
                "Serve with quinoa and lemon"
            ],
            prepTime: 25,
            restrictions: [.dairyFree, .glutenFree, .nutFree]
        ),
        
        // Vegetarian/Vegan Options
        Meal(
            name: "Chickpea Buddha Bowl",
            imageName: "vegetarian1",
            calories: 490,
            protein: 22,
            carbs: 68,
            fats: 16,
            mealType: .lunch,
            ingredients: [
                "1 cup roasted chickpeas",
                "1 cup cooked brown rice",
                "Mixed greens",
                "Roasted vegetables",
                "Tahini dressing",
                "Pumpkin seeds"
            ],
            instructions: [
                "Roast chickpeas with spices",
                "Cook brown rice",
                "Roast mixed vegetables",
                "Assemble bowl with all ingredients",
                "Drizzle with tahini dressing"
            ],
            prepTime: 35,
            restrictions: [.vegetarian, .vegan, .dairyFree, .nutFree, .glutenFree]
        ),
        
        Meal(
            name: "Tofu Scramble",
            imageName: "vegetarian2",
            calories: 380,
            protein: 28,
            carbs: 30,
            fats: 18,
            mealType: .breakfast,
            ingredients: [
                "200g firm tofu",
                "Spinach",
                "Mushrooms",
                "Nutritional yeast",
                "Turmeric",
                "Whole grain toast"
            ],
            instructions: [
                "Crumble tofu into pan",
                "Add turmeric for color",
                "Sauté with vegetables",
                "Season with nutritional yeast",
                "Serve with toast"
            ],
            prepTime: 15,
            restrictions: [.vegetarian, .vegan, .dairyFree, .nutFree]
        ),
        
        // Snack Options
        Meal(
            name: "Protein Smoothie",
            imageName: "snack1",
            calories: 320,
            protein: 30,
            carbs: 35,
            fats: 8,
            mealType: .snack,
            ingredients: [
                "1 scoop whey protein",
                "1 banana",
                "1 cup almond milk",
                "1 tbsp peanut butter",
                "Ice cubes",
                "Spinach (optional)"
            ],
            instructions: [
                "Add all ingredients to blender",
                "Blend until smooth",
                "Add ice as needed",
                "Serve immediately"
            ],
            prepTime: 5,
            restrictions: [.vegetarian, .glutenFree]
        ),
        
        Meal(
            name: "Rice Cakes with Almond Butter",
            imageName: "snack2",
            calories: 280,
            protein: 12,
            carbs: 32,
            fats: 14,
            mealType: .snack,
            ingredients: [
                "2 brown rice cakes",
                "2 tbsp almond butter",
                "1/2 sliced banana",
                "Cinnamon",
                "Honey drizzle"
            ],
            instructions: [
                "Spread almond butter on rice cakes",
                "Top with banana slices",
                "Sprinkle with cinnamon",
                "Drizzle with honey"
            ],
            prepTime: 3,
            restrictions: [.vegetarian, .vegan, .dairyFree, .glutenFree]
        ),
        
        // Pre/Post Workout
        Meal(
            name: "Pre-Workout Oats",
            imageName: "preworkout1",
            calories: 350,
            protein: 15,
            carbs: 55,
            fats: 8,
            mealType: .preworkout,
            ingredients: [
                "1 cup oatmeal",
                "1 banana",
                "1 tbsp honey",
                "Cinnamon",
                "1/2 scoop protein powder"
            ],
            instructions: [
                "Cook oatmeal with water or milk",
                "Mix in protein powder",
                "Top with sliced banana",
                "Drizzle with honey",
                "Sprinkle cinnamon"
            ],
            prepTime: 10,
            restrictions: [.vegetarian, .nutFree]
        ),
        
        Meal(
            name: "Post-Workout Shake",
            imageName: "postworkout1",
            calories: 400,
            protein: 40,
            carbs: 45,
            fats: 6,
            mealType: .postworkout,
            ingredients: [
                "1.5 scoops whey protein",
                "1 cup white rice (cooked)",
                "Water or skim milk",
                "1 tsp honey"
            ],
            instructions: [
                "Blend cooked rice with liquid",
                "Add protein powder",
                "Add honey for sweetness",
                "Blend until smooth",
                "Consume within 30 minutes post-workout"
            ],
            prepTime: 5,
            restrictions: [.vegetarian, .nutFree]
        )
    ]
    
    // Helpert , obtains the meals as per dietary restrictions
    static func getMealsForRestrictions(_ restrictions: Set<DietaryRestriction>) -> [Meal] {
        return meals.filter { meal in
            meal.fitsDietaryRestrictions(restrictions)
        }
    }
    
    // Helper, to get meals by type
    static func getMealsByType(_ type: MealType) -> [Meal] {
        return meals.filter { $0.mealType == type }
    }
}
