import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject var viewModel: UserProfileViewModel
    @State private var selectedRestrictions = Set<DietaryRestriction>()
    @State private var showingMealList = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Info
            headerSection
            
            // Preferences List
            Form {
                Section(header: Text("Dietary Restrictions")) {
                    ForEach(DietaryRestriction.allCases, id: \.self) { restriction in
                        if restriction != .none {
                            PreferenceRow(
                                restriction: restriction,
                                isSelected: selectedRestrictions.contains(restriction),
                                action: { toggleRestriction(restriction) }
                            )
                        }
                    }
                }
                
                Section(header: Text("Selected Preferences")) {
                    if selectedRestrictions.isEmpty {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("No restrictions - all meals available!")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 5)
                    } else {
                        ForEach(Array(selectedRestrictions), id: \.self) { restriction in
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text(restriction.rawValue)
                                    .font(.body)
                            }
                            .padding(.vertical, 2)
                        }
                    }
                }
                
                Section(header: Text("Meal Compatibility")) {
                    let compatibleMeals = MockData.getMealsForRestrictions(selectedRestrictions)
                    
                    HStack {
                        Image(systemName: "fork.knife.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(compatibleMeals.count) Meals Available")
                                .font(.headline)
                            Text("Based on your preferences")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 5)
                }
            }
            
            // Continue Button
            bottomSection
        }
        .navigationTitle("Dietary Preferences")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            selectedRestrictions = viewModel.userProfile.dietaryRestrictions
        }
        .onChange(of: selectedRestrictions) { _, newValue in
            viewModel.userProfile.dietaryRestrictions = newValue
            viewModel.filterMeals()
        }
    }
    
    // MARK: - View Components
    
    private var headerSection: some View {
        VStack(spacing: 10) {
            Image(systemName: "leaf.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.green)
            
            Text("Customize Your Meal Plan")
                .font(.headline)
            
            Text("Select any dietary restrictions or preferences")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var bottomSection: some View {
        VStack(spacing: 15) {
            NavigationLink(destination: MealListView()) {
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                    Text("View Recommended Meals")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
            }
            
            Text("You can change these preferences anytime")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
    }
    
    private func toggleRestriction(_ restriction: DietaryRestriction) {
        if selectedRestrictions.contains(restriction) {
            selectedRestrictions.remove(restriction)
        } else {
            // If selecting a new restriction, remove "none" if it exists
            selectedRestrictions.remove(.none)
            selectedRestrictions.insert(restriction)
        }
        
        // If no restrictions selected, add "none"
        if selectedRestrictions.isEmpty {
            selectedRestrictions.insert(.none)
        }
    }
}

struct PreferenceRow: View {
    let restriction: DietaryRestriction
    let isSelected: Bool
    let action: () -> Void
    
    var iconName: String {
        switch restriction {
        case .vegetarian: return "leaf.fill"
        case .vegan: return "leaf.circle.fill"
        case .glutenFree: return "g.circle.fill"
        case .dairyFree: return "d.circle.fill"
        case .nutFree: return "n.circle.fill"
        case .lowCarb: return "arrow.down.circle.fill"
        case .keto: return "k.circle.fill"
        case .none: return "checkmark.circle"
        }
    }
    
    var iconColor: Color {
        switch restriction {
        case .vegetarian, .vegan: return .green
        case .glutenFree: return .orange
        case .dairyFree: return .blue
        case .nutFree: return .red
        case .lowCarb, .keto: return .purple
        case .none: return .gray
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .font(.title3)
                    .foregroundColor(iconColor)
                    .frame(width: 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(restriction.rawValue)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Text(restrictionDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .padding(.vertical, 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var restrictionDescription: String {
        switch restriction {
        case .vegetarian: return "No meat or fish"
        case .vegan: return "No animal products"
        case .glutenFree: return "No gluten-containing grains"
        case .dairyFree: return "No milk products"
        case .nutFree: return "No tree nuts or peanuts"
        case .lowCarb: return "Limited carbohydrates"
        case .keto: return "Very low carb, high fat"
        case .none: return "All foods allowed"
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PreferencesView()
                .environmentObject(UserProfileViewModel())
        }
    }
}
