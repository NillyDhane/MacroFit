import Foundation

struct UserProfile {
    var age: Int = 25
    var weight: Double = 70.0  // kg
    var height: Double = 170.0  // cm
    var activityLevel: ActivityLevel = .moderatelyActive
    var gender: Gender = .male
    var goal: FitnessGoal = .maintenance
    var dietaryRestrictions: Set<DietaryRestriction> = []
    
    // Calculate BMR using Mifflin-St Jeor equation
    var bmr: Double {
        switch gender {
        case .male, .other:
            return (10 * weight) + (6.25 * height) - (5 * Double(age)) + 5
        case .female:
            return (10 * weight) + (6.25 * height) - (5 * Double(age)) - 161
        }
    }
    
    // Calculate TDEE (Total Daily Energy Expenditure)
    var tdee: Int {
        return Int(bmr * activityLevel.multiplier)
    }
    
    // Target calories based on chosen goal, cut, maintenance or bulk
    var targetCalories: Int {
        return tdee + goal.calorieAdjustment
    }
    
    // Macro breakdown (grams)
    var macros: Macros {
        let calories = Double(targetCalories)
        
        switch goal {
        case .cutting:
            // Higher protein 
            let protein = weight * 2.2  // 1g per lb
            let fats = weight * 0.8      // 0.35-0.4g per lb
            let proteinCals = protein * 4
            let fatCals = fats * 9
            let carbCals = calories - proteinCals - fatCals
            let carbs = carbCals / 4
            
            return Macros(
                protein: Int(protein),
                carbs: Int(max(carbs, 0)),
                fats: Int(fats),
                calories: targetCalories
            )
            
        case .maintenance:
            // Balanced macros
            let protein = weight * 1.8
            let fats = weight * 1.0
            let proteinCals = protein * 4
            let fatCals = fats * 9
            let carbCals = calories - proteinCals - fatCals
            let carbs = carbCals / 4
            
            return Macros(
                protein: Int(protein),
                carbs: Int(carbs),
                fats: Int(fats),
                calories: targetCalories
            )
            
        case .bulking:
            // Higher carbs for energy
            let protein = weight * 1.6
            let fats = weight * 1.2
            let proteinCals = protein * 4
            let fatCals = fats * 9
            let carbCals = calories - proteinCals - fatCals
            let carbs = carbCals / 4
            
            return Macros(
                protein: Int(protein),
                carbs: Int(carbs),
                fats: Int(fats),
                calories: targetCalories
            )
        }
    }
}

struct Macros {
    let protein: Int
    let carbs: Int
    let fats: Int
    let calories: Int
    
    var proteinPercentage: Double {
        guard calories > 0 else { return 0 }
        return Double(protein * 4) / Double(calories) * 100
    }

    var carbsPercentage: Double {
        guard calories > 0 else { return 0 }
        return Double(carbs * 4) / Double(calories) * 100
    }

    var fatsPercentage: Double {
        guard calories > 0 else { return 0 }
        return Double(fats * 9) / Double(calories) * 100
    }
}

//Double check the macro counts using Macrofactor and MFP's calculator on my own phone,
//Considering to add various options like TDEE calculators options to have higher carb/higher protein/lower fat etc options

