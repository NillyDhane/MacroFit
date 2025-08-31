import Foundation

struct Meal: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let calories: Int
    let protein: Int  // grams
    let carbs: Int    // grams
    let fats: Int     // grams
    let mealType: MealType
    let ingredients: [String]
    let instructions: [String]
    let prepTime: Int  // minutes
    let restrictions: Set<DietaryRestriction>
    
    // Calculations for macro percentages to disp on screen
    var proteinPercentage: Double {
        let proteinCals = Double(protein * 4)
        return (proteinCals / Double(calories)) * 100
    }
    
    var carbsPercentage: Double {
        let carbsCals = Double(carbs * 4)
        return (carbsCals / Double(calories)) * 100
    }
    
    var fatsPercentage: Double {
        let fatsCals = Double(fats * 9)
        return (fatsCals / Double(calories)) * 100
    }
    
    // Check if meal fits dietary restrictions
    func fitsDietaryRestrictions(_ userRestrictions: Set<DietaryRestriction>) -> Bool {
        // If user has no restrictions, all meals are fine
        if userRestrictions.isEmpty || userRestrictions.contains(.none) {
            return true
        }
        
        // Check if meal's restrictions are compatible with user's restrictions
        for userRestriction in userRestrictions {
            if !restrictions.contains(userRestriction) && userRestriction != .none {
                // Meal doesn't meet this restriction
                return false
            }
        }
        return true
    }
}

enum MealType: String, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
    case preworkout = "Pre-Workout"
    case postworkout = "Post-Workout"
}
