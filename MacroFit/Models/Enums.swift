import Foundation
import SwiftUI

// Activity levels for TDEE calculation
enum ActivityLevel: String, CaseIterable {
    case sedentary = "Sedentary"
    case lightlyActive = "Lightly Active"
    case moderatelyActive = "Moderately Active"
    case veryActive = "Very Active"
    case extremelyActive = "Extremely Active"
    
    var multiplier: Double {
        switch self {
        case .sedentary: return 1.2
        case .lightlyActive: return 1.375
        case .moderatelyActive: return 1.55
        case .veryActive: return 1.725
        case .extremelyActive: return 1.9
        }
    }
    
    var description: String {
        switch self {
        case .sedentary: return "Little or no exercise"
        case .lightlyActive: return "Exercise 1-3 days/week"
        case .moderatelyActive: return "Exercise 3-5 days/week"
        case .veryActive: return "Exercise 6-7 days/week"
        case .extremelyActive: return "Very hard exercise daily"
        }
    }
}

// Gender for TDEE calculation
enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}

// Fitness goals
enum FitnessGoal: String, CaseIterable, Identifiable {
    case cutting = "Cutting"
    case maintenance = "Maintenance"
    case bulking = "Bulking"

    var id: String { self.rawValue }

    var color: Color {
        switch self {
        case .cutting: return .red
        case .maintenance: return .blue
        case .bulking: return .green
        }
    }

    var calorieAdjustment: Int {
        switch self {
        case .cutting: return -500
        case .maintenance: return 0
        case .bulking: return 500
        }
    }
}

// Dietary restrictions
enum DietaryRestriction: String, CaseIterable {
    case none = "None"
    case vegetarian = "Vegetarian"
    case vegan = "Vegan"
    case glutenFree = "Gluten Free"
    case dairyFree = "Dairy Free"
    case nutFree = "Nut Free"
    case lowCarb = "Low Carb"
    case keto = "Keto"
}
