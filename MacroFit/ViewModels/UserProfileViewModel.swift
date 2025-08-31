import Foundation
import SwiftUI

class UserProfileViewModel: ObservableObject {
    @Published var userProfile = UserProfile()
    @Published var hasCalculatedTDEE = false
    @Published var selectedGoal: FitnessGoal = .maintenance
    @Published var filteredMeals: [Meal] = []
    
    // Input validation
    var isValidInput: Bool {
        userProfile.age > 0 && userProfile.age < 120 &&
        userProfile.weight > 20 && userProfile.weight < 300 &&
        userProfile.height > 100 && userProfile.height < 250
    }
    
    // Calculate TDEE and set the flag
    func calculateTDEE() {
        if isValidInput {
            hasCalculatedTDEE = true
        }
    }
    
    // Reset calculation
    func resetCalculation() {
        hasCalculatedTDEE = false
        userProfile = UserProfile()
    }
    
    // Update user goal
    func updateGoal(_ goal: FitnessGoal) {
        userProfile.goal = goal
        selectedGoal = goal
    }
    
    // Get calories for a specific goal
    func getCaloriesForGoal(_ goal: FitnessGoal) -> Int {
        return userProfile.tdee + goal.calorieAdjustment
    }
    
    // Get macros for a specific goal
    func getMacrosForGoal(_ goal: FitnessGoal) -> Macros {
        let tempProfile = userProfile
        var modifiedProfile = tempProfile
        modifiedProfile.goal = goal
        return modifiedProfile.macros
    }
    
    // Filter meals based on dietary restrictions
    func filterMeals() {
        filteredMeals = MockData.getMealsForRestrictions(userProfile.dietaryRestrictions)
    }
    
    // Get meal recommendations based on calories and meal type
    func getRecommendedMeals(for mealType: MealType? = nil) -> [Meal] {
        var meals = filteredMeals.isEmpty ? MockData.meals : filteredMeals
        
        if let type = mealType {
            meals = meals.filter { $0.mealType == type }
        }
        
        // Sort by how close they are to ideal calories per meal
        let idealCaloriesPerMeal = userProfile.targetCalories / 4
        
        return meals.sorted { meal1, meal2 in
            let diff1 = abs(meal1.calories - idealCaloriesPerMeal)
            let diff2 = abs(meal2.calories - idealCaloriesPerMeal)
            return diff1 < diff2
        }
    }
    
    // Calculate daily meal plan
    func generateDailyMealPlan() -> [Meal] {
        var dailyPlan: [Meal] = []
        var remainingCalories = userProfile.targetCalories
        var remainingProtein = userProfile.macros.protein
        
        // Try to get one of each meal type
        let mealTypes: [MealType] = [.breakfast, .lunch, .dinner, .snack]
        
        for mealType in mealTypes {
            let mealsOfType = getRecommendedMeals(for: mealType)
            
            if let bestMeal = mealsOfType.first(where: { meal in
                meal.calories <= remainingCalories &&
                meal.protein <= remainingProtein
            }) {
                dailyPlan.append(bestMeal)
                remainingCalories -= bestMeal.calories
                remainingProtein -= bestMeal.protein
            }
        }
        
        return dailyPlan
    }
}
