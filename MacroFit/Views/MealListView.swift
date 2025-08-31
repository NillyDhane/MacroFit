import SwiftUI

struct MealListView: View {
    @EnvironmentObject var viewModel: UserProfileViewModel
    @State private var selectedMealType: MealType? = nil
    @State private var searchText = ""
    
    var filteredMeals: [Meal] {
        let meals = viewModel.filteredMeals.isEmpty ? MockData.meals : viewModel.filteredMeals
        
        var result = meals
        
        // Filter by meal type if selected
        if let mealType = selectedMealType {
            result = result.filter { $0.mealType == mealType }
        }
        
        // Filter by search text
        if !searchText.isEmpty {
            result = result.filter { meal in
                meal.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Sorting by calories closest to ideal per meal
        let idealCaloriesPerMeal = viewModel.userProfile.targetCalories / 4
        return result.sorted { meal1, meal2 in
            let diff1 = abs(meal1.calories - idealCaloriesPerMeal)
            let diff2 = abs(meal2.calories - idealCaloriesPerMeal)
            return diff1 < diff2
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with stats
            headerSection
            
            // Meal Type Filter
            mealTypeFilter
            
            // Search Bar
            searchBar
            
            // Meals List
            ScrollView {
                LazyVStack(spacing: 15) {
                    if filteredMeals.isEmpty {
                        emptyStateView
                    } else {
                        ForEach(filteredMeals) { meal in
                            NavigationLink(destination: MealDetailView(meal: meal)) {
                                MealCardView(meal: meal, targetCalories: viewModel.userProfile.targetCalories)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Recommended Meals")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.filterMeals()
        }
    }
    
    // MARK: - View Components
    
    private var headerSection: some View {
        HStack(spacing: 20) {
            StatCard(
                title: "Daily Goal",
                value: "\(viewModel.userProfile.targetCalories)",
                unit: "cal",
                color: .blue
            )
            
            StatCard(
                title: "Protein Target",
                value: "\(viewModel.userProfile.macros.protein)",
                unit: "g",
                color: .red
            )
            
            StatCard(
                title: "Available Meals",
                value: "\(filteredMeals.count)",
                unit: "",
                color: .green
            )
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var mealTypeFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                // All meals option
                FilterChip(
                    title: "All Meals",
                    isSelected: selectedMealType == nil,
                    action: { selectedMealType = nil }
                )
                
                ForEach(MealType.allCases, id: \.self) { type in
                    FilterChip(
                        title: type.rawValue,
                        isSelected: selectedMealType == type,
                        action: { selectedMealType = type }
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 10)
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search meals...", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No meals found")
                .font(.headline)
            
            Text("Try adjusting your filters or dietary preferences")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(50)
    }
}

// MARK: - Supporting Views

struct StatCard: View {
    let title: String
    let value: String
    let unit: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            HStack(spacing: 2) {
                Text(value)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                Text(unit)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(15)
        }
    }
}

struct MealCardView: View {
    let meal: Meal
    let targetCalories: Int
    
    var caloriePercentage: Double {
        return (Double(meal.calories) / Double(targetCalories)) * 100
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Card Content
            HStack(spacing: 15) {
                // Meal Image Placeholder
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(
                        colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: mealTypeIcon)
                            .font(.title)
                            .foregroundColor(.white)
                    )
                
                // Meal Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(meal.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    HStack(spacing: 15) {
                        // Calories
                        HStack(spacing: 4) {
                            Image(systemName: "flame.fill")
                                .font(.caption)
                                .foregroundColor(.orange)
                            Text("\(meal.calories) cal")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        
                        // Prep Time
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.caption)
                                .foregroundColor(.blue)
                            Text("\(meal.prepTime) min")
                                .font(.caption)
                        }
                    }
                    
                    // Macro Pills
                    HStack(spacing: 8) {
                        MacroPill(value: meal.protein, unit: "P", color: .red)
                        MacroPill(value: meal.carbs, unit: "C", color: .blue)
                        MacroPill(value: meal.fats, unit: "F", color: .green)
                    }
                }
                
                Spacer()
                
                // Right Side Info
                VStack(alignment: .trailing, spacing: 8) {
                    Text("\(Int(caloriePercentage))%")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("of daily")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            
            // Calorie Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(height: 3)
                    
                    Rectangle()
                        .fill(calorieBarColor)
                        .frame(width: min(geometry.size.width * (caloriePercentage / 100), geometry.size.width), height: 3)
                }
            }
            .frame(height: 3)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    private var mealTypeIcon: String {
        switch meal.mealType {
        case .breakfast: return "sun.max.fill"
        case .lunch: return "sun.min.fill"
        case .dinner: return "moon.fill"
        case .snack: return "star.fill"
        case .preworkout: return "bolt.fill"
        case .postworkout: return "figure.run"
        }
    }
    
    private var calorieBarColor: Color {
        if caloriePercentage <= 25 {
            return .green
        } else if caloriePercentage <= 35 {
            return .orange
        } else {
            return .red
        }
    }
}

struct MacroPill: View {
    let value: Int
    let unit: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 2) {
            Text("\(value)g")
                .font(.caption2)
                .fontWeight(.medium)
            Text(unit)
                .font(.caption2)
                .fontWeight(.bold)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.2))
        .foregroundColor(color)
        .cornerRadius(8)
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealListView()
                .environmentObject(UserProfileViewModel())
        }
    }
}
