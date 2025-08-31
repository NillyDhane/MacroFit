import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    @EnvironmentObject var viewModel: UserProfileViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Hero Image
                heroImage
                
                // Meal Title and Type
                headerSection
                
                // Nutrition Overview
                nutritionOverview
                
                // Macro Breakdown with Custom Layout
                macroBreakdownSection
                
                // Tab Selection
                tabSelector
                
                // Content based on tab
                if selectedTab == 0 {
                    ingredientsSection
                } else {
                    instructionsSection
                }
                
                // Dietary Information
                dietaryInfoSection
            }
            .padding(.bottom, 30)
        }
        .navigationTitle(meal.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - View Components
    
    private var heroImage: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.4),
                    Color.purple.opacity(0.4)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 10) {
                Image(systemName: mealTypeIcon)
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                
                Text(meal.mealType.rawValue)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
    }
    
    private var headerSection: some View {
        VStack(spacing: 10) {
            Text(meal.name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 20) {
                // Prep Time
                HStack(spacing: 5) {
                    Image(systemName: "clock")
                        .foregroundColor(.blue)
                    Text("\(meal.prepTime) minutes")
                        .foregroundColor(.secondary)
                }
                
                // Serving
                HStack(spacing: 5) {
                    Image(systemName: "person")
                        .foregroundColor(.green)
                    Text("1 serving")
                        .foregroundColor(.secondary)
                }
            }
            .font(.caption)
        }
    }
    
    private var nutritionOverview: some View {
        VStack(spacing: 15) {
            // Calories
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Total Calories")
                        .font(.headline)
                    Text("\(percentageOfDaily)% of your daily goal")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("\(meal.calories)")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.orange)
                + Text(" cal")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            // Fit to Goal Indicator
            HStack {
                Image(systemName: fitToGoalIcon)
                    .foregroundColor(fitToGoalColor)
                Text(fitToGoalText)
                    .font(.body)
                Spacer()
            }
            .padding()
            .background(fitToGoalColor.opacity(0.1))
            .cornerRadius(12)
        }
        .padding(.horizontal)
    }
    
    private var macroBreakdownSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Macro Breakdown")
                .font(.headline)
                .padding(.horizontal)
            
            // Using Custom Layout Here
            MacroBreakdownLayout {
                MacroBreakdownItem(
                    title: "Protein",
                    grams: meal.protein,
                    percentage: meal.proteinPercentage,
                    color: .red
                )
                
                MacroBreakdownItem(
                    title: "Carbs",
                    grams: meal.carbs,
                    percentage: meal.carbsPercentage,
                    color: .blue
                )
                
                MacroBreakdownItem(
                    title: "Fats",
                    grams: meal.fats,
                    percentage: meal.fatsPercentage,
                    color: .green
                )
            }
            .padding(.horizontal)
        }
    }
    
    private var tabSelector: some View {
        Picker("Content", selection: $selectedTab) {
            Text("Ingredients").tag(0)
            Text("Instructions").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }
    
    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Ingredients")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(meal.ingredients, id: \.self) { ingredient in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .foregroundColor(.secondary)
                            .padding(.top, 6)
                        
                        Text(ingredient)
                            .font(.body)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Instructions")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 15) {
                ForEach(Array(meal.instructions.enumerated()), id: \.offset) { index, instruction in
                    HStack(alignment: .top, spacing: 15) {
                        Text("\(index + 1)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .background(Circle().fill(Color.blue))
                        
                        Text(instruction)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    private var dietaryInfoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Dietary Information")
                .font(.headline)
            
            if meal.restrictions.isEmpty {
                Text("This meal has no specific dietary restrictions")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                FlowLayout(spacing: 8) {
                    ForEach(Array(meal.restrictions), id: \.self) { restriction in
                        DietaryTag(restriction: restriction)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    // MARK: - Computed Properties
    
    private var percentageOfDaily: Int {
        return Int((Double(meal.calories) / Double(viewModel.userProfile.targetCalories)) * 100)
    }
    
    private var fitToGoalIcon: String {
        if percentageOfDaily <= 30 {
            return "checkmark.circle.fill"
        } else if percentageOfDaily <= 40 {
            return "exclamationmark.circle.fill"
        } else {
            return "xmark.circle.fill"
        }
    }
    
    private var fitToGoalColor: Color {
        if percentageOfDaily <= 30 {
            return .green
        } else if percentageOfDaily <= 40 {
            return .orange
        } else {
            return .red
        }
    }
    
    private var fitToGoalText: String {
        if percentageOfDaily <= 30 {
            return "Great fit for your daily goals!"
        } else if percentageOfDaily <= 40 {
            return "Moderate portion of daily calories"
        } else {
            return "High calorie meal - plan accordingly"
        }
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
}

// MARK: - Supporting Views

struct MacroBreakdownItem: View {
    let title: String
    let grams: Int
    let percentage: Double
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(color.opacity(0.3), lineWidth: 8)
                    .frame(width: 80, height: 80)
                
                Circle()
                    .trim(from: 0, to: percentage / 100)
                    .stroke(color, lineWidth: 8)
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(-90))
                
                VStack(spacing: 2) {
                    Text("\(grams)g")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(Int(percentage))%")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
        }
    }
}

struct DietaryTag: View {
    let restriction: DietaryRestriction
    
    var body: some View {
        Text(restriction.rawValue)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.green.opacity(0.2))
            .foregroundColor(.green)
            .cornerRadius(15)
    }
}

// Simple Flow Layout for dietary tags
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return CGSize(width: proposal.replacingUnspecifiedDimensions().width, height: result.height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: result.positions[index].x + bounds.minX,
                                     y: result.positions[index].y + bounds.minY),
                         proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var positions: [CGPoint] = []
        var height: CGFloat = 0
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var rowHeight: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                if x + size.width > maxWidth, x > 0 {
                    x = 0
                    y += rowHeight + spacing
                    rowHeight = 0
                }
                positions.append(CGPoint(x: x, y: y))
                x += size.width + spacing
                rowHeight = max(rowHeight, size.height)
            }
            height = y + rowHeight
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealDetailView(meal: MockData.meals[0])
                .environmentObject(UserProfileViewModel())
        }
    }
}
